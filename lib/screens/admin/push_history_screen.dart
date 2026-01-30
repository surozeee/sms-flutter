import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/models/contents_list_response.dart';
import '../../core/providers/auth_provider.dart';
import '../../widgets/content_card.dart';

class PushHistoryScreen extends ConsumerStatefulWidget {
  const PushHistoryScreen({super.key});

  @override
  ConsumerState<PushHistoryScreen> createState() => _PushHistoryScreenState();
}

class _PushHistoryScreenState extends ConsumerState<PushHistoryScreen> {
  int _page = 0;
  final int _size = 50;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMyContent();
    });
  }

  Future<void> _fetchMyContent() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      await ref.read(myContentListProvider.notifier).fetchMyContent(
            page: _page,
            size: _size,
          );
    } catch (e) {
      String errorMessage = 'Failed to fetch my content';

      if (e is DioException) {
        if (e.message != null && e.message!.isNotEmpty) {
          errorMessage = e.message!;
        } else if (e.response?.data != null) {
          final responseData = e.response!.data;
          if (responseData is Map<String, dynamic>) {
            errorMessage = responseData['message'] as String? ??
                responseData['error'] as String? ??
                responseData['errorMessage'] as String? ??
                responseData['msg'] as String? ??
                errorMessage;

            if (responseData['message'] is List) {
              final messages = responseData['message'] as List;
              if (messages.isNotEmpty) {
                errorMessage = messages.map((e) => e.toString()).join(', ');
              }
            }
          } else if (responseData is String) {
            errorMessage = responseData;
          }
        }
      } else {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _refresh() async {
    setState(() => _page = 0);
    await _fetchMyContent();
  }

  @override
  Widget build(BuildContext context) {
    final myContentAsync = ref.watch(myContentListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Push History'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          myContentAsync.when(
            data: (response) {
              final contentList = response?.data?.content ?? [];

              if (contentList.isEmpty) {
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: const Center(
                        child: Text('No content found'),
                      ),
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: contentList.length,
                  itemBuilder: (context, index) {
                    final content = contentList[index];
                    return ContentCardWidget(
                      content: content,
                      trailing: _buildGeneralShareButton(content),
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) {
              String errorMessage = 'Error loading content';

              if (error is DioException) {
                if (error.message != null && error.message!.isNotEmpty) {
                  errorMessage = error.message!;
                } else if (error.response?.data != null) {
                  final responseData = error.response!.data;
                  if (responseData is Map<String, dynamic>) {
                    errorMessage = responseData['message'] as String? ??
                        responseData['error'] as String? ??
                        responseData['errorMessage'] as String? ??
                        responseData['msg'] as String? ??
                        errorMessage;

                    if (responseData['message'] is List) {
                      final messages = responseData['message'] as List;
                      if (messages.isNotEmpty) {
                        errorMessage =
                            messages.map((e) => e.toString()).join(', ');
                      }
                    }
                  } else if (responseData is String) {
                    errorMessage = responseData;
                  }
                }
              } else {
                errorMessage = error.toString().replaceFirst('Exception: ', '');
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 4),
                    ),
                  );
                }
              });

              return RefreshIndicator(
                onRefresh: _refresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error loading content',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              errorMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _refresh,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _shareContentGeneral(ContentItem content) async {
    String shareText = content.title ?? '';
    if (content.textContent != null && content.textContent!.isNotEmpty) {
      shareText += '\n\n${content.textContent}';
    }

    String? imageUrl = content.imageUrl;
    if (imageUrl != null && !imageUrl.startsWith('http')) {
      imageUrl = 'https://loksandesh.jojolapatech.com/$imageUrl';
    }

    try {
      if (imageUrl != null) {
        try {
          final response = await http.get(Uri.parse(imageUrl));
          if (response.statusCode == 200) {
            final directory = await getTemporaryDirectory();
            final path =
                '${directory.path}/temp_share_${DateTime.now().millisecondsSinceEpoch}.png';
            final file = File(path);
            await file.writeAsBytes(response.bodyBytes);

            if (await file.exists()) {
              await Share.shareXFiles(
                [XFile(path)],
                text: shareText,
              );
              return;
            }
          }
        } catch (e) {
          // Fall through to text-only share
        }
      }

      await Share.share(shareText);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildGeneralShareButton(ContentItem content) {
    return Tooltip(
      message: 'Share',
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          icon: const Icon(Icons.share, size: 24),
          color: Colors.grey.shade700,
          iconSize: 28,
          onPressed: () => _shareContentGeneral(content),
        ),
      ),
    );
  }
}
