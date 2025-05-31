import 'dart:typed_data';

import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:line_icons/line_icons.dart';
import 'package:photo_view/photo_view.dart';
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
  // late final String memoryId;

  @override
  void initState() {
    super.initState();
    // final currentState = context.read<MemoriesBloc>().state;

    // if (currentState is MemoryCreated) {
    //   memoryId = currentState.memory['_id'] ?? currentState.memory['id'] ?? '';
    // } else if (currentState is MemoryUpdated) {
    //   memoryId = currentState.memory['_id'] ?? currentState.memory['id'] ?? '';
    // } else {
    //   memoryId = '';
    // }

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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const RootPage(initialPage: RootPage.MEMORIES_PAGE_INDEX),
            ),
            (route) => false,
          );
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
                    height: 400.h,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (MediaQuery.of(context).size.width ~/ 150).clamp(
                                2, 4), // Adjust columns based on screen width
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) {
                        final image = _selectedImages[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Stack(
                            children: [
                              // Handle both network images (existing) and local files (new)
                              if (image is XFile && !kIsWeb)
                                Image.file(
                                  File(image.path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
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
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                )
                              else
                                Image.network(
                                  image['url'].toString(),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.width ~/ 150)
                                          .clamp(2,
                                              4), // Match the width of each grid item
                                  padding: const EdgeInsets.all(1),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.defaultColor.withAlpha(200),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.remove_red_eye_outlined,
                                            color: Color.fromARGB(
                                                146, 255, 255, 255)),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child:
                                                      image is XFile && kIsWeb
                                                          ? FutureBuilder<
                                                              Uint8List>(
                                                              future: image
                                                                  .readAsBytes(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot.connectionState ==
                                                                        ConnectionState
                                                                            .done &&
                                                                    snapshot
                                                                        .hasData) {
                                                                  return PhotoView(
                                                                    imageProvider:
                                                                        MemoryImage(
                                                                            snapshot.data!),
                                                                  );
                                                                } else {
                                                                  return const Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          : PhotoView(
                                                              imageProvider: image
                                                                          is XFile &&
                                                                      !kIsWeb
                                                                  ? FileImage(
                                                                      File(image
                                                                          .path))
                                                                  : NetworkImage(
                                                                          image['url']
                                                                              .toString())
                                                                      as ImageProvider,
                                                            ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(LineIcons.times,
                                            color: Color.fromARGB(
                                                146, 255, 255, 255)),
                                        onPressed: () {
                                          setState(() {
                                            _selectedImages.removeAt(index);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _takePicture,
                      child: Container(
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.camera_alt_outlined,
                            color: AppColors.white, size: 30.sp),
                      ),
                    ),
                    WidgetsSpacer.horizontalSpacer20,
                    GestureDetector(
                      onTap: _selectImagesFromGallery,
                      child: Container(
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor100,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.photo_library_outlined,
                            color: AppColors.primaryColor, size: 30.sp),
                      ),
                    ),
                  ],
                ),
                WidgetsSpacer.verticalSpacer16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_selectedImages.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedImages.clear();
                          });
                        },
                        child: const Text(
                          'Clear Images',
                        ),
                      ),
                    WidgetsSpacer.horizontalSpacer8,
                    if (_selectedImages.isNotEmpty &&
                        (!_areImagesEqual(
                            _selectedImages, widget.existingImages)))
                      ElevatedButton(
                        onPressed: _isUploading ? null : _uploadImages,
                        child: _isUploading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                            : const Text(
                                'Upload Images',
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

  bool _areImagesEqual(
      List<dynamic> selectedImages, List<dynamic>? existingImages) {
    if (selectedImages.length != (existingImages?.length ?? 0)) {
      return false;
    }

    for (int i = 0; i < selectedImages.length; i++) {
      final selectedImage = selectedImages[i];
      final existingImage = existingImages![i];

      // Compare based on type (File or Network Image) and content
      if (selectedImage is XFile && existingImage is XFile) {
        // Compare local file paths
        if (selectedImage.path != existingImage.path) {
          return false;
        }
      } else if (selectedImage is Map<String, dynamic> &&
          existingImage is Map<String, dynamic>) {
        // Compare network image URLs
        if (selectedImage['url'] != existingImage['url']) {
          return false;
        }
      } else {
        return false; // Different types, not equal
      }
    }

    return true; // All checks passed, images are equal
  }
}
