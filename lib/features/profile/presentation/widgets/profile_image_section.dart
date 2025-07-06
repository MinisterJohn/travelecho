import 'package:flutter/material.dart' hide CarouselController;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import '../../profile_exports.dart';
import 'dart:io';

class ProfileImageSection extends StatefulWidget {
  final ProfileState state;
  final Function(dynamic) onImageSelected;

  const ProfileImageSection({
    super.key,
    required this.state,
    required this.onImageSelected,
  });

  @override
  State<ProfileImageSection> createState() => _ProfileImageSectionState();
}

class _ProfileImageSectionState extends State<ProfileImageSection> {
  dynamic _image;
  bool _isImageLoading = false;

  Future<void> _takePicture() async {
    if (_isImageLoading) return;

    setState(() => _isImageLoading = true);
    // try {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (image != null && mounted) {
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        setState(() => _image = bytes);
      } else {
        setState(() => _image = File(image.path));
      }
      widget.onImageSelected(image.path);
    }
    // } catch (e) {
    //   if (mounted) {
    //     DisplayMessage.errorMessage(
    //         "Failed to update profile photo: $e", context);
    //   }
    // } finally {
    if (mounted) {
      setState(() => _isImageLoading = false);
      // }
    }
  }

  void _showCameraDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Take a real-time picture",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _takePicture();
                },
                child: const Text(
                  "Open Camera",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              if (_isImageLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showProfilePhotoAddedNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: AppColors.primaryColor),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Profile Photo Added",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.check, size: 16, color: Colors.white),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 156, 126, 126),
                  image:
                      _image != null
                          ? DecorationImage(
                            image:
                                kIsWeb
                                    ? MemoryImage(_image as Uint8List)
                                    : FileImage(_image as File)
                                        as ImageProvider,
                            fit: BoxFit.cover, // or BoxFit.none
                            alignment: Alignment.topCenter, // 👈 key part
                          )
                          : (widget.state is ProfileLoaded &&
                              (widget.state as ProfileLoaded)
                                  .profile
                                  .image
                                  .isNotEmpty)
                          ? DecorationImage(
                            image: NetworkImage(
                              (widget.state as ProfileLoaded).profile.image,
                            ),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          )
                          : null,
                ),
              ),
              Positioned(
                bottom: -15,
                left: 15,
                child: GestureDetector(
                  onTap: _isImageLoading ? null : _showCameraDialog,
                  child: Container(
                    // constraints: const BoxConstraints(maxWidth: 100),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 20,
                          child:
                              _isImageLoading
                                  ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : const Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _isImageLoading ? "Uploading..." : "Add",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
