// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:line_icons/line_icons.dart';
import '../../memories_exports.dart';
import 'dart:convert';

class AddDetailsToMemoryPage extends StatefulWidget {
  final String memoryId;

  const AddDetailsToMemoryPage({
    super.key,
    required this.memoryId,
  });

  @override
  State<AddDetailsToMemoryPage> createState() => _AddDetailsToMemoryPageState();
}

class _AddDetailsToMemoryPageState extends State<AddDetailsToMemoryPage> {
  final ImagePicker _picker = ImagePicker();
  List<String> _selectedImages = [];
  bool _isUploading = false;

  Future<void> _takePicture() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _selectedImages.add(photo.path);
      });
    }
  }

  Future<void> _selectImagesFromGallery() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      final imagePaths = images.map((e) => e.path).toList();
      print("ImagePaths: $imagePaths");
      setState(() {
        _selectedImages.addAll(imagePaths);
      });
    }
  }

  void _uploadImages() {
    print("Memory ID: ${widget.memoryId}");
    if (_selectedImages.isEmpty) {
      DisplayMessage.errorMessage('Please select at least one image', context);
      return;
    }

    setState(() {
      _isUploading = true;
    });

    if (kIsWeb) {
      final bloc = context.read<MemoriesBloc>();
      final imagePromises = _selectedImages.map((path) async {
        final XFile file = XFile(path);
        return await file.readAsBytes();
      }).toList();

      Future.wait(imagePromises).then((imageBytes) {
        if (!mounted) return;
        bloc.add(
          UploadMultipleMemoryImages(
            memoryId: widget.memoryId,
            imagePaths: imageBytes,
          ),
        );
      }).catchError((error) {
        if (!mounted) return;
        setState(() {
          _isUploading = false;
        });
        DisplayMessage.errorMessage('Failed to process images', context);
      });
    } else {
      context.read<MemoriesBloc>().add(
            UploadMultipleMemoryImages(
              memoryId: widget.memoryId,
              imagePaths: _selectedImages,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemoriesBloc, MemoriesState>(
      listener: (context, state) {
        print(state);
        if (state is MultipleMemoryImagesUploaded) {
          setState(() {
            _isUploading = false;
          });
          DisplayMessage.successMessage(
              'Images uploaded successfully', context);
          AppNavigator.push(
              context,
              BlocProvider.value(
                  value: sl<MemoriesBloc>(), child: const MemoriesHomePage()));
        } else if (state is MemoryError) {
          setState(() {
            _isUploading = false;
          });
          DisplayMessage.errorMessage(state.message, context);
        }
      },
      child: Scaffold(
        appBar: setAppBar("Add Images", context),
        body: BlocBuilder<MemoriesBloc, MemoriesState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Add images to your memory',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Select images from your gallery or take new photos',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ),
                if (state is UploadProgress) ...[
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          value: state.progress,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Uploading image ${state.currentImage} of ${state.totalImages}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (_selectedImages.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Stack(
                            children: [
                              kIsWeb
                                  ? Image.network(
                                      _selectedImages[index],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(_selectedImages[index]),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                              Positioned(
                                right: 0,
                                child: IconButton(
                                  icon: const Icon(LineIcons.trash,
                                      color: AppColors.primaryColor),
                                  onPressed: () {
                                    setState(() {
                                      _selectedImages.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
                const Spacer(),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => _requestPermission(context),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Take a photo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _selectImagesFromGallery(),
                      child: const Text(
                        'Upload from gallery',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_selectedImages.isNotEmpty)
                      ElevatedButton(
                        onPressed: _isUploading ? null : _uploadImages,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                        ),
                        child: _isUploading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Upload Images',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            );
          },
        ),
      ),
    );
  }

  void _requestPermission(BuildContext context) {
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Allow Travel Echo to access your camera to take photos.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  DisplayMessage.successMessage("Access Granted", context);
                  Navigator.pop(context);
                  _takePicture();
                },
                child: const Text(
                  'Allow access',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  "Don't allow access to camera",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
