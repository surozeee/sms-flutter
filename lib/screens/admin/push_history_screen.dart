import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/auth_provider.dart';

class PushHistoryScreen extends ConsumerStatefulWidget {
  const PushHistoryScreen({super.key});

  @override
  ConsumerState<PushHistoryScreen> createState() => _PushHistoryScreenState();
}

class _PushHistoryScreenState extends ConsumerState<PushHistoryScreen> {
  int _page = 0;
  final int _size = 10;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Fetch push notifications on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchPushNotifications();
    });
  }

  Future<void> _fetchPushNotifications() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(pushNotificationsListProvider.notifier).fetchPushNotifications(
        page: _page,
        size: _size,
      );
    } catch (e) {
      // Extract error message from API response
      String errorMessage = 'Failed to fetch push notifications';
      
      if (e is DioException) {
        // Try to get message from DioException (which comes from interceptor)
        if (e.message != null && e.message!.isNotEmpty) {
          errorMessage = e.message!;
        } else if (e.response?.data != null) {
          // Extract from response data
          final responseData = e.response!.data;
          if (responseData is Map<String, dynamic>) {
            errorMessage = responseData['message'] as String? ??
                responseData['error'] as String? ??
                responseData['errorMessage'] as String? ??
                responseData['msg'] as String? ??
                errorMessage;
            
            // If message is a list, join it
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
        // Handle non-DioException errors
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
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _refreshPushNotifications() async {
    setState(() {
      _page = 0;
    });
    await _fetchPushNotifications();
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';
    try {
      final dateTime = DateTime.parse(dateString);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'SENT':
        return Colors.green;
      case 'FAILED':
        return Colors.red;
      case 'PENDING':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getNotificationTypeIcon(String? type) {
    switch (type) {
      case 'ALL_MEMBERS':
        return Icons.people;
      case 'PARTY_MEMBERS':
        return Icons.group;
      case 'BOOTH_MEMBERS':
        return Icons.location_on;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pushNotificationsAsync = ref.watch(pushNotificationsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Push History'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          pushNotificationsAsync.when(
            data: (pushNotificationsResponse) {
              final notifications = pushNotificationsResponse?.data?.content ?? [];

              if (notifications.isEmpty) {
                return RefreshIndicator(
                  onRefresh: _refreshPushNotifications,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: const Center(
                        child: Text('No push notifications found'),
                      ),
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: _refreshPushNotifications,
                child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  child: ExpansionTile(
                    leading: Icon(
                      _getNotificationTypeIcon(notification.notificationType),
                      color: _getStatusColor(notification.status),
                    ),
                    title: Text(
                      notification.title ?? 'No Title',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(notification.status)
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: _getStatusColor(notification.status),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                notification.status ?? 'UNKNOWN',
                                style: TextStyle(
                                  color: _getStatusColor(notification.status),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _formatDate(notification.createdAt),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (notification.message != null &&
                                notification.message!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  'Message:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            if (notification.message != null &&
                                notification.message!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  notification.message!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            const Divider(),
                            _buildInfoRow(
                              'Notification Type:',
                              notification.notificationType ?? 'N/A',
                            ),
                            if (notification.partyName != null)
                              _buildInfoRow(
                                'Party:',
                                notification.partyName!,
                              ),
                            if (notification.boothName != null)
                              _buildInfoRow(
                                'Booth:',
                                notification.boothName!,
                              ),
                            _buildInfoRow(
                              'Recipients:',
                              '${notification.recipientCount ?? 0}',
                            ),
                            _buildInfoRow(
                              'Success:',
                              '${notification.successCount ?? 0}',
                              color: Colors.green,
                            ),
                            _buildInfoRow(
                              'Failed:',
                              '${notification.failureCount ?? 0}',
                              color: Colors.red,
                            ),
                            if (notification.errorMessage != null &&
                                notification.errorMessage!.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.red.shade200,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red.shade700,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Error: ${notification.errorMessage}',
                                        style: TextStyle(
                                          color: Colors.red.shade900,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Text(
                              'Created: ${_formatDate(notification.createdAt)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
        loading: () {
          // Show loading indicator when provider is loading
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          // Extract error message
          String errorMessage = 'Error loading push notifications';
          
          if (error is DioException) {
            // Try to get message from DioException (which comes from interceptor)
            if (error.message != null && error.message!.isNotEmpty) {
              errorMessage = error.message!;
            } else if (error.response?.data != null) {
              // Extract from response data
              final responseData = error.response!.data;
              if (responseData is Map<String, dynamic>) {
                errorMessage = responseData['message'] as String? ??
                    responseData['error'] as String? ??
                    responseData['errorMessage'] as String? ??
                    responseData['msg'] as String? ??
                    errorMessage;
                
                // If message is a list, join it
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
            errorMessage = error.toString().replaceFirst('Exception: ', '');
          }
          
          // Show snackbar when error state is displayed
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
            onRefresh: _refreshPushNotifications,
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
                        'Error loading push notifications',
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
                        onPressed: _refreshPushNotifications,
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
          // Loading overlay
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

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: color ?? Colors.black87,
                fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
