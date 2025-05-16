// import 'package:carousel_slider/carousel_slider.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:line_icons/line_icons.dart';
import '../../memories_exports.dart';

class AddDetailsToMemoryPage extends StatefulWidget {
  final String memoryId;
  final bool isEditing;
  final List<dynamic>? existingImages;

  const AddDetailsToMemoryPage({
    super.key,
    required this.memoryId,
    this.isEditing = false,
    this.existingImages,
  });

  @override
  State<AddDetailsToMemoryPage> createState() => _AddDetailsToMemoryPageState();
}

class _AddDetailsToMemoryPageState extends State<AddDetailsToMemoryPage> {
  final ImagePicker _picker = ImagePicker();
  List<dynamic> _selectedImages = [];
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      // Fetch memory details when in edit mode
      context.read<MemoriesBloc>().add(FetchMemoryDetails(widget.memoryId));
    }
    if (widget.existingImages != null) {
      _selectedImages = List.from(widget.existingImages!);
    }
    print("Existing Images: ${widget.existingImages}");
  }

  Future<void> _takePicture() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _selectedImages.add(photo);
      });
    }
  }

  Future<void> _selectImagesFromGallery() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images);
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

    // Filter out existing network images and only upload new local images
    final newImages = _selectedImages.whereType<XFile>().toList();

    if (kIsWeb) {
      final bloc = context.read<MemoriesBloc>();
      bloc.add(
        UploadMultipleMemoryImages(
          memoryId: widget.memoryId,
          imagePaths: newImages,
        ),
      );
    } else {
      context.read<MemoriesBloc>().add(
            UploadMultipleMemoryImages(
              memoryId: widget.memoryId,
              imagePaths: newImages,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemoriesBloc, MemoriesState>(
      listener: (context, state) {
        if (state is MemoryDetailsLoaded) {
          setState(() {
            _selectedImages = List.from(state.memory.images);
          });
        } else if (state is MultipleMemoryImagesUploaded) {
          setState(() {
            _isUploading = false;
          });
          DisplayMessage.successMessage(
              'Images ${widget.isEditing ? 'updated' : 'uploaded'} successfully',
              context);
          AppNavigator.pushAndRemove(context,
              const RootPage(initialPage: RootPage.MEMORIES_PAGE_INDEX));
        } else if (state is MemoryError) {
          setState(() {
            _isUploading = false;
          });
          DisplayMessage.errorMessage(state.message, context);
        }
      },
      child: Scaffold(
        appBar:
            setAppBar(widget.isEditing ? "Edit Images" : "Add Images", context),
        body: BlocBuilder<MemoriesBloc, MemoriesState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  widget.isEditing
                      ? 'Edit images for your memory'
                      : 'Add images to your memory',
                  style: const TextStyle(
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
                          valueColor: const AlwaysStoppedAnimation<Color>(
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
                        final image = _selectedImages[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Stack(
                            children: [
                              // Handle both network images (existing) and local files (new)
                              if (image is XFile && !kIsWeb)
                                Image.file(
                                  File(image.path),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              else if (image is XFile && kIsWeb)
                                FutureBuilder<Uint8List>(
                                  future: image.readAsBytes(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      return Image.memory(
                                        snapshot.data!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      );
                                    } else {
                                      return const SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  },
                                )
                              else
                                Image.network(
                                  image.toString(),
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
