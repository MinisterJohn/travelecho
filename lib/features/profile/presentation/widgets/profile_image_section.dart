import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../../profile_exports.dart';

class ProfileImageSection extends StatefulWidget {
  final ProfileState state;
  final UpdateProfileImageUseCase updateProfileImageUseCase =
      sl<UpdateProfileImageUseCase>();

  ProfileImageSection({super.key, required this.state});

  @override
  State<ProfileImageSection> createState() => _ProfileImageSectionState();
}

class _ProfileImageSectionState extends State<ProfileImageSection> {
  File? _image;
  bool _isImageLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    if (_isImageLoading) return;

    setState(() => _isImageLoading = true);

    final XFile? picked = await _picker.pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (picked != null && mounted) {
      final file = File(picked.path);
      setState(() => _image = file);

      // Automatically upload
      await _uploadImage(file);
    }

    if (mounted) setState(() => _isImageLoading = false);
  }

  Future<void> _uploadImage(File file) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    final result = await widget.updateProfileImageUseCase.call(formData);
    result.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Upload failed: $failure')));
        }
      },
      (response) {
        if (response != null &&
            response.containsKey('image') &&
            response['image'] != null &&
            response['image'].containsKey('url')) {
          final imageUrl = response['image']['url'] as String;

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile photo updated')),
            );

            setState(() {
              _image = file; // local preview
            });

            // Optionally, emit updated ProfileLoaded via Bloc here
            // context.read<ProfileBloc>().add(ProfileImageUpdated(imageUrl));
          }
        } else {
          if (mounted) {
            DisplayMessage.errorMessage(
              'Upload failed: invalid response',
              context,
            );
          }
        }
      },
    );
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder:
          (ctx) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.gallery);
                },
              ),
              if (_isImageLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileImage =
        widget.state is ProfileLoaded
            ? (widget.state as ProfileLoaded).profile.image
            : null;

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
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          )
                          : (profileImage != null && profileImage.isNotEmpty)
                          ? DecorationImage(
                            image: NetworkImage(profileImage),
                            fit: BoxFit.cover,
                          )
                          : null,
                ),
              ),
              Positioned(
                bottom: -15,
                left: 15,
                child: GestureDetector(
                  onTap: _isImageLoading ? null : _showImageSourceDialog,
                  child: Container(
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
