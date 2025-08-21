import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../community_exports.dart';

const int MAX_POST_CONTENT_LENGTH = 5000;
const int MAX_POST_MEDIA = 100;
const int MAX_POST_MEDIA_SIZE = 50 * 1024 * 1024; // 50MB

class CreatePostPage extends StatefulWidget {
  final ScrollController scrollController;
  const CreatePostPage({super.key, required this.scrollController});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final SharedPreferences _prefs = sl<SharedPreferences>();

  final List<String> _tags = [];
  final List<File> _files = [];
  bool isPublic = true;
  late String userId;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    userId = _prefs.getString("user_id") ?? "";
    _contentController.addListener(_validate);
  }

  void _validate() {
    setState(() {
      _isValid =
          _contentController.text.trim().length >= 10 &&
          _contentController.text.trim().length <= MAX_POST_CONTENT_LENGTH;
    });
  }

  /// Pick files (images, videos, etc.)
  void _pickFiles(List<File> files) {
    if (_files.length + files.length > MAX_POST_MEDIA) {
      DisplayMessage.errorMessage(
        "Cannot select more than $MAX_POST_MEDIA files.",
        context,
      );
      return;
    }

    for (var file in files) {
      if (file.lengthSync() > MAX_POST_MEDIA_SIZE) {
        DisplayMessage.errorMessage(
          "File too large: ${file.path.split('/').last}",
          context,
        );
        return;
      }
    }

    setState(() {
      _files.addAll(files);
    });
  }

  void _submit() async {
    final content = _contentController.text.trim();

    if (content.isEmpty || content.length > MAX_POST_CONTENT_LENGTH) {
      DisplayMessage.errorMessage(
        "Content must be 1-${MAX_POST_CONTENT_LENGTH} characters.",
        context,
      );
      return;
    }

    if (_files.length > MAX_POST_MEDIA) {
      DisplayMessage.errorMessage(
        "Cannot upload more than $MAX_POST_MEDIA files.",
        context,
      );
      return;
    }

    final formData = FormData();

    formData.fields
      ..add(MapEntry("user", userId))
      ..add(MapEntry("content", content))
      ..add(MapEntry("isPublic", isPublic.toString()))
      ..add(MapEntry("tags", _tags.join(", ")));

    // Only attach files to FormData if you want server to receive them directly
    // You can also just send empty formData and upload via separate media use case
    for (int i = 0; i < _files.length; i++) {
      final file = _files[i];
      formData.files.add(
        MapEntry(
          "file_${i + 1}",
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
        ),
      );
    }

    debugPrint("📤 Sending FormData: ${formData.fields}");

    // Use the new Bloc event that handles media upload
    context.read<PostBloc>().add(
      CreatePostWithMediaEvent(
        formData: formData,
        mediaFiles: _files, // pass the selected files
      ),
    );
  }

  @override
  void dispose() {
    _contentController.removeListener(_validate);
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostsLoaded) {
          AppNavigator.pop(context);
          DisplayMessage.successMessage("Post created successfully", context);
        } else if (state is PostError) {
          DisplayMessage.errorMessage(state.message, context);
        }
      },
      builder: (context, state) {
        final isLoading = state is PostLoading;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CreatePostHandle(),
                CreatePostHeader(
                  onChanged: (val) => setState(() => isPublic = val),
                  isPublic: isPublic,
                ),
                WidgetsSpacer.verticalSpacer16,
                CreatePostContent(controller: _contentController),
                WidgetsSpacer.verticalSpacer16,
                CreatePostTags(
                  tags: _tags,
                  controller: _tagsController,
                  onAdd:
                      (tag) => setState(() {
                        if (!_tags.contains(tag)) _tags.add(tag);
                      }),
                  onRemove: (tag) => setState(() => _tags.remove(tag)),
                ),
                WidgetsSpacer.verticalSpacer16,
                CreatePostMedia(
                  files: _files,
                  onPick: _pickFiles,
                  onRemove: (index) => setState(() => _files.removeAt(index)),
                ),
                WidgetsSpacer.verticalSpacer32,
                Center(
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : (_isValid ? _submit : null),
                    icon:
                        isLoading
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                            : const Icon(Icons.add),
                    style: mergeWithThemeButtonStyle(
                      context,
                      ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                        backgroundColor:
                            isLoading
                                ? AppColors.primaryColor
                                : (_isValid
                                    ? AppColors.primaryColor
                                    : AppColors.defaultColor400),
                      ),
                    ),
                    label:
                        isLoading
                            ? const Text(
                              "Posting...",
                              style: TextStyle(color: Colors.white),
                            )
                            : const Text("Post"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
