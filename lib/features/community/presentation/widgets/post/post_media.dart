import 'package:flutter/material.dart';

Widget buildPostMedia(BuildContext context, List<String> media) {
  if (media.isEmpty) return const SizedBox.shrink();

  // Helper to open fullscreen viewer
  void _openFullScreen(int initialIndex) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              PageView(
                controller: PageController(initialPage: initialIndex),
                children: media
                    .map(
                      (url) => InteractiveViewer(
                        child: Image.network(url, fit: BoxFit.contain),
                      ),
                    )
                    .toList(),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Layout logic
  if (media.length == 1) {
    return GestureDetector(
      onTap: () => _openFullScreen(0),
      child: _buildImage(media[0], fit: BoxFit.cover),
    );
  }

  if (media.length == 2) {
    return Row(
      children: List.generate(2, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () => _openFullScreen(index),
              child: _buildImage(media[index], fit: BoxFit.cover),
            ),
          ),
        );
      }),
    );
  }

  // Three or more images
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: () => _openFullScreen(0),
            child: _buildImage(media[0], fit: BoxFit.cover),
          ),
        ),
      ),
      Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: GestureDetector(
                onTap: () => _openFullScreen(1),
                child: _buildImage(media[1], fit: BoxFit.cover, height: 100),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: GestureDetector(
                onTap: () => _openFullScreen(2),
                child: Stack(
                  children: [
                    _buildImage(media[2], fit: BoxFit.cover, height: 100),
                    if (media.length > 3)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "+${media.length - 2}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildImage(
  String url, {
  BoxFit fit = BoxFit.cover,
  double height = 200,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.network(
      url,
      fit: fit,
      height: height,
      width: double.infinity,
    ),
  );
}
