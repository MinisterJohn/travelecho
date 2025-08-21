import 'package:flutter/material.dart' hide CarouselController;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:readmore/readmore.dart';
import '../../../memories_exports.dart';

class MemoryCard extends StatelessWidget {
  final MemoryModel memory;
  // final String username;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MemoryCard({
    super.key,
    required this.memory,
    // required this.username,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final SharedPreferences prefs = sl<SharedPreferences>();
    final String? username = prefs.getString('name');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: UserHeader(
                username: username ?? '',
                location: memory.location,
                createdAt: memory.date,
                onView: onView,
                onEdit: onEdit,
                onDelete: onDelete,
              ),
            ),
          ],
        ),
        WidgetsSpacer.verticalSpacer8,
        _buildMemoryContent(),
        WidgetsSpacer.verticalSpacer16,
        if (memory.images.isNotEmpty) ...[
          _buildImageGallery(context),
          // WidgetsSpacer.verticalSpacer8,
          // _buildCarouselDots(),
          WidgetsSpacer.verticalSpacer16,
        ],
        if (memory.location != '')
          SizedBox(
            width: 280,
            child: Text(
              "Location: ${memory.location}",
              style: const TextStyle(color: AppColors.defaultColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        if (memory.tags.isNotEmpty) ...[
          // WidgetsSpacer.verticalSpacer8,
          Wrap(
            spacing: 8,
            children:
                memory.tags
                    .map(
                      (tag) => Text(
                        "#$tag",
                        style: const TextStyle(color: AppColors.primaryColor),
                      ),
                    )
                    .toList(),
          ),
        ],
        WidgetsSpacer.verticalSpacer32,
      ],
    );
  }

  Widget _buildImageGallery(BuildContext context) {
    final images = memory.images;

    if (images.isEmpty) return const SizedBox.shrink();

    if (images.length == 1) {
      // ✅ One image - full width
      return _buildImage(images[0]['url'], fit: BoxFit.cover);
    }

    if (images.length == 2) {
      // ✅ Two images - side by side
      return Row(
        children:
            images.map((img) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: _buildImage(img['url'], fit: BoxFit.cover),
                ),
              );
            }).toList(),
      );
    }

    // ✅ Three or more images
    return Row(
      children: [
        // First big image
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: _buildImage(images[0]['url'], fit: BoxFit.cover),
          ),
        ),

        // Right column
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: _buildImage(
                  images[1]['url'],
                  fit: BoxFit.cover,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Stack(
                  children: [
                    _buildImage(
                      images[2]['url'],
                      fit: BoxFit.cover,
                      height: 100,
                    ),
                    if (images.length > 3)
                      Positioned.fill(
                        // <-- This makes it cover the whole image
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "+${images.length - 2}",
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

  Widget _buildCarouselDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        memory.images.length,
        (index) => Container(
          width: 10.0,
          height: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: const BoxDecoration(
            color: AppColors.secondaryColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildMemoryContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          memory.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        if (memory.description != '') ...[
          ReadMoreText(
            memory.description,
            trimLines: 3,
            colorClickableText: AppColors.primaryColor,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read more',
            trimExpandedText: 'Show less',
            style: TextStyle(fontSize: FontSize.size16),
          ),
        ],
      ],
    );
  }
}
