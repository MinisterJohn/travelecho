import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class CarRentalsDriverDetailsScreen extends StatelessWidget {
  const CarRentalsDriverDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: appBarIconButton(context, null),
        title: const Text(
          "Driver Details",
          style: TextStyle(
            color: AppColors.defaultColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: WidgetsSpacer.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WidgetsSpacer.verticalSpacer16,
            Center(
              child: CircleAvatar(
                radius: 44,
                backgroundImage: AssetImage(
                  "assets/images/driver_avatar.png",
                ), // Replace with your asset
              ),
            ),
            WidgetsSpacer.verticalSpacer16,
            const Text(
              "Charlie Davison",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            WidgetsSpacer.verticalSpacer8,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.location_on, size: 18, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  "USA",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                SizedBox(width: 16),
                Icon(Icons.language, size: 18, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  "English",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
            WidgetsSpacer.verticalSpacer20,
            // Ranking & Experience
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.07),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Column(
                    children: [
                      Text(
                        "4.9",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Ranking",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                    width: 32,
                    indent: 2,
                    endIndent: 2,
                  ),
                  Column(
                    children: [
                      Text(
                        "4 yrs",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Experience",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            WidgetsSpacer.verticalSpacer20,
            // Reviews header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Reviews",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            WidgetsSpacer.verticalSpacer16,
            // Review 1
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(
                      "assets/images/reviewer1.png",
                    ), // Replace with your asset
                  ),
                  WidgetsSpacer.horizontalSpacer8,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Devon Dan",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Charlie is just awesome! Super chill guy, knows the city like the back of his hand. Got me through traffic in record time without driving like a maniac.",
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Review 2
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(
                      "assets/images/reviewer2.png",
                    ), // Replace with your asset
                  ),
                  WidgetsSpacer.horizontalSpacer8,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Fadah bek",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Very good experience with Charlie Dan. He was punctual, polite, and the car was very comfortable. Exactly what I needed after a long flight.",
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            WidgetsSpacer.verticalSpacer32,
            // Call and Message buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      side: const BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(0, 44),
                    ),
                    onPressed: () {
                      AppNavigator.push(context, const CarRentalsCallScreen());
                    },
                    child: const Icon(Icons.phone, size: 22),
                  ),
                ),
                WidgetsSpacer.horizontalSpacer16,
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(0, 44),
                    ),
                    onPressed: () {
                      AppNavigator.pop(context);
                    },
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
            WidgetsSpacer.verticalSpacer16,
          ],
        ),
      ),
    );
  }
}
