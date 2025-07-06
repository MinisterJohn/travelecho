import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../../../passport_exports.dart';

class TravelDocumentImagesTab extends StatelessWidget {
  final List<dynamic> images;
  const TravelDocumentImagesTab({super.key, required this.images});

  void _showFullImage(
    BuildContext context,
    List<dynamic> images,
    int initialIndex,
  ) {
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            backgroundColor: Colors.transparent,
            child: _FullScreenImageViewer(
              images: images,
              initialIndex: initialIndex,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const Center(child: Text('No images available'));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("TravelDocument Images", style: TextStyle(fontSize: 20)),
        WidgetsSpacer.verticalSpacer16,
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children:
              images.asMap().entries.map((entry) {
                final idx = entry.key;
                final img = entry.value;
                return GestureDetector(
                  onTap: () => _showFullImage(context, images, idx),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child:
                        img is XFile
                            ? (kIsWeb
                                ? FutureBuilder<Uint8List>(
                                  future: img.readAsBytes(),
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
                                : Image.file(
                                  File(img.path),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ))
                            : Image.network(
                              img is String ? img : img['url'].toString(),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) => const Icon(
                                    Icons.broken_image,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                            ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}

class _FullScreenImageViewer extends StatefulWidget {
  final List<dynamic> images;
  final int initialIndex;
  const _FullScreenImageViewer({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<_FullScreenImageViewer> {
  late PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: widget.images.length,
          onPageChanged: (index) => setState(() => _currentIndex = index),
          itemBuilder: (context, index) {
            final img = widget.images[index];
            return GestureDetector(
              onTap: () => Navigator.pop(context),
              child: InteractiveViewer(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:
                      img is XFile
                          ? (kIsWeb
                              ? FutureBuilder<Uint8List>(
                                future: img.readAsBytes(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                    return Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.contain,
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              )
                              : Image.file(File(img.path), fit: BoxFit.contain))
                          : Image.network(
                            img is String ? img : img['url'].toString(),
                            fit: BoxFit.contain,
                          ),
                ),
              ),
            );
          },
        ),
        if (widget.images.length > 1)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_currentIndex + 1} / ${widget.images.length}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
      ],
    );
  }
}
