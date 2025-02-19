import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/appbar.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/core/hoc/bottomModalDraggable.dart';
import 'package:travelecho/features/memories/presentation/pages/addtags.dart';
import 'package:travelecho/features/memories/presentation/pages/collections.dart';
import 'package:travelecho/features/memories/presentation/pages/tagbutton.dart';
import 'package:travelecho/features/memories/presentation/widgets/user_header.dart';
import 'package:travelecho/features/memories/presentation/widgets/validate_discard.dart';

class DescriptionPage extends StatelessWidget {
  final List<String> images = [
    'assets/images/memories/image3.png',
    'assets/images/memories/image4.png',
    'assets/images/memories/image2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("", context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userHeader(),
              WidgetsSpacer.verticalSpacer32,

              // Carousel for images
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    // Change dots or perform any action
                  },
                ),
                items: images.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              WidgetsSpacer.verticalSpacer16,

              // Dots to indicate current image in carousel
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
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
              ),
              WidgetsSpacer.verticalSpacer16,

              // Title description field
              Text(
                'Add a title to describe',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.size16 // Make the text bold
                    ),
              ),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter title',
                  hintStyle: const TextStyle(color: AppColors.secondaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(
                    fontSize: 16), // Optional: Adjust text style
                maxLines:
                    1, // Ensure the text field remains a single line (you can remove or modify if multiline is needed)
                autofocus:
                    false, // Optional: Auto-focus on the text field when the screen is loaded
              ),

              WidgetsSpacer.verticalSpacer16,

              // Tags section
              Text(
                'Add tags that describe your experience',
                style: TextStyle(
                    color: Colors.black, // Set the color to black
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.size14 // Make the text bold
                    ),
              ),
              WidgetsSpacer.verticalSpacer8,
              Text(
                'Select at least 3 tags',
                style: TextStyle(fontSize: FontSize.size14),
              ),
              WidgetsSpacer.verticalSpacer8,

              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  TagButton(tag: '#travels +'),
                  TagButton(tag: '#friends +'),
                  TagButton(tag: '#modern +'),
                ],
              ),
              WidgetsSpacer.verticalSpacer16,
              ElevatedButton(
                onPressed: () {
                  // Navigate to AddTag page
                  DraggableBottomModal(context, AddTagPage());
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor:
                      Colors.transparent, // Default grey background
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                          width: 1, color: AppColors.primaryColor)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text(
                  'Add more',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),

              WidgetsSpacer.verticalSpacer32,

              // Buttons for Discard and Post
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      validatePostDiscard(context);
                    },
                    child: const Text(
                      'Discard',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            elevation: 0,
                            // shape:ROunded,
                            backgroundColor: Colors.white,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Add your memory to collection and create fun experiences. Click the icon.",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                const SizedBox(height: 20),
                                Align(
                                  alignment: Alignment
                                      .centerRight, // Align the button to the right
                                  child: ElevatedButton(
                                    onPressed: () {
                                      AppNavigator.push(
                                          context, CollectionPage());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10), // Reduced width
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Got it',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      minimumSize: Size(70.w, 50.h),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Post',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
