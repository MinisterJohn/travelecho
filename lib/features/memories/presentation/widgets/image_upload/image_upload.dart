import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../memories_exports.dart';

class ImageUploadHelper {
  static Future<XFile?> pickImageFromCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.camera);
  }

  static Future<List<XFile>> pickImagesFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickMultiImage();
  }

  static void uploadImages({
    required BuildContext context,
    required String memoryId,
    required List<dynamic> selectedImages,
    required VoidCallback onUploading,
    required VoidCallback onUploaded,
    required Function(String) onError,
  }) {
    if (selectedImages.isEmpty) {
      DisplayMessage.errorMessage('Please select at least one image', context);
      return;
    }
    onUploading();
    final newImages = selectedImages.whereType<XFile>().toList();
    final bloc = context.read<MemoriesBloc>();
    late final StreamSubscription<MemoriesState> subscription;
    subscription = bloc.stream.listen((state) {
      if (state is MultipleMemoryImagesUploaded) {
        onUploaded();
        subscription.cancel();
      } else if (state is MemoryError) {
        onError(state.message);
        subscription.cancel();
      }
    });
    bloc.add(
      UploadMultipleMemoryImages(memoryId: memoryId, imagePaths: newImages),
    );
  }

  static void showCameraPermissionDialog({
    required BuildContext context,
    required VoidCallback onAllow,
    required VoidCallback onDeny,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Allow access to camera',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Allow Travel Echo to access your camera to take photos.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: onAllow,
                child: const Text(
                  'Allow access',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: onDeny,
                child: const Text(
                  "Don't allow access to camera",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
