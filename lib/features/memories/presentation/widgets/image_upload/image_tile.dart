// lib/widgets/image_tile.dart
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ImageTile extends StatelessWidget {
  final dynamic image; // XFile or Map (network image with 'url')
  final VoidCallback onRemove;
  final int columns;

  const ImageTile({
    super.key,
    required this.image,
    required this.onRemove,
    required this.columns,
  });

  // double _tileWidth(BuildContext context) {
  //   final totalWidth = MediaQuery.of(context).size.width;
  //   return totalWidth / columns;
  // }

  void _showPreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Widget content;

        if (image is XFile && kIsWeb) {
          content = FutureBuilder<Uint8List>(
            future: (image as XFile).readAsBytes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return PhotoView(imageProvider: MemoryImage(snapshot.data!));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        } else if (image is XFile && !kIsWeb) {
          content = PhotoView(
            imageProvider: FileImage(File((image as XFile).path)),
          );
        } else {
          final url = image['url']?.toString() ?? '';
          content = PhotoView(imageProvider: NetworkImage(url));
        }

        return Dialog(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: content,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        children: [
          // Image (local file / memory / network)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: _buildImageWidget(),
            ),
          ),

          // bottom overlay with icons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(140),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Color.fromARGB(200, 255, 255, 255),
                    ),
                    onPressed: () => _showPreview(context),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Color.fromARGB(200, 255, 255, 255),
                    ),
                    onPressed: onRemove,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget() {
    if (image is XFile && !kIsWeb) {
      return Image.file(
        File((image as XFile).path),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else if (image is XFile && kIsWeb) {
      return FutureBuilder<Uint8List>(
        future: (image as XFile).readAsBytes(),
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
      );
    } else {
      // assume network image map with 'url'
      final url = image['url']?.toString() ?? '';
      return Image.network(
        url,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, _, __) =>
            const Center(child: Icon(Icons.broken_image)),
      );
    }
  }
}
