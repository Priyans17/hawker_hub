import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerUtils {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImage(BuildContext context, {bool allowCamera = true, bool allowGallery = true}) async {
    if (!allowCamera && !allowGallery) {
      return null;
    }

    if (allowCamera && allowGallery) {
      return await _showImageSourceDialog(context);
    } else if (allowCamera) {
      return await _pickImageFromSource(ImageSource.camera);
    } else {
      return await _pickImageFromSource(ImageSource.gallery);
    }
  }

  static Future<File?> _showImageSourceDialog(BuildContext context) async {
    ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );

    if (source == null) {
      return null;
    }

    return await _pickImageFromSource(source);
  }

  static Future<File?> _pickImageFromSource(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1200,
      maxHeight: 1200,
    );
    
    if (image != null) {
      return File(image.path);
    }
    
    return null;
  }

  static Future<List<File>> pickMultipleImages() async {
    final List<XFile> images = await _picker.pickMultiImage(
      imageQuality: 80,
      maxWidth: 1200,
      maxHeight: 1200,
    );
    
    return images.map((image) => File(image.path)).toList();
  }

  static Widget imagePreview({
    required File? image,
    required VoidCallback onTap,
    double height = 150,
    String title = 'Tap to upload',
    String? subtitle,
    BorderRadius? borderRadius,
    Color backgroundColor = const Color(0xFFF5F5F5),
    Color iconColor = Colors.grey,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: image == null ? backgroundColor : null,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          image: image != null
              ? DecorationImage(
                  image: FileImage(image),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo,
                    size: 48,
                    color: iconColor,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: iconColor,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: iconColor,
                        fontSize: 12,
                      ),
                    ),
                ],
              )
            : null,
      ),
    );
  }
}