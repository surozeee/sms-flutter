import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'dart:convert';
import '../../core/providers/auth_provider.dart';
import '../../core/models/content_create_request.dart';
import '../../services/image_service.dart';

class ContentManagementScreen extends ConsumerStatefulWidget {
  const ContentManagementScreen({super.key});

  @override
  ConsumerState<ContentManagementScreen> createState() => _ContentManagementScreenState();
}

class _ContentManagementScreenState extends ConsumerState<ContentManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _textController = TextEditingController();
  String _contentType = 'text';
  File? _selectedImage;
  String? _imageBase64;
  String? _imageFilename;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final image = await ImageService.pickImageFromGallery();
      if (image != null) {
        final file = File(image.path);
        // Convert image to base64
        final bytes = await file.readAsBytes();
        final base64String = base64Encode(bytes);
        final filename = image.path.split('/').last;
        
        setState(() {
          _selectedImage = file;
          _imageBase64 = base64String;
          _imageFilename = filename;
          _contentType = 'image';
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _createContent() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Determine contentType for API (TEXT or IMAGE)
        final apiContentType = _contentType == 'text' ? 'TEXT' : 'IMAGE';
        
        // Create request based on content type
        final request = ContentCreateRequest(
          contentType: apiContentType,
          title: _titleController.text.trim(),
          textContent: _textController.text.trim(),
          imageBase64: _contentType == 'image' ? _imageBase64 : null,
          imageFilename: _contentType == 'image' ? _imageFilename : null,
        );

        // Call the API using the provider
        final contentNotifier = ref.read(contentCreateProvider.notifier);
        final response = await contentNotifier.createContent(request);

        // Check if creation was successful
        if (response.status == 'SUCCESS' && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Content created successfully'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Failed to create content'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          final errorMessage = e is String ? e : e.toString();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Content'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                initialValue: _contentType,
                decoration: const InputDecoration(
                  labelText: 'Content Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'text', child: Text('Text')),
                  DropdownMenuItem(value: 'image', child: Text('Image')),
                ],
                onChanged: (value) {
                  setState(() {
                    _contentType = value ?? 'text';
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (_contentType == 'text' || _contentType == 'image')
                TextFormField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Text Content',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
              if (_contentType == 'image') ...[
                const SizedBox(height: 16),
                if (_selectedImage != null)
                  Image.file(
                    _selectedImage!,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                else
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text('Select Image'),
                  ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _createContent,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Create & Push Content', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

