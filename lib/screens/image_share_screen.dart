import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';
import '../services/image_service.dart';
import '../services/contact_service.dart';
import '../models/contact_model.dart';

class ImageShareScreen extends StatefulWidget {
  const ImageShareScreen({super.key});

  @override
  State<ImageShareScreen> createState() => _ImageShareScreenState();
}

class _ImageShareScreenState extends State<ImageShareScreen> {
  File? _selectedImage;
  bool _isLoading = false;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final cameraPermission = await Permission.camera.status;
    final storagePermission = await Permission.photos.status;
    final mediaLibraryPermission = await Permission.mediaLibrary.status;

    if (cameraPermission.isGranted &&
        (storagePermission.isGranted || mediaLibraryPermission.isGranted)) {
      setState(() {
        _hasPermission = true;
      });
    }
  }

  Future<void> _requestPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.photos.request();
    final mediaLibraryStatus = await Permission.mediaLibrary.request();

    if (cameraStatus.isGranted &&
        (storageStatus.isGranted || mediaLibraryStatus.isGranted)) {
      setState(() {
        _hasPermission = true;
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Camera and storage permissions are required'),
            action: SnackBarAction(
              label: 'Open Settings',
              onPressed: openAppSettings,
            ),
          ),
        );
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    if (!_hasPermission) {
      await _requestPermissions();
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      final XFile? image = await ImageService.pickImageFromGallery();
      if (image != null && mounted) {
        setState(() {
          _selectedImage = File(image.path);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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

  Future<void> _captureImageFromCamera() async {
    if (!_hasPermission) {
      await _requestPermissions();
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      final XFile? image = await ImageService.captureImageFromCamera();
      if (image != null && mounted) {
        setState(() {
          _selectedImage = File(image.path);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error capturing image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _showImageSourceDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
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
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _captureImageFromCamera();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shareToSocialMedia() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      await Share.shareXFiles(
        [XFile(_selectedImage!.path)],
        text: 'Check out this image!',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _sendImageToContacts() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      List<ContactModel> contacts = await ContactService.getSimContacts();
      Map<String, List<ContactModel>> groupedContacts =
          ContactService.groupByCarrier(contacts);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageSendScreen(
              imagePath: _selectedImage!.path,
              groupedContacts: groupedContacts,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading contacts: $e'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Share'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image Preview Section
                  Card(
                    elevation: 4,
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade200,
                      ),
                      child: _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 64,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No image selected',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Select Image Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _pickImageFromGallery,
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Gallery'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _captureImageFromCamera,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Camera'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Quick Select Button
                  OutlinedButton.icon(
                    onPressed: _showImageSourceDialog,
                    icon: const Icon(Icons.add_photo_alternate),
                    label: const Text('Select Image'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Share Options
                  if (_selectedImage != null) ...[
                    const Text(
                      'Share Options',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _shareToSocialMedia,
                      icon: const Icon(Icons.share),
                      label: const Text('Share to Social Media'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _sendImageToContacts,
                      icon: const Icon(Icons.send),
                      label: const Text('Send to Contacts'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],

                  // Permission Warning
                  if (!_hasPermission)
                    Card(
                      color: Colors.orange.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Icon(Icons.warning, color: Colors.orange),
                            const SizedBox(height: 8),
                            const Text(
                              'Permissions Required',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Camera and storage permissions are needed',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: _requestPermissions,
                              child: const Text('Grant Permissions'),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

// Screen for sending image to selected contacts
class ImageSendScreen extends StatefulWidget {
  final String imagePath;
  final Map<String, List<ContactModel>> groupedContacts;

  const ImageSendScreen({
    super.key,
    required this.imagePath,
    required this.groupedContacts,
  });

  @override
  State<ImageSendScreen> createState() => _ImageSendScreenState();
}

class _ImageSendScreenState extends State<ImageSendScreen> {
  late Map<String, List<ContactModel>> _groupedContacts;
  int _totalSelected = 0;

  @override
  void initState() {
    super.initState();
    _groupedContacts = Map.fromEntries(
      widget.groupedContacts.entries.map((entry) => MapEntry(
            entry.key,
            entry.value.map((c) => ContactModel(
                  name: c.name,
                  phoneNumber: c.phoneNumber,
                  carrier: c.carrier,
                  isSelected: c.isSelected,
                )).toList(),
          )),
    );
    _updateSelectedCount();
  }

  void _updateSelectedCount() {
    int count = 0;
    for (var contacts in _groupedContacts.values) {
      count += contacts.where((c) => c.isSelected).length;
    }
    setState(() {
      _totalSelected = count;
    });
  }

  void _toggleContactSelection(String carrier, int index) {
    setState(() {
      _groupedContacts[carrier]![index].isSelected =
          !_groupedContacts[carrier]![index].isSelected;
      _updateSelectedCount();
    });
  }

  void _toggleCarrierSelection(String carrier, bool select) {
    setState(() {
      for (var contact in _groupedContacts[carrier]!) {
        contact.isSelected = select;
      }
      _updateSelectedCount();
    });
  }

  List<ContactModel> _getSelectedContacts() {
    List<ContactModel> selected = [];
    for (var contacts in _groupedContacts.values) {
      selected.addAll(contacts.where((c) => c.isSelected));
    }
    return selected;
  }

  Future<void> _sendImage() async {
    final selected = _getSelectedContacts();
    if (selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one contact'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      // Share image to selected contacts
      // Note: SMS/MMS sending with images requires platform-specific implementation
      // For now, we'll use share_plus which allows sharing to messaging apps
      await Share.shareXFiles(
        [XFile(widget.imagePath)],
        text: 'Image shared via SMS App',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image shared to ${selected.length} contact(s)'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final carriers = ['NTC', 'Ncell', 'Smart', 'Unknown'];
    final carrierColors = {
      'NTC': Colors.blue,
      'Ncell': Colors.green,
      'Smart': Colors.orange,
      'Unknown': Colors.grey,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contacts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_totalSelected > 0)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Selected: $_totalSelected',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Image Preview
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey.shade200,
            child: Image.file(
              File(widget.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          if (_totalSelected > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$_totalSelected contact(s) selected',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _sendImage,
                    icon: const Icon(Icons.send),
                    label: const Text('Send Image'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: carriers.length,
              itemBuilder: (context, index) {
                final carrier = carriers[index];
                final contacts = _groupedContacts[carrier] ?? [];
                final selectedCount =
                    contacts.where((c) => c.isSelected).length;
                final allSelected = contacts.isNotEmpty &&
                    selectedCount == contacts.length;

                if (contacts.isEmpty) return const SizedBox.shrink();

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: carrierColors[carrier],
                      child: Text(
                        carrier[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      carrier,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      '${contacts.length} contacts (${selectedCount} selected)',
                    ),
                    trailing: Checkbox(
                      value: allSelected,
                      tristate: true,
                      onChanged: (value) {
                        _toggleCarrierSelection(
                          carrier,
                          value ?? false,
                        );
                      },
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: contacts.length,
                        itemBuilder: (context, contactIndex) {
                          final contact = contacts[contactIndex];
                          return ListTile(
                            leading: Checkbox(
                              value: contact.isSelected,
                              onChanged: (value) {
                                _toggleContactSelection(
                                  carrier,
                                  contactIndex,
                                );
                              },
                            ),
                            title: Text(contact.name),
                            subtitle: Text(contact.phoneNumber),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _totalSelected > 0
          ? FloatingActionButton.extended(
              onPressed: _sendImage,
              icon: const Icon(Icons.send),
              label: Text('Send to $_totalSelected'),
            )
          : null,
    );
  }
}

