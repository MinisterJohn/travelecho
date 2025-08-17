// lib/widgets/image_grid.dart
// import 'dart:io';
// import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../memories_exports.dart';

class ImageGrid extends StatelessWidget {
  final List<dynamic> images;
  final void Function(int index) onRemoveAt;

  const ImageGrid({
    super.key,
    required this.images,
    required this.onRemoveAt,
  });

  int _columnsForWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 150).clamp(2, 4);
  }

  @override
  Widget build(BuildContext context) {
    final columns = _columnsForWidth(context);
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        final image = images[index];
        return ImageTile(
          image: image,
          onRemove: () => onRemoveAt(index),
          columns: columns,
        );
      },
    );
  }
}
