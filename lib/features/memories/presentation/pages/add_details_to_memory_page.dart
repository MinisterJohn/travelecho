import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../memories_exports.dart'; // keep your app-level exports

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
  String _subscriptionType = 'free';

  @override
  void initState() {
    super.initState();

    _loadSubscriptionType();

    if (widget.isEditing) {
      context.read<MemoriesBloc>().add(FetchMemoryDetails(widget.memoryId));
    }

    if (widget.existingImages != null) {
      _selectedImages = List.from(widget.existingImages!);
    }
  }

  Future<void> _loadSubscriptionType() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _subscriptionType = prefs.getString('plan') ?? 'FREE';
    });
    print(prefs.getString('plan'));
  }

  List<dynamic> _selectedImages = [];
  bool _isUploading = false;

  Future<void> _takePicture() async {
    final photo = await ImageUploadHelper.pickImageFromCamera(context);
    if (photo != null) {
      final totalImages = _selectedImages.length + 1;
      print(_subscriptionType);
      if (_subscriptionType == 'FREE' && totalImages > 5) {
        upgradeToPro(context);
      } else {
        setState(() => _selectedImages.add(photo));
      }
    }
  }

  Future<void> _selectImagesFromGallery() async {
    final images = await ImageUploadHelper.pickImagesFromGallery(context);
    if (images.isNotEmpty) {
      final totalImages = _selectedImages.length + images.length;
      print(_subscriptionType);
      if (_subscriptionType == 'FREE' && totalImages > 5) {
        upgradeToPro(context);
      } else {
        setState(() => _selectedImages.addAll(images));
      }
    }
  }

  void _uploadImages() {
    ImageUploadHelper.uploadImages(
      context: context,
      memoryId: widget.memoryId,
      selectedImages: _selectedImages,
      onUploading: () => setState(() => _isUploading = true),
      onUploaded: () {
        setState(() => _isUploading = false);
        DisplayMessage.successMessage(
          'Images ${widget.isEditing ? 'updated' : 'uploaded'} successfully',
          context,
        );
    
      },
      onError: (message) {
        setState(() => _isUploading = false);
        DisplayMessage.errorMessage(message, context);
      },
    );
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
          setState(() => _isUploading = false);
          DisplayMessage.successMessage(
            'Images ${widget.isEditing ? 'updated' : 'uploaded'} successfully',
            context,
          );
          AppNavigator.pop(context);
        } else if (state is MemoryError) {
          setState(() => _isUploading = false);
          DisplayMessage.errorMessage(state.message, context);
        }
      },
      child: Scaffold(
        appBar: setAppBar(
          widget.isEditing ? "Edit Images" : "Add Images",
          context,
        ),
        body: BlocBuilder<MemoriesBloc, MemoriesState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WidgetsSpacer.verticalSpacer20,
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
                  WidgetsSpacer.verticalSpacer20,
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
                        WidgetsSpacer.verticalSpacer8,
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
                  WidgetsSpacer.verticalSpacer20,
                  Expanded(
                    child: ImageGrid(
                      images: _selectedImages,
                      onRemoveAt:
                          (index) =>
                              setState(() => _selectedImages.removeAt(index)),
                    ),
                  ),
                ] else
                  const Spacer(),
                ActionBar(
                  onTakePicture: _takePicture,
                  onSelectFromGallery: _selectImagesFromGallery,
                  onClear:
                      _selectedImages.isNotEmpty
                          ? () => setState(() => _selectedImages.clear())
                          : null,
                  onUpload:
                      (_selectedImages.isNotEmpty &&
                              !areImagesEqual(
                                _selectedImages,
                                widget.existingImages,
                              ))
                          ? (_isUploading ? null : _uploadImages)
                          : null,
                  isUploading: _isUploading,
                ),
                const SizedBox(height: 40),
              ],
            );
          },
        ),
      ),
    );
  }
}
