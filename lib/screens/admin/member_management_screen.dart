import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/booth_list_response.dart';
import '../../core/models/member_register_request.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/services/profile_cache_service.dart';
import '../../services/excel_service.dart';

class MemberManagementScreen extends ConsumerStatefulWidget {
  const MemberManagementScreen({super.key});

  @override
  ConsumerState<MemberManagementScreen> createState() =>
      _MemberManagementScreenState();
}

class _MemberManagementScreenState
    extends ConsumerState<MemberManagementScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _boothController = TextEditingController();
  Booth? _selectedBooth;
  bool _isLoadingMembers = false;
  bool _showBoothList = false; // Track if booth dropdown should be shown

  @override
  void initState() {
    super.initState();
    // Fetch members on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMembers();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _boothController.dispose();
    super.dispose();
  }

  Future<void> _fetchMembers() async {
    setState(() {
      _isLoadingMembers = true;
    });

    try {
      await ref.read(membersListProvider.notifier).fetchMembers(
            page: 0,
            size: 100,
          );
    } catch (e) {
      if (mounted) {
        // The error message from DioException should already contain the API error message
        final errorMessage = e is DioException
            ? (e.message ?? 'Error fetching members')
            : e.toString();
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
          _isLoadingMembers = false;
      });
      }
    }
  }

  Future<void> _addMember() async {
    // Validate fields
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter member name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter mobile number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Check roleType to determine if booth is required
    final roleType = await ProfileCacheService.getRoleType();
    final isPartyAdmin = roleType == 'PARTY_ADMIN';

    // Only validate booth if PARTY_ADMIN
    if (isPartyAdmin && _boothController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter booth name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Create registration request - use whatever is in the textfield
      final registerRequest = MemberRegisterRequest(
        fullName: _nameController.text.trim(),
        mobileNumber: _phoneController.text.trim(),
        boothName: isPartyAdmin ? _boothController.text.trim() : '',
      );

      // Call registration API
      final registerNotifier = ref.read(memberRegisterProvider.notifier);
      final response = await registerNotifier.registerMember(registerRequest);

      // Check if registration was successful
      if (response.status == 'SUCCESS') {
        // Clear form fields
      _nameController.clear();
      _phoneController.clear();
        _boothController.clear();
        _selectedBooth = null;

        // Close dialog first
        if (mounted) {
          Navigator.pop(context);
        }

        // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Member registered successfully'),
            backgroundColor: Colors.green,
          ),
        );
        }

        // Refresh member list
        await _fetchMembers();
      } else {
        // Show error message from response
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Failed to register member'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        final errorMessage = e is DioException
            ? (e.message ?? 'Error registering member')
            : e.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Future<void> _showAddMemberDialog() async {
  //   // Reset booth selection when opening dialog
  //   _selectedBooth = null;
  //   _boothController.clear();
  //
  //   // Fetch booths when dialog opens (don't await, let it load in background)
  //   try {
  //     await ref.read(boothListProvider.notifier).fetchBooths(
  //       page: 0,
  //       size: 100,
  //     );
  //   } catch (e) {
  //     // Error will be shown in the dialog's error state
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Error loading booths: ${e is DioException ? (e.message ?? 'Error') : e.toString()}'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }
  //
  //   showDialog(
  //     context: context,
  //     builder: (dialogContext) => Consumer(
  //       builder: (context, ref, child) {
  //         final boothAsync = ref.watch(boothListProvider);
  //
  //         return StatefulBuilder(
  //           builder: (context, setDialogState) {
  //             return AlertDialog(
  //               title: const Text('Add Member'),
  //               content: SingleChildScrollView(
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     TextField(
  //                       controller: _nameController,
  //                       decoration: const InputDecoration(
  //                         labelText: 'Name',
  //                         border: OutlineInputBorder(),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 16),
  //                     TextField(
  //                       controller: _phoneController,
  //                       decoration: const InputDecoration(
  //                         labelText: 'Phone',
  //                         border: OutlineInputBorder(),
  //                       ),
  //                       keyboardType: TextInputType.phone,
  //                     ),
  //                     const SizedBox(height: 16),
  //                     boothAsync.when(
  //                       data: (boothResponse) {
  //                         final booths = boothResponse?.data?.content ?? [];
  //
  //                         // Debug: Print booth count
  //                         if (booths.isNotEmpty) {
  //                           debugPrint('Booths loaded: ${booths.length}');
  //                           debugPrint('First booth: ${booths.first.name}');
  //                         }
  //
  //                         if (booths.isEmpty) {
  //                           return const TextField(
  //                             decoration: InputDecoration(
  //                               labelText: 'Booth',
  //                               border: OutlineInputBorder(),
  //                               hintText: 'No booths available',
  //                               enabled: false,
  //                             ),
  //                           );
  //                         }
  //
  //                         return Autocomplete<Booth>(
  //                           displayStringForOption: (Booth booth) => booth.name ?? '',
  //                           optionsBuilder: (TextEditingValue textEditingValue) {
  //                             if (textEditingValue.text.isEmpty) {
  //                               return booths;
  //                             }
  //                             return booths.where((booth) =>
  //                               (booth.name ?? '').toLowerCase()
  //                                   .contains(textEditingValue.text.toLowerCase())
  //                             );
  //                           },
  //                           onSelected: (Booth booth) {
  //                             setDialogState(() {
  //                               _selectedBooth = booth;
  //                               _boothController.text = booth.name ?? '';
  //                             });
  //                           },
  //                           fieldViewBuilder: (
  //                             BuildContext context,
  //                             TextEditingController textEditingController,
  //                             FocusNode focusNode,
  //                             VoidCallback onFieldSubmitted,
  //                           ) {
  //                             return TextField(
  //                               controller: textEditingController,
  //                               focusNode: focusNode,
  //                               enabled: true,
  //                               decoration: InputDecoration(
  //                                 labelText: 'Booth',
  //                                 border: const OutlineInputBorder(),
  //                                 hintText: 'Type to search booths...',
  //                                 suffixIcon: _selectedBooth != null
  //                                     ? IconButton(
  //                                         icon: const Icon(Icons.clear),
  //                                         onPressed: () {
  //                                           setDialogState(() {
  //                                             _selectedBooth = null;
  //                                             _boothController.clear();
  //                                             textEditingController.clear();
  //                                           });
  //                                         },
  //                                       )
  //                                     : null,
  //                               ),
  //                               onChanged: (value) {
  //                                 _boothController.text = value;
  //                                 // Clear selection if user manually edits
  //                                 if (_selectedBooth != null && value != _selectedBooth?.name) {
  //                                   setDialogState(() {
  //                                     _selectedBooth = null;
  //                                   });
  //                                 }
  //                               },
  //                             );
  //                           },
  //                           optionsViewBuilder: (context, onSelected, options) {
  //                             return Align(
  //                               alignment: Alignment.topLeft,
  //                               child: Material(
  //                                 elevation: 4.0,
  //                                 borderRadius: BorderRadius.circular(8),
  //                                 child: ConstrainedBox(
  //                                   constraints: const BoxConstraints(maxHeight: 200),
  //                                   child: ListView.builder(
  //                                     shrinkWrap: true,
  //                                     padding: EdgeInsets.zero,
  //                                     itemCount: options.length,
  //                                     itemBuilder: (context, index) {
  //                                       final booth = options.elementAt(index);
  //                                       return InkWell(
  //                                         onTap: () => onSelected(booth),
  //                                         child: Padding(
  //                                           padding: const EdgeInsets.all(16.0),
  //                                           child: Text(
  //                                             booth.name ?? '',
  //                                             style: const TextStyle(fontSize: 16),
  //                                           ),
  //                                         ),
  //                                       );
  //                                     },
  //                                   ),
  //                                 ),
  //                               ),
  //                             );
  //                           },
  //                         );
  //                       },
  //                       loading: () => const TextField(
  //                         decoration: InputDecoration(
  //                           labelText: 'Booth',
  //                           border: OutlineInputBorder(),
  //                           hintText: 'Loading booths...',
  //                           enabled: false,
  //                         ),
  //                       ),
  //                       error: (error, stackTrace) {
  //                         return Column(
  //                           children: [
  //                             TextField(
  //                               controller: _boothController,
  //                               decoration: const InputDecoration(
  //                                 labelText: 'Booth',
  //                                 border: OutlineInputBorder(),
  //                                 hintText: 'Error loading booths',
  //                                 enabled: false,
  //                               ),
  //                             ),
  //                             const SizedBox(height: 8),
  //                             Text(
  //                               error is String ? error : error.toString(),
  //                               style: const TextStyle(
  //                                 color: Colors.red,
  //                                 fontSize: 12,
  //                               ),
  //                             ),
  //                           ],
  //                         );
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               actions: [
  //                 TextButton(
  //                   onPressed: () {
  //                     _boothController.clear();
  //                     _selectedBooth = null;
  //                     Navigator.pop(dialogContext);
  //                   },
  //                   child: const Text('Cancel'),
  //                 ),
  //                 ElevatedButton(
  //                   onPressed: _addMember,
  //                   child: const Text('Add'),
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  Future<void> _showAddMemberDialog() async {
    // Reset selection
    _selectedBooth = null;
    _boothController.clear();
    _showBoothList = false;

    // Show dialog first, then load data (so we can see loading state)
    await showDialog(
      context: context,
      builder: (dialogContext) => Consumer(
        builder: (context, ref, child) {
          // Get roleType first to determine if we need to show booth field
          return FutureBuilder<String?>(
            future: ProfileCacheService.getRoleType(),
            builder: (context, roleTypeSnapshot) {
              final roleType = roleTypeSnapshot.data;
              final isPartyAdmin = roleType == 'PARTY_ADMIN';

              // Only watch booth provider if we're PARTY_ADMIN
              final boothAsync = isPartyAdmin ? ref.watch(boothListProvider) : null;

              // Fetch booths when dialog is first shown (only if PARTY_ADMIN and not already loading/has data)
              if (isPartyAdmin && boothAsync != null) {
                boothAsync.when(
                  data: (data) {
                    // If we have data, no need to fetch again
                    if (data == null) {
                      // If data is null, fetch it
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ref
                            .read(boothListProvider.notifier)
                            .fetchBooths(page: 0, size: 100);
                      });
                    }
                  },
                  loading: () {
                    // Already loading, do nothing
                  },
                  error: (err, stack) {
                    // On error, try to fetch again
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ref
                          .read(boothListProvider.notifier)
                          .fetchBooths(page: 0, size: 100);
                    });
                  },
                );

                // Debug: Print current state
                boothAsync.when(
                  data: (data) => debugPrint(
                      'Booth provider data: ${data?.data?.content?.length ?? 0} booths'),
                  loading: () => debugPrint('Booth provider: Loading...'),
                  error: (err, stack) => debugPrint('Booth provider error: $err'),
                );
              }

              // We use a StatefulBuilder to handle the "Show/Hide List" logic locally
              return StatefulBuilder(
                builder: (context, setDialogState) {
                  // Helper to handle text changes
                  void onSearchChanged(String query, List<Booth> allBooths) {
                    setDialogState(() {
                      // If user types, we clear the previous selection object
                      if (_selectedBooth != null && query != _selectedBooth?.name) {
                        _selectedBooth = null;
                      }
                    });
                  }

                  // Helper to Select an item
                  void onBoothSelected(Booth booth) {
                    setDialogState(() {
                      _selectedBooth = booth;
                      _boothController.text = booth.name ?? '';
                      _showBoothList = false; // Hide list after selection
                      // Close the keyboard to see the result clearly
                      FocusScope.of(context).unfocus();
                    });
                  }

                  final dialogTitle = isPartyAdmin ? 'Add Booth Admin' : 'Add Member';

                  return AlertDialog(
                    title: Text(dialogTitle),
                    // Use SingleChildScrollView so the list pushes content down without overflow
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                                labelText: 'Name', border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                                labelText: 'Phone', border: OutlineInputBorder()),
                            keyboardType: TextInputType.phone,
                          ),
                          // Only show booth field if PARTY_ADMIN
                          if (isPartyAdmin) ...[
                            const SizedBox(height: 16),
                            // ---------------------------------------------
                            // CUSTOM INLINE AUTOCOMPLETE
                            // ---------------------------------------------
                            boothAsync!.when(
                        loading: () => const TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'Booth',
                            hintText: 'Loading...',
                            border: OutlineInputBorder(),
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(12),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        ),
                        error: (err, stack) {
                          debugPrint('Booth error in dialog: $err');
                          return Column(
                            children: [
                              const TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Booth',
                                  hintText: 'Error loading data',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                err is String ? err : err.toString(),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          );
                        },
                        data: (boothResponse) {
                          debugPrint(
                              'Booth data received: ${boothResponse?.data?.content?.length ?? 0} booths');
                          final allBooths = boothResponse?.data?.content ?? [];

                          // If response is null or empty, show empty state
                          if (boothResponse == null) {
                            return const TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Booth',
                                hintText: 'No data available',
                  border: OutlineInputBorder(),
                ),
                            );
                          }

                          // 1. FILTER LOGIC
                          // Filter booths based on text input
                          final List<Booth> visibleOptions = allBooths.where((b) {
                            final query = _boothController.text.toLowerCase();
                            if (query.isEmpty) {
                              return true; // Show all when text is empty
                            }
                            return (b.name ?? '')
                                .toLowerCase()
                                .contains(query);
                          }).toList();

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // THE TEXT FIELD
                              TextField(
                                controller: _boothController,
                                decoration: InputDecoration(
                                  labelText: 'Booth',
                                  border: const OutlineInputBorder(),
                                  hintText: 'Select or type...',
                                  suffixIcon: _selectedBooth != null
                                      ? IconButton(
                                          icon: const Icon(Icons.check_circle,
                                              color: Colors.green),
                                          onPressed: () {
                                            setDialogState(() {
                                              _selectedBooth = null;
                                              _boothController.clear();
                                              _showBoothList = false;
                                            });
                                          },
                                        )
                                      : const Icon(Icons.search),
                                ),
                                // Update list when typing
                                onChanged: (val) {
                                  onSearchChanged(val, allBooths);
                                  // Keep list visible when typing if it was shown
                                  if (!_showBoothList && val.isNotEmpty) {
                                    setDialogState(() {
                                      _showBoothList = true;
                                    });
                                  }
                                },
                                // Show list when tapping
                                onTap: () {
                                  setDialogState(() {
                                    _showBoothList = true;
                                  });
                                },
                                // Hide list when focus is lost (user taps outside)
                                onEditingComplete: () {
                                  setDialogState(() {
                                    _showBoothList = false;
                                  });
                                },
                              ),

                              // THE LIST (Rendered Inline) - Only show when tapped and has options
                              if (_showBoothList && visibleOptions.isNotEmpty)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    constraints:
                                        const BoxConstraints(maxHeight: 150),
                                    margin: const EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: visibleOptions.map((booth) {
                                          final index =
                                              visibleOptions.indexOf(booth);
                                          return InkWell(
                                            onTap: () => onBoothSelected(booth),
                                            child: Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                border: index !=
                                                        visibleOptions.length - 1
                                                    ? Border(
                                                        bottom: BorderSide(
                                                            color: Colors
                                                                .grey.shade100))
                                                    : null,
                                              ),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                booth.name ?? 'Unknown',
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                            ),
                          ],
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _addMember,
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _uploadExcel() async {
    try {
      // Pick Excel file
      final file = await ExcelService.pickExcelFile();
      if (file == null || !mounted) return;

      // Show loading indicator
      setState(() {
        _isLoadingMembers = true;
      });

      // Call bulk register API with file path (multipart upload)
      final bulkNotifier = ref.read(bulkRegisterProvider.notifier);
      final response = await bulkNotifier.bulkRegisterMembers(file.path);

      // Check if registration was successful
      if (response.status == 'SUCCESS' && mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message ?? response.data?.toString() ?? 'Members registered successfully'),
            backgroundColor: Colors.green,
          ),
        );

        // Refresh member list
        await _fetchMembers();
      } else if (mounted) {
        // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message ?? 'Failed to register members'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Show error message
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
      // Hide loading indicator
      if (mounted) {
        setState(() {
          _isLoadingMembers = false;
        });
      }
    }
  }

  Future<void> _removeMember(String memberId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Member'),
        content: const Text('Are you sure you want to remove this member?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      try {
        // Show loading indicator
        setState(() {
          _isLoadingMembers = true;
        });

        // Call delete API
        final deleteNotifier = ref.read(memberDeleteProvider.notifier);
        final response = await deleteNotifier.deleteMember(memberId);

        // Check if deletion was successful
        if (response.status == 'SUCCESS' && mounted) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.data ?? response.message ?? 'Member deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );

          // Refresh member list
          await _fetchMembers();
        } else if (mounted) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Failed to delete member'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        // Show error message
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
        // Hide loading indicator
        if (mounted) {
          setState(() {
            _isLoadingMembers = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final membersAsync = ref.watch(membersListProvider);

    return FutureBuilder<String?>(
      future: ProfileCacheService.getRoleType(),
      builder: (context, roleTypeSnapshot) {
        final roleType = roleTypeSnapshot.data;
        final isPartyAdmin = roleType == 'PARTY_ADMIN';
        final buttonTooltip = isPartyAdmin ? 'Add Booth Admin' : 'Add Member';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Management'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: _uploadExcel,
            tooltip: 'Upload Excel',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddMemberDialog,
                tooltip: buttonTooltip,
          ),
        ],
      ),
          body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _fetchMembers,
            child: membersAsync.when(
              data: (response) {
                if (response == null) {
                  return const Center(
                    child: Text('No data available'),
                  );
                }

                final members = response.data?.content ?? [];

                if (members.isEmpty) {
                  return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No members yet',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _showAddMemberDialog,
                        icon: const Icon(Icons.add),
                          label: Text(isPartyAdmin ? 'Add Booth Admin' : 'Add Member'),
                      ),
                    ],
                  ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            (member.fullName?.isNotEmpty == true
                                    ? member.fullName![0]
                                    : member.userEmail?.isNotEmpty == true
                                        ? member.userEmail![0]
                                        : member.userMobileNumber?.isNotEmpty ==
                                                true
                                            ? member.userMobileNumber![0]
                                            : 'M')
                                .toUpperCase(),
                          ),
                        ),
                        title: Text(
                          member.fullName ??
                              member.userEmail ??
                              member.userMobileNumber ??
                              'Member',
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (member.userEmail != null)
                              Text('Email: ${member.userEmail}'),
                            if (member.userMobileNumber != null)
                              Text('Mobile: ${member.userMobileNumber}'),
                            if (member.designationName != null)
                              Text('Designation: ${member.designationName}'),
                            if (member.boothName != null)
                              Text('Booth: ${member.boothName}'),
                            if (member.partyName != null)
                              Text('Party: ${member.partyName}'),
                            if (member.balance != null)
                              Text(
                                  'Balance: Rs. ${member.balance!.toStringAsFixed(2)}'),
                            if (member.status != null)
                              Text(
                                'Status: ${member.status}',
                                style: TextStyle(
                                  color: member.status == 'ACTIVE'
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeMember(member.id ?? ''),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) {
                // Extract error message (should already be API message from provider)
                final errorMessage = error is String ? error : error.toString();

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading members',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _fetchMembers,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Loading overlay
          if (_isLoadingMembers)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
          ),
        );
      },
    );
  }
}
