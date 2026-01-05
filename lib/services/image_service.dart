import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  static Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      return image;
    } catch (e) {
      throw Exception('Error picking image from gallery: $e');
    }
  }

  /// Capture image from camera
  static Future<XFile?> captureImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      return image;
    } catch (e) {
      throw Exception('Error capturing image from camera: $e');
    }
  }

  /// Get file from XFile
  static File? getFileFromXFile(XFile? xFile) {
    if (xFile == null) return null;
    return File(xFile.path);
  }
}

