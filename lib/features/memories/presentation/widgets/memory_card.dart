import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../memories_exports.dart';

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
                username: username as String,
                location: memory.location,
                onView: onView,
                onEdit: onEdit,
                onDelete: onDelete,
              ),
            ),
          ],
        ),
        WidgetsSpacer.verticalSpacer8,
        Text(
          formatDate(memory.createdAt),
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            
          ),
        ),
        WidgetsSpacer.verticalSpacer16,

        if (memory.images.isNotEmpty) ...[
          _buildImageCarousel(),
          WidgetsSpacer.verticalSpacer8,
          _buildCarouselDots(),
          WidgetsSpacer.verticalSpacer16,
        ],
        _buildMemoryContent(),
        WidgetsSpacer.verticalSpacer32,
      ],
    );
  }

  Widget _buildImageCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enableInfiniteScroll: false,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
      ),
      items: memory.images.map((image) {
        final imagePath = image['url'];
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...[
        const SizedBox(height: 8),
        Text(
          memory.description,
          style: const TextStyle(fontSize: 14),
        ),
      ],
        if (memory.tags.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: memory.tags
                .map((tag) => Text(
                      "#$tag",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 163, 140, 182)),
                    ))
                .toList(),
          ),
        ],
      ],
    );
  }
}
