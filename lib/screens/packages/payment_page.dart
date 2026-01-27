import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/models/packages_list_response.dart';
import '../../core/models/bank_info_response.dart';
import '../../core/models/balance_load_request.dart';
import '../../core/models/balance_load_response.dart';
import '../../core/api/api_endpoints.dart';
import '../../services/image_service.dart';

class PaymentPage extends ConsumerStatefulWidget {
  final Package package;

  const PaymentPage({
    super.key,
    required this.package,
  });

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  File? _selectedReceipt;
  bool _isUploading = false;
  BankInfoResponse? _bankInfoResponse;
  bool _isLoadingBankInfo = false;
  String? _bankInfoError;
  final TextEditingController _remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch bank info on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchBankInfo();
    });
  }

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }

  Future<void> _fetchBankInfo() async {
    setState(() {
      _isLoadingBankInfo = true;
      _bankInfoError = null;
    });

    try {
      final dioClient = await ref.read(dioClientProvider.future);
      
      final response = await dioClient.get(
        ApiEndpoints.bankInfo,
        requiresAuth: true,
      );

      if (response.statusCode == 200) {
        final bankInfoResponse = BankInfoResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );
        
        // Check if status is SUCCESS
        if (bankInfoResponse.status == 'SUCCESS') {
          setState(() {
            _bankInfoResponse = bankInfoResponse;
            _isLoadingBankInfo = false;
          });
        } else {
          // Handle error response
          final errorMessage = bankInfoResponse.message ?? 
                              'Failed to fetch bank information';
          setState(() {
            _bankInfoError = errorMessage;
            _isLoadingBankInfo = false;
          });
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
              ),
            );
          }
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Failed to fetch bank information with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Extract error message from API response
      String errorMessage = 'Failed to fetch bank information';
      
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
      
      setState(() {
        _bankInfoError = errorMessage;
        _isLoadingBankInfo = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      
      setState(() {
        _bankInfoError = errorMessage;
        _isLoadingBankInfo = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final image = await ImageService.pickImageFromGallery();
      if (image != null) {
        setState(() {
          _selectedReceipt = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedReceipt = File(result.files.single.path!);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _showReceiptSourceDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Receipt Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Files'),
              onTap: () {
                Navigator.pop(context);
                _pickFile();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _removeReceipt() {
    setState(() {
      _selectedReceipt = null;
    });
  }

  Future<void> _submitPayment() async {
    // Validate required fields
    final packageId = widget.package.id;
    if (packageId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Package ID is missing'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedReceipt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a receipt'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Convert receipt file to base64
      final receiptBytes = await _selectedReceipt!.readAsBytes();
      final receiptBase64 = base64Encode(receiptBytes);

      // Get payment details
      final amount = _calculateFinalPrice(widget.package);
      final description = _remarkController.text.trim().isEmpty
          ? 'Payment for ${widget.package.packageName ?? 'Package'}'
          : _remarkController.text.trim();

      // Create request
      final request = BalanceLoadRequest(
        amount: amount,
        description: description,
        document: receiptBase64,
        packageId: packageId,
      );

      // Call API
      final dioClient = await ref.read(dioClientProvider.future);
      
      final response = await dioClient.postJson(
        ApiEndpoints.balanceLoad,
        data: request.toJson(),
        requiresAuth: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final balanceLoadResponse = BalanceLoadResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );

        // Check if status is SUCCESS
        if (balanceLoadResponse.status == 'SUCCESS') {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  balanceLoadResponse.message ?? 'Payment submitted successfully',
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 4),
              ),
            );
            
            // Navigate back after successful submission
            Navigator.pop(context);
          }
        } else {
          // Handle error response
          final errorMessage = balanceLoadResponse.message ?? 
                              'Failed to submit payment';
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
              ),
            );
          }
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Failed to submit payment with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Extract error message from API response
      String errorMessage = 'Failed to submit payment';
      
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
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      
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
          _isUploading = false;
        });
      }
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final finalPrice = _calculateFinalPrice(widget.package);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Package Information Card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Package Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow('Package Name', widget.package.packageName ?? 'N/A'),
                    if (widget.package.description != null &&
                        widget.package.description!.isNotEmpty)
                      _buildInfoRow('Description', widget.package.description!),
                    _buildInfoRow('SMS Amount', '${widget.package.smsAmount ?? 0}'),
                    const SizedBox(height: 8),
                    // Payment Amount - Prominently displayed
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Amount',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Rs. ${finalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.payment,
                            size: 40,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                    if (widget.package.discount != null &&
                        widget.package.discount! > 0 &&
                        widget.package.discountType != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_offer,
                              color: Colors.orange.shade700,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.package.discountType!.toUpperCase() == 'FLAT'
                                  ? 'Discount: Rs. ${widget.package.discount!.toStringAsFixed(2)}'
                                  : 'Discount: ${widget.package.discount!.toStringAsFixed(0)}%',
                              style: TextStyle(
                                color: Colors.orange.shade900,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Bank Information Card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bank Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_isLoadingBankInfo)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (_bankInfoError != null)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48,
                              color: Colors.red.shade300,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _bankInfoError!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: _fetchBankInfo,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    else if (_bankInfoResponse?.data != null)
                      _buildBankInfoContent(_bankInfoResponse!.data!)
                    else
                      const Text('No bank information available'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Remarks Section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Remarks',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _remarkController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter any remarks or notes...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Receipt Upload Section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload Receipt',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_selectedReceipt == null)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _showReceiptSourceDialog,
                          icon: const Icon(Icons.upload_file),
                          label: const Text('Select Receipt'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      )
                    else
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.green.shade200,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green.shade700,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _selectedReceipt!.path.split('/').last,
                                    style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: _removeReceipt,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: _showReceiptSourceDialog,
                              icon: const Icon(Icons.change_circle),
                              label: const Text('Change Receipt'),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedReceipt == null || _isUploading
                    ? null
                    : _submitPayment,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: _isUploading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Submit Payment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isHighlighted = false}) {
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
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: isHighlighted
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black87,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Get package ID for payment
  String? get packageId => widget.package.id;

  /// Get payment amount for payment
  double get paymentAmount => _calculateFinalPrice(widget.package);

  /// Build bank information content
  Widget _buildBankInfoContent(BankInfo bankInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Bank Name', bankInfo.name ?? 'N/A'),
        _buildInfoRow('Branch', bankInfo.branch ?? 'N/A'),
        _buildInfoRow(
          'Account Number',
          bankInfo.accountNumber ?? 'N/A',
          isHighlighted: true,
        ),
        if (bankInfo.qrCode != null && bankInfo.qrCode!.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'QR Code:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Image.network(
              bankInfo.qrCode!,
              height: 200,
              width: 200,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
