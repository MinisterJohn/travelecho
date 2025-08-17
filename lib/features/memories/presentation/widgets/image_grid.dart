import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:photo_view/photo_view.dart';

class ImageGrid extends StatelessWidget {
  final List<dynamic> images;
  final Function(int) onRemove;
  final Function(dynamic) onPreview;
  const ImageGrid({
    super.key,
    required this.images,
    required this.onRemove,
    required this.onPreview,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (MediaQuery.of(context).size.width ~/ 150).clamp(
            2,
            4,
          ),
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
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
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
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
                    width:
                        MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.width ~/ 150).clamp(2, 4),
                    padding: const EdgeInsets.all(1),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.white70,
                          ),
                          onPressed: () => onPreview(image),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white70),
                          onPressed: () => onRemove(index),
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
    );
  }
}

class ImagePreviewDialog {
  static void show(BuildContext context, dynamic image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child:
                image is XFile && kIsWeb
                    ? FutureBuilder<Uint8List>(
                      future: image.readAsBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return PhotoView(
                            imageProvider: MemoryImage(snapshot.data!),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                    : PhotoView(
                      imageProvider:
                          image is XFile && !kIsWeb
                              ? FileImage(File(image.path))
                              : NetworkImage(image['url'].toString())
                                  as ImageProvider,
                    ),
          ),
        );
      },
    );
  }
}

class ImageCompareHelper {
  static bool areImagesEqual(
    List<dynamic> selectedImages,
    List<dynamic>? existingImages,
  ) {
    if (selectedImages.length != (existingImages?.length ?? 0)) {
      return false;
    }
    for (int i = 0; i < selectedImages.length; i++) {
      final selectedImage = selectedImages[i];
      final existingImage = existingImages![i];
      if (selectedImage is XFile && existingImage is XFile) {
        if (selectedImage.path != existingImage.path) {
          return false;
        }
      } else if (selectedImage is Map<String, dynamic> &&
          existingImage is Map<String, dynamic>) {
        if (selectedImage['url'] != existingImage['url']) {
          return false;
        }
      } else {
        return false;
      }
    }
    return true;
  }
}
