import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../community_exports.dart';
// import 'package:video_player/video_player.dart';

class CreatePostMedia extends StatefulWidget {
  final List<File> files;
  final void Function(List<File>) onPick;
  final void Function(int) onRemove;

  const CreatePostMedia({
    super.key,
    required this.files,
    required this.onPick,
    required this.onRemove,
  });

  @override
  State<CreatePostMedia> createState() => _CreatePostMediaState();
}

class _CreatePostMediaState extends State<CreatePostMedia> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFiles(BuildContext context) async {
    if (widget.files.length >= MAX_POST_MEDIA) {
      DisplayMessage.errorMessage(
        "Cannot select more than $MAX_POST_MEDIA files.",
        context,
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      builder:
          (ctx) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () async {
                  Navigator.pop(ctx);
                  final pickedImages = await _picker.pickMultiImage();
                  if (pickedImages.isNotEmpty) {
                    final files =
                        pickedImages.map((e) => File(e.path)).toList();
                    _validateAndPick(files);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.pop(ctx);
                  final photo = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (photo != null) _validateAndPick([File(photo.path)]);
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_library),
                title: const Text('Pick Video'),
                onTap: () async {
                  Navigator.pop(ctx);
                  final video = await _picker.pickVideo(
                    source: ImageSource.gallery,
                  );
                  if (video != null) _validateAndPick([File(video.path)]);
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text('Record Video'),
                onTap: () async {
                  Navigator.pop(ctx);
                  final video = await _picker.pickVideo(
                    source: ImageSource.camera,
                  );
                  if (video != null) _validateAndPick([File(video.path)]);
                },
              ),
            ],
          ),
    );
  }

  void _validateAndPick(List<File> files) {
    for (var file in files) {
      if (file.lengthSync() > MAX_POST_MEDIA_SIZE) {
        DisplayMessage.errorMessage(
          "File too large: ${file.path.split('/').last}",
          context,
        );
        return;
      }
    }

    if (widget.files.length + files.length > MAX_POST_MEDIA) {
      DisplayMessage.errorMessage(
        "Cannot select more than $MAX_POST_MEDIA files.",
        context,
      );
      return;
    }

    widget.onPick(files);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          icon: const Icon(Icons.add_a_photo_outlined),
          label: const Text(
            "Add Media",
            style: TextStyle(color: AppColors.primaryColor),
          ),
          onPressed: () => _pickFiles(context),
        ),
        if (widget.files.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                widget.files.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final file = entry.value;
                  final isVideo =
                      file.path.endsWith('.mp4') ||
                      file.path.endsWith('.mov') ||
                      file.path.endsWith('.avi');

                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child:
                              isVideo
                                  ? Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(color: Colors.black12),
                                      const Icon(
                                        Icons.videocam,
                                        color: Colors.white,
                                        size: 36,
                                      ),
                                    ],
                                  )
                                  : Image.file(
                                    file,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () => widget.onRemove(idx),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(50),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
          ),
      ],
    );
  }
}
