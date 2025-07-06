import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, consolidateHttpClientResponseBytes;
import 'package:line_icons/line_icons.dart';
import '../../passport_exports.dart';

class UploadTravelDocumentPhotoPage extends StatefulWidget {
  final TravelDocumentModel passport;
  const UploadTravelDocumentPhotoPage({super.key, required this.passport});

  @override
  State<UploadTravelDocumentPhotoPage> createState() =>
      _UploadTravelDocumentPhotoPageState();
}

class _UploadTravelDocumentPhotoPageState
    extends State<UploadTravelDocumentPhotoPage> {
  final ImagePicker _picker = ImagePicker();
  List<dynamic> _selectedImages = [];
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    // Initialize with existing images if any
    if (widget.passport.imageUrls.isNotEmpty) {
      _selectedImages = List.from(
        widget.passport.imageUrls.map((url) => {'url': url}),
      );
    }
  }

  Future<void> _scanPhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _selectedImages.add(photo);
      });
    }
  }

  Future<void> _scanMultiplePhotos() async {
    // Allow user to take multiple photos one after another
    bool addMore = true;
    while (addMore) {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          _selectedImages.add(photo);
        });
        addMore = await _showAddMoreDialog();
      } else {
        addMore = false;
      }
    }
  }

  Future<bool> _showAddMoreDialog() async {
    bool? result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add another photo?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.defaultColor400,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Add More',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
    );
    return result ?? false;
  }

  Future<void> _uploadImagesFromGallery() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images);
      });
    }
  }

  Future<void> _editImage(int index) async {
    final image = _selectedImages[index];
    XFile? fileToEdit;
    if (image is XFile) {
      fileToEdit = image;
    } else if (image is Map && image['url'] != null) {
      // Download the image to a temp file
      try {
        final url = image['url'];
        final tempDir = Directory.systemTemp;
        final fileName = url.split('/').last;
        final tempFile = File('${tempDir.path}/$fileName');
        // Use http package to download
        final httpClient = HttpClient();
        final request = await httpClient.getUrl(Uri.parse(url));
        final response = await request.close();
        final bytes = await consolidateHttpClientResponseBytes(response);
        await tempFile.writeAsBytes(bytes);
        fileToEdit = XFile(tempFile.path);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download image for editing: $e')),
        );
        return;
      }
    }
    if (fileToEdit == null) return;
    final cropped = await ImageCropper().cropImage(
      sourcePath: fileToEdit.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Edit Image',
          toolbarColor: AppColors.primaryColor,
          toolbarWidgetColor: AppColors.primaryColor100,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Edit Image'),
      ],
    );
    if (cropped != null) {
      setState(() {
        _selectedImages[index] = XFile(cropped.path);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _uploadImages() async {
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select or scan images.')),
      );
      return;
    }
    setState(() => isUploading = true);

    // Separate new and existing images
    final newImages = _selectedImages.whereType<XFile>().toList();
    final existingImages =
        _selectedImages
            .where((img) => img is Map && img['url'] != null)
            .map((img) => img['url'].toString())
            .toList();

    context.read<TravelDocumentBloc>().add(
      UploadTravelDocumentImagesEvent(
        passportId: widget.passport.id,
        filePath: [...existingImages, ...newImages.map((xfile) => xfile.path)],
        // existingImageUrls: existingImages,
      ),
    );

    await Future.delayed(const Duration(seconds: 2)); // Simulate upload

    setState(() => isUploading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('TravelDocument images uploaded successfully!'),
      ),
    );
    // AppNavigator.pop(context);
    // AppNavigator.pop(context);
    AppNavigator.push(
      context,
      BlocProvider.value(
        value: sl<TravelDocumentBloc>(),
        child: TravelDocumentDetailsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(
        'Upload TravelDocument Photos',
        context,
        backAction: () {
          AppNavigator.pushAndRemove(
            context,
            BlocProvider.value(
              value: sl<TravelDocumentBloc>(),
              child: AddEditTravelDocumentPage(passport: widget.passport),
            ),
          );
        },
        actions: [
          TextButton(
            onPressed: () {
              AppNavigator.pushReplacement(
                context,
                BlocProvider.value(
                  value: sl<TravelDocumentBloc>(),
                  child: TravelDocumentDetailsPage(),
                ),
              );
            },
            child: Text(
              "Skip",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.defaultColor400,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              'Scan or upload passport images',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Snap multiple photos or upload from your gallery. You can edit or remove each image.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),

            // Show existing passport images if any
            if (_selectedImages.isNotEmpty)
              SizedBox(
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
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
                          Positioned.fill(
                            child:
                                image is XFile
                                    ? (kIsWeb
                                        ? FutureBuilder<Uint8List>(
                                          future: image.readAsBytes(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                    ConnectionState.done &&
                                                snapshot.hasData) {
                                              return Image.memory(
                                                snapshot.data!,
                                                fit: BoxFit.cover,
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        )
                                        : Image.file(
                                          File(image.path),
                                          fit: BoxFit.cover,
                                        ))
                                    : Image.network(
                                      image['url'].toString(),
                                      fit: BoxFit.cover,
                                    ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: AppColors.defaultColor400,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: () => _editImage(index),
                                    tooltip: 'Edit',
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: () => _removeImage(index),
                                    tooltip: 'Remove',
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
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Scan (camera, multiple)
                GestureDetector(
                  onTap: _scanMultiplePhotos,
                  child: Container(
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor100,
                      border: Border.all(
                        color: AppColors.primaryColor300,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      LineIcons.camera,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // Upload (gallery, multiple)
                GestureDetector(
                  onTap: _uploadImagesFromGallery,
                  child: Container(
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor100,
                      border: Border.all(
                        color: AppColors.primaryColor300,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.image_outlined,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: isUploading ? null : _uploadImages,
              icon:
                  isUploading
                      ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Icon(Icons.cloud_upload),
              label: Text(
                isUploading ? 'Uploading...' : 'Upload',
                style: TextStyle(
                  fontSize: FontSize.size16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
