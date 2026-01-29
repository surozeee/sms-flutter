import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'dart:convert';

import '../../core/api/api_endpoints.dart';
import '../../core/models/content_create_request.dart';
import '../../core/providers/auth_provider.dart';
import '../../services/image_service.dart';

// ---------------------------------------------------------------------------
// Enums & State
// ---------------------------------------------------------------------------

enum ContentType { text, image }

enum CreationMethod { manual, ai }

/// A single AI-generated title/description option for the dialog.
class GeneratedTextOption {
  final String title;
  final String description;
  const GeneratedTextOption({required this.title, required this.description});
}

class AppState {
  final ContentType contentType;
  final CreationMethod creationMethod;
  final bool isGenerating;
  final bool isGeneratingText;
  final bool isGeneratingImage;
  final String? generatedHeadline;
  final String? generatedDescription;
  final String? generatedImageUrl;
  final String? generatedImageBase64; // Base64 string for generated image

  /// List of title/description options from AI Magic dialog generation.
  final List<GeneratedTextOption>? generatedTextOptions;

  const AppState({
    this.contentType = ContentType.text,
    this.creationMethod = CreationMethod.manual,
    this.isGenerating = false,
    this.isGeneratingText = false,
    this.isGeneratingImage = false,
    this.generatedHeadline,
    this.generatedDescription,
    this.generatedImageUrl,
    this.generatedImageBase64,
    this.generatedTextOptions,
  });

  AppState copyWith({
    ContentType? contentType,
    CreationMethod? creationMethod,
    bool? isGenerating,
    bool? isGeneratingText,
    bool? isGeneratingImage,
    String? generatedHeadline,
    String? generatedDescription,
    String? generatedImageUrl,
    String? generatedImageBase64,
    List<GeneratedTextOption>? generatedTextOptions,
  }) {
    return AppState(
      contentType: contentType ?? this.contentType,
      creationMethod: creationMethod ?? this.creationMethod,
      isGenerating: isGenerating ?? this.isGenerating,
      isGeneratingText: isGeneratingText ?? this.isGeneratingText,
      isGeneratingImage: isGeneratingImage ?? this.isGeneratingImage,
      generatedHeadline: generatedHeadline ?? this.generatedHeadline,
      generatedDescription: generatedDescription ?? this.generatedDescription,
      generatedImageUrl: generatedImageUrl ?? this.generatedImageUrl,
      generatedImageBase64: generatedImageBase64 ?? this.generatedImageBase64,
      generatedTextOptions: generatedTextOptions ?? this.generatedTextOptions,
    );
  }
}

// ---------------------------------------------------------------------------
// Notifier (Riverpod 3 Notifier pattern)
// ---------------------------------------------------------------------------

final aiCreatorProvider =
    NotifierProvider<AiCreatorNotifier, AppState>(AiCreatorNotifier.new);

class AiCreatorNotifier extends Notifier<AppState> {
  @override
  AppState build() => const AppState();

  void setContentType(ContentType type) {
    state = state.copyWith(contentType: type);
  }

  void setCreationMethod(CreationMethod method) {
    state = state.copyWith(creationMethod: method);
  }

  Future<void> generate({
    required String contentPrompt,
    String? imagePrompt,
  }) async {
    state = state.copyWith(isGenerating: true);
    await Future.delayed(const Duration(seconds: 2));

    final headline =
        'Generated: ${contentPrompt.split(' ').take(3).join(' ')}...';
    final description =
        'AI-generated content based on your prompt. "$contentPrompt"';

    state = state.copyWith(
      isGenerating: false,
      generatedHeadline: headline,
      generatedDescription: description,
      generatedImageUrl: state.contentType == ContentType.image
          ? 'https://picsum.photos/400/300?random=${DateTime.now().millisecondsSinceEpoch}'
          : null,
    );
  }

  /// Generate text only (for Image + AI mode).
  Future<void> generateText(String contentPrompt) async {
    if (contentPrompt.trim().isEmpty) return;
    state = state.copyWith(isGeneratingText: true);
    await Future.delayed(const Duration(seconds: 2));
    final headline =
        'Generated: ${contentPrompt.split(' ').take(3).join(' ')}...';
    final description =
        'AI-generated content based on your prompt. "$contentPrompt"';
    state = state.copyWith(
      isGeneratingText: false,
      generatedHeadline: headline,
      generatedDescription: description,
    );
  }

  /// Generate image via API (for Image + AI mode).
  Future<void> generateImage({
    String? contentPrompt,
    String? imagePrompt,
    String? imageBase64,
  }) async {
    // Validation: either prompt or image must be provided
    if ((imagePrompt == null || imagePrompt.trim().isEmpty) &&
        (imageBase64 == null || imageBase64.trim().isEmpty)) {
      throw Exception('Either prompt or image must be provided');
    }

    state = state.copyWith(isGeneratingImage: true, generatedImageBase64: null);
    try {
      final dio = await ref.read(dioClientProvider.future);
      final requestData = <String, dynamic>{
        'aiPrompt': imagePrompt?.trim() ?? '',
      };
      if (imageBase64 != null && imageBase64.trim().isNotEmpty) {
        requestData['image'] = imageBase64.trim();
      }

      final response = await dio.postJson(
        ApiEndpoints.geminiGenerateImage,
        data: requestData,
      );

      final body = response.data as Map<String, dynamic>?;
      final data = body?['data'] as Map<String, dynamic>?;
      final imageBase64Result = data?['imageBase64'] as String?;

      state = state.copyWith(
        isGeneratingImage: false,
        generatedImageBase64: imageBase64Result,
      );
    } catch (_) {
      state =
          state.copyWith(isGeneratingImage: false, generatedImageBase64: null);
      rethrow;
    }
  }

  /// Generate multiple title/description options for the AI Magic dialog via API.
  Future<void> generateTextOptionsForDialog(String prompt) async {
    if (prompt.trim().isEmpty) return;
    state = state.copyWith(isGenerating: true, generatedTextOptions: null);
    try {
      final dio = await ref.read(dioClientProvider.future);
      final response = await dio.postJson(
        ApiEndpoints.geminiGenerateText,
        data: {'aiPrompt': prompt.trim()},
      );
      final body = response.data as Map<String, dynamic>?;
      final data = body?['data'] as Map<String, dynamic>?;
      final suggestionsRaw = data?['suggestions'] as List<dynamic>? ?? [];
      final options = suggestionsRaw
          .map((s) {
            final m = s as Map<String, dynamic>?;
            if (m == null) return null;
            final title = m['title'] as String? ?? '';
            final description = m['description'] as String? ?? '';
            return GeneratedTextOption(title: title, description: description);
          })
          .whereType<GeneratedTextOption>()
          .toList();
      state = state.copyWith(
        isGenerating: false,
        generatedTextOptions: options.isEmpty ? null : options,
      );
    } catch (_) {
      state = state.copyWith(isGenerating: false, generatedTextOptions: null);
      rethrow;
    }
  }

  void clearGeneratedTextOptions() {
    state = state.copyWith(generatedTextOptions: null);
  }

  /// Reset to initial state and show loading (hide list) when regenerating.
  void startTextOptionsGeneration() {
    state = state.copyWith(isGenerating: true, generatedTextOptions: null);
  }
}

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

class AiContentCreatorScreen extends ConsumerStatefulWidget {
  const AiContentCreatorScreen({super.key});

  @override
  ConsumerState<AiContentCreatorScreen> createState() =>
      _AiContentCreatorScreenState();
}

class _AiContentCreatorScreenState
    extends ConsumerState<AiContentCreatorScreen> {
  final _headlineController = TextEditingController();
  final _descriptionController = TextEditingController();
  String?
      _selectedImageUrl; // Track the selected/uploaded image (URL, file path, or base64 data URI)

  @override
  void dispose() {
    _headlineController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final image = await ImageService.pickImageFromGallery();
      if (image != null && mounted) {
        setState(() {
          _selectedImageUrl = image.path; // Store file path
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Widget imageWidget;
    if (imageUrl.startsWith('data:image')) {
      try {
        final base64String = imageUrl.split(',').last;
        imageWidget = Image.memory(
          base64Decode(base64String),
          fit: BoxFit.contain,
        );
      } catch (_) {
        return;
      }
    } else if (imageUrl.startsWith('http://') ||
        imageUrl.startsWith('https://')) {
      imageWidget = Image.network(imageUrl, fit: BoxFit.contain);
    } else {
      imageWidget = Image.file(File(imageUrl), fit: BoxFit.contain);
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: const Text('Preview', style: TextStyle(color: Colors.white)),
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: imageWidget,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(String imageUrl) {
    // Check if it's a data URI (base64)
    if (imageUrl.startsWith('data:image')) {
      try {
        final base64String = imageUrl.split(',').last;
        return Image.memory(
          base64Decode(base64String),
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            height: 200,
            color: Colors.grey.shade300,
            child: const Center(
              child: Icon(Icons.broken_image, size: 48),
            ),
          ),
        );
      } catch (_) {
        return Container(
          height: 200,
          color: Colors.grey.shade300,
          child: const Center(
            child: Icon(Icons.broken_image, size: 48),
          ),
        );
      }
    }
    // Check if it's a network URL
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return Image.network(
        imageUrl,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: 200,
          color: Colors.grey.shade300,
          child: const Center(
            child: Icon(Icons.broken_image, size: 48),
          ),
        ),
      );
    }
    // Otherwise, treat as file path
    return Image.file(
      File(imageUrl),
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        height: 200,
        color: Colors.grey.shade300,
        child: const Center(
          child: Icon(Icons.broken_image, size: 48),
        ),
      ),
    );
  }

  void _syncFromState(AppState state) {
    if (state.generatedHeadline != null &&
        state.generatedHeadline != _headlineController.text) {
      _headlineController.text = state.generatedHeadline!;
    }
    if (state.generatedDescription != null &&
        state.generatedDescription != _descriptionController.text) {
      _descriptionController.text = state.generatedDescription!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(aiCreatorProvider);
    ref.listen<AppState>(aiCreatorProvider, (prev, next) {
      _syncFromState(next);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI based Content Creator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Top: SegmentedButton (Text / Image)
            SegmentedButton<ContentType>(
              segments: const [
                ButtonSegment(
                  value: ContentType.text,
                  icon: Icon(Icons.text_fields),
                  label: Text('Text'),
                ),
                ButtonSegment(
                  value: ContentType.image,
                  icon: Icon(Icons.image),
                  label: Text('Image'),
                ),
              ],
              selected: {appState.contentType},
              onSelectionChanged: (Set<ContentType> selected) {
                ref
                    .read(aiCreatorProvider.notifier)
                    .setContentType(selected.first);
              },
            ),
            const SizedBox(height: 24),

            // 2. Content: Text = headline + description + buttons; Image = single view
            if (appState.contentType == ContentType.text) ...[
              _buildTextContentFields(),
            ] else ...[
              _buildImageContentFields(appState),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPushContentButton() {
    final appState = ref.watch(aiCreatorProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: FilledButton.icon(
        onPressed: appState.contentType == ContentType.image
            ? () => _pushImageContent(context)
            : () => _pushContent(context),
        icon: const Icon(Icons.send),
        label: const Text('Push Content'),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  /// Text content type: headline, description, and horizontal Push Content + AI Magic buttons.
  Widget _buildTextContentFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _headlineController,
          decoration: const InputDecoration(
            labelText: 'Headline',
            border: OutlineInputBorder(),
            hintText: 'Enter headline',
          ),
          maxLines: 1,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
            hintText: 'Enter description',
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _showAiMagicDialog(context),
                icon: const Icon(Icons.auto_awesome),
                label: const Text('AI Magic'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: () => _pushContent(context),
                icon: const Icon(Icons.send),
                label: const Text('Push Content'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pushImageContent(BuildContext context) async {
    final title = _headlineController.text.trim();
    final description = _descriptionController.text.trim();

    // Validation
    if (title.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a title'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    if (description.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a description'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    if (_selectedImageUrl == null || _selectedImageUrl!.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload or generate an image'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    try {
      // Extract base64 and filename
      String imageBase64;
      String? imageFilename;

      if (_selectedImageUrl!.startsWith('data:image')) {
        // Base64 data URI (from generated image)
        imageBase64 = _selectedImageUrl!.split(',').last;
        imageFilename = null; // No filename for generated images
      } else if (_selectedImageUrl!.startsWith('http://') ||
          _selectedImageUrl!.startsWith('https://')) {
        // Network URL - not supported for image content
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Network images are not supported. Please upload or generate an image.'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      } else {
        // File path (from upload)
        final file = File(_selectedImageUrl!);
        if (!await file.exists()) {
          if (mounted) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Image file not found. Please upload again.'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }
        final bytes = await file.readAsBytes();
        imageBase64 = base64Encode(bytes);
        imageFilename = file.path.split('/').last; // Get filename
      }

      // Create request
      final request = ContentCreateRequest(
        contentType: 'IMAGE',
        title: title,
        textContent: description,
        imageBase64: imageBase64,
        imageFilename: imageFilename,
        aiPrompt: null,
      );

      // Call the API using the provider
      final contentNotifier = ref.read(contentCreateProvider.notifier);
      final response = await contentNotifier.createContent(request);

      // Check if creation was successful
      if (mounted) {
        // Clear previous snackbars
        ScaffoldMessenger.of(context).clearSnackBars();
        if (response.status == 'SUCCESS') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Content created successfully'),
              backgroundColor: Colors.green,
            ),
          );
          // Clear fields after successful creation
          _headlineController.clear();
          _descriptionController.clear();
          setState(() {
            _selectedImageUrl = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Failed to create content'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      // Handle any exceptions
      if (mounted) {
        // Clear previous snackbars
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${e.toString().replaceAll(RegExp(r'^Exception: '), '')}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pushContent(BuildContext context) async {
    final headline = _headlineController.text.trim();
    final description = _descriptionController.text.trim();

    // Validation
    if (headline.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a headline'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    if (description.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a description'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    try {
      // Create request
      final request = ContentCreateRequest(
        contentType: 'TEXT',
        title: headline,
        textContent: description,
        imageBase64: null,
        imageFilename: null,
        aiPrompt: null,
      );

      // Call the API using the provider
      final contentNotifier = ref.read(contentCreateProvider.notifier);
      final response = await contentNotifier.createContent(request);

      // Check if creation was successful
      if (mounted) {
        // Clear previous snackbars
        ScaffoldMessenger.of(context).clearSnackBars();
        if (response.status == 'SUCCESS') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Content created successfully'),
              backgroundColor: Colors.green,
            ),
          );
          // Clear fields after successful creation
          _headlineController.clear();
          _descriptionController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Failed to create content'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      // Handle any exceptions
      if (mounted) {
        // Clear previous snackbars
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${e.toString().replaceAll(RegExp(r'^Exception: '), '')}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showAiMagicDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => _AiMagicDialog(
        onApply: (String title, String description) {
          _headlineController.text = title;
          _descriptionController.text = description;
        },
      ),
    ).whenComplete(() {
      // Defer clearing so the dialog is fully removed before we update provider state.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(aiCreatorProvider.notifier).clearGeneratedTextOptions();
      });
    });
  }

  /// Image content type: Title, Description, AI Magic button, upload card with two buttons, Push Content.
  Widget _buildImageContentFields(AppState appState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _headlineController,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
            hintText: 'Enter title',
          ),
          maxLines: 1,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
            hintText: 'Enter description',
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 16),
        // AI Magic button below description
        OutlinedButton.icon(
          onPressed: () => _showAiMagicDialog(context),
          icon: const Icon(Icons.auto_awesome),
          label: const Text('AI Magic'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 16),
        // Show image if selected, otherwise show upload card
        if (_selectedImageUrl != null) ...[
          Stack(
            children: [
              GestureDetector(
                onTap: () => _showFullScreenImage(context, _selectedImageUrl!),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _buildImageWidget(_selectedImageUrl!),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedImageUrl = null;
                    });
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.9),
                  ),
                ),
              ),
            ],
          ),
        ] else ...[
          // Upload image card with two buttons
          Container(
            height: 160,
            child: CustomPaint(
              painter: _DashedBorderPainter(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _pickImageFromGallery,
                        icon: const Icon(Icons.cloud_upload_outlined),
                        label: const Text('Upload Image'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: appState.isGeneratingImage
                            ? null
                            : () => _showGenerateImageDialog(context),
                        icon: appState.isGeneratingImage
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.auto_awesome),
                        label: Text(
                          appState.isGeneratingImage
                              ? 'Generating...'
                              : 'Generate with AI',
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        _buildPushContentButton(),
      ],
    );
  }

  void _showGenerateImageDialog(BuildContext context) {
    final promptController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (ctx) => _GenerateImageDialog(
        promptController: promptController,
        contentPrompt: _headlineController.text.trim(),
        onDone: (String? imageBase64) {
          if (imageBase64 != null) {
            setState(() {
              // Store base64 as a data URI for display
              _selectedImageUrl = 'data:image/jpeg;base64,$imageBase64';
            });
          }
        },
      ),
    ).whenComplete(() => promptController.dispose());
  }
}

/// Dialog for Generate Image: prompt, upload image, Generate, show image, Continue button.
class _GenerateImageDialog extends ConsumerStatefulWidget {
  final TextEditingController promptController;
  final String contentPrompt;
  final void Function(String? imageBase64) onDone;

  const _GenerateImageDialog({
    required this.promptController,
    required this.contentPrompt,
    required this.onDone,
  });

  @override
  ConsumerState<_GenerateImageDialog> createState() =>
      _GenerateImageDialogState();
}

class _GenerateImageDialogState extends ConsumerState<_GenerateImageDialog> {
  String? _uploadedImageBase64;
  File? _uploadedImageFile;

  Future<void> _pickImageFromGallery() async {
    try {
      final image = await ImageService.pickImageFromGallery();
      if (image != null && mounted) {
        final file = File(image.path);
        final bytes = await file.readAsBytes();
        final base64String = base64Encode(bytes);
        setState(() {
          _uploadedImageFile = file;
          _uploadedImageBase64 = base64String;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static void _showFullScreenImageFromFile(BuildContext context, File file) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (ctx) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: const Text('Preview', style: TextStyle(color: Colors.white)),
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.file(file, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }

  static void _showFullScreenImageFromBase64(
      BuildContext context, String base64String) {
    try {
      final bytes = base64Decode(base64String);
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (ctx) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              title:
                  const Text('Preview', style: TextStyle(color: Colors.white)),
            ),
            body: Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.memory(bytes, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(aiCreatorProvider);
    final generatedImageBase64 = appState.generatedImageBase64;
    final isGenerating = appState.isGeneratingImage;

    return AlertDialog(
      title: const Text('Generate with AI'),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: widget.promptController,
                decoration: const InputDecoration(
                  labelText: 'Describe the image',
                  border: OutlineInputBorder(),
                  hintText: 'e.g. minimalist poster, vibrant landscape...',
                ),
                maxLines: 3,
                enabled: !isGenerating,
              ),
              const SizedBox(height: 16),
              // Upload image button
              OutlinedButton.icon(
                onPressed: isGenerating ? null : _pickImageFromGallery,
                icon: const Icon(Icons.image),
                label: Text(_uploadedImageFile != null
                    ? 'Image Selected'
                    : 'Upload Image from Gallery'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              if (_uploadedImageFile != null) ...[
                const SizedBox(height: 8),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () => _showFullScreenImageFromFile(
                          context, _uploadedImageFile!),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _uploadedImageFile!,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _uploadedImageFile = null;
                            _uploadedImageBase64 = null;
                          });
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          padding: const EdgeInsets.all(4),
                          minimumSize: const Size(32, 32),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: isGenerating
                    ? null
                    : () async {
                        final prompt = widget.promptController.text.trim();
                        // Validation: either prompt or image must be provided
                        if (prompt.isEmpty &&
                            (_uploadedImageBase64 == null ||
                                _uploadedImageBase64!.trim().isEmpty)) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter a prompt or upload an image',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          return;
                        }
                        try {
                          await ref
                              .read(aiCreatorProvider.notifier)
                              .generateImage(
                                contentPrompt: widget.contentPrompt,
                                imagePrompt: prompt.isEmpty ? null : prompt,
                                imageBase64: _uploadedImageBase64,
                              );
                        } catch (_) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Failed to generate image. Please try again.',
                                ),
                              ),
                            );
                          }
                        }
                      },
                icon: isGenerating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.auto_awesome),
                label: Text(isGenerating ? 'Generating...' : 'Generate'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              // Loader below Generate button
              if (isGenerating) ...[
                const SizedBox(height: 16),
                const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 12),
                      Text('Generating image...'),
                    ],
                  ),
                ),
              ],
              // Generated image from base64
              if (generatedImageBase64 != null && !isGenerating) ...[
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _showFullScreenImageFromBase64(
                      context, generatedImageBase64),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(
                      base64Decode(generatedImageBase64),
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 300,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 48),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        if (generatedImageBase64 != null && !isGenerating)
          FilledButton(
            onPressed: () {
              widget.onDone(generatedImageBase64);
              Navigator.of(context).pop();
            },
            child: const Text('Continue'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

/// Dialog for AI Magic: prompt, Generate, list of title/description options, Choose.
class _AiMagicDialog extends ConsumerStatefulWidget {
  final void Function(String title, String description) onApply;

  const _AiMagicDialog({
    required this.onApply,
  });

  @override
  ConsumerState<_AiMagicDialog> createState() => _AiMagicDialogState();
}

class _AiMagicDialogState extends ConsumerState<_AiMagicDialog> {
  int? _selectedIndex;
  late final TextEditingController _promptController;

  @override
  void initState() {
    super.initState();
    _promptController = TextEditingController();
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(aiCreatorProvider);
    final options = appState.generatedTextOptions;
    final hasResults = options != null && options.isNotEmpty;
    final isGenerating = appState.isGenerating;

    // Small height initially; expand only after results are loaded
    final contentHeight = hasResults ? 520.0 : 280.0;

    return AlertDialog(
      title: const Text('AI Magic'),
      content: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: SizedBox(
          width: 400,
          height: contentHeight,
          child: Column(
            mainAxisSize: hasResults ? MainAxisSize.max : MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _promptController,
                decoration: const InputDecoration(
                  labelText: 'Prompt',
                  border: OutlineInputBorder(),
                  hintText: 'Describe the content you want to generate...',
                ),
                maxLines: 3,
                enabled: !isGenerating,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: isGenerating
                    ? null
                    : () async {
                        final prompt = _promptController.text.trim();
                        if (prompt.isEmpty) return;
                        setState(() => _selectedIndex = null);
                        // Reset to initial state: show loading, hide list immediately
                        ref
                            .read(aiCreatorProvider.notifier)
                            .startTextOptionsGeneration();
                        try {
                          await ref
                              .read(aiCreatorProvider.notifier)
                              .generateTextOptionsForDialog(prompt);
                        } catch (_) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Failed to generate suggestions. Please try again.',
                                ),
                              ),
                            );
                          }
                        }
                      },
                icon: isGenerating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.auto_awesome),
                label: Text(isGenerating ? 'Generating...' : 'Generate'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              // Loader: show when generating (no results yet)
              if (isGenerating) ...[
                const SizedBox(height: 24),
                const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 12),
                      Text('Generating suggestions...'),
                    ],
                  ),
                ),
              ],
              // Results: only after generation is complete (hide list while generating)
              if (hasResults && !isGenerating) ...[
                const SizedBox(height: 20),
                const Text('Select one:',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, i) {
                      final opt = options[i];
                      final isSelected = _selectedIndex == i;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Material(
                          color: isSelected
                              ? Theme.of(context)
                                  .colorScheme
                                  .primaryContainer
                                  .withOpacity(0.5)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            onTap: () => setState(() => _selectedIndex = i),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    opt.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    opt.description,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade700),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _selectedIndex == null
                      ? null
                      : () {
                          final opt = options[_selectedIndex!];
                          widget.onApply(opt.title, opt.description);
                          Navigator.of(context).pop();
                        },
                  child: const Text('Choose'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

/// Paints a dashed border around the child.
class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 8.0;
    const dashSpace = 6.0;
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(1, 1, size.width - 2, size.height - 2),
      const Radius.circular(12),
    );

    final path = Path()..addRRect(rrect);
    Path dashPath = Path();
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final length = dashWidth.clamp(0, metric.length - distance);
        dashPath.addPath(
          metric.extractPath(distance, distance + length),
          Offset.zero,
        );
        distance += length + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
