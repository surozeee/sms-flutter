import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/models/packages_list_response.dart';
import 'payment_page.dart';

class PackageListScreen extends ConsumerStatefulWidget {
  const PackageListScreen({super.key});

  @override
  ConsumerState<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends ConsumerState<PackageListScreen> {
  int _page = 0;
  final int _size = 10;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Fetch packages on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchPackages();
    });
  }

  Future<void> _fetchPackages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(packagesListProvider.notifier).fetchPackages(
        page: _page,
        size: _size,
      );
    } catch (e) {
      // Extract error message from API response
      String errorMessage = 'Failed to fetch packages';
      
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

  Future<void> _refreshPackages() async {
    setState(() {
      _page = 0;
    });
    await _fetchPackages();
  }

  void _handlePayNow(Package package) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(package: package),
      ),
    );
  }

  /// Calculate final price after discount
  double _calculateFinalPrice(Package package) {
    final originalPrice = package.price ?? 0.0;
    final discount = package.discount ?? 0.0;
    final discountType = package.discountType;

    if (discount <= 0 || discountType == null) {
      return originalPrice;
    }

    if (discountType.toUpperCase() == 'FLAT') {
      return (originalPrice - discount).clamp(0.0, double.infinity);
    } else if (discountType.toUpperCase() == 'PERCENT') {
      final discountAmount = (originalPrice * discount / 100);
      return (originalPrice - discountAmount).clamp(0.0, double.infinity);
    }

    return originalPrice;
  }

  /// Get discount display text
  String _getDiscountText(Package package) {
    final discount = package.discount ?? 0.0;
    final discountType = package.discountType;

    if (discount <= 0 || discountType == null) {
      return '';
    }

    if (discountType.toUpperCase() == 'FLAT') {
      return 'Rs. ${discount.toStringAsFixed(2)} off';
    } else if (discountType.toUpperCase() == 'PERCENT') {
      return '${discount.toStringAsFixed(0)}% off';
    }

    return '';
  }


  @override
  Widget build(BuildContext context) {
    final packagesAsync = ref.watch(packagesListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Packages'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          packagesAsync.when(
            data: (packagesResponse) {
              final packages = packagesResponse?.data?.content ?? [];

              if (packages.isEmpty) {
                return RefreshIndicator(
                  onRefresh: _refreshPackages,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: const Center(
                        child: Text('No packages available'),
                      ),
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: _refreshPackages,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: packages.length,
                  itemBuilder: (context, index) {
                    final package = packages[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        package.packageName ?? 'Unnamed Package',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (package.description != null &&
                                          package.description!.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Text(
                                            package.description!,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                if (package.isActive == true)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade100,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Active',
                                      style: TextStyle(
                                        color: Colors.green.shade800,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Price section with discount handling
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildInfoColumn(
                                        'SMS Amount',
                                        '${package.smsAmount ?? 0}',
                                        Colors.green,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildInfoColumn(
                                        'Price',
                                        'Rs. ${_calculateFinalPrice(package).toStringAsFixed(2)}',
                                        Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                // Show discount and original price if discount exists
                                if (package.discount != null && 
                                    package.discount! > 0 && 
                                    package.discountType != null) ...[
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.orange.shade200,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.local_offer,
                                              color: Colors.orange.shade700,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                'Discount: ${_getDiscountText(package)}',
                                                style: TextStyle(
                                                  color: Colors.orange.shade900,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (package.price != null && 
                                            _calculateFinalPrice(package) < package.price!) ...[
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Text(
                                                'Original: Rs. ${package.price!.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 12,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Save: Rs. ${(package.price! - _calculateFinalPrice(package)).toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  color: Colors.green.shade700,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () => _handlePayNow(package),
                                icon: const Icon(Icons.payment),
                                label: const Text('Pay Now'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (error, stackTrace) {
              // Extract error message
              String errorMessage = 'Error loading packages';
              
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
                onRefresh: _refreshPackages,
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
                            'Error loading packages',
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
                            onPressed: _refreshPackages,
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

  Widget _buildInfoColumn(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
