import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/appbar.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import '../../../travel_guide/presentation/pages/urbanexplorer.dart';
import 'nomilestones.dart';

class MilestonesPage extends StatelessWidget {
  const MilestonesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Milestones", context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Spacer to move "You've earned 8 badges" downward
            WidgetsSpacer.verticalSpacer32, // Adjust this value as needed

            // "You've earned 8 badges"
            const Text(
              "You've earned 6 badges",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Badges row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _badges(
                      context,
                      'assets/images/milestones/urban-explorer.png',
                      "Urban Explorer"),
                  _badges(
                      context,
                      'assets/images/milestones/culture-legend.png',
                      "Culture Legend"),
                  _badges(
                      context,
                      'assets/images/milestones/nation-navigator.png',
                      "Nation Navigator"),
                  _badges(
                      context,
                      'assets/images/milestones/discovery-mogul.png',
                      "Discovery Mogul"),
                  _badges(
                      context,
                      'assets/images/milestones/special-solo-traveler.png',
                      "Special Solo Traveler"),
                  _badges(context, 'assets/images/milestones/tourist-titan.png',
                      "Tourist Titan"),
                ],
              ),
            ),
            WidgetsSpacer.verticalSpacer16,

            // "Milestones" and "See all"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Milestones",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to milestones page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NoMileStonePage(),
                      ),
                    );
                  },
                  child: const Text(
                    "See all",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // "20,000 steps" and "Next badge: 25k steps"
            const Text(
              "20,000 steps",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Next badge: 25k steps",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),

            // Progress bar
            LinearProgressIndicator(
              value: 0.8, // Example progress value
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            const SizedBox(height: 20),

            // "See more achievements"
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to milestones page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NoMileStonePage(),
                    ),
                  );
                },
                child: const Text(
                  "See more achievements",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badges(
      BuildContext context, String badgeImageUrl, String badgeTitle) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, const UrbanExplorerPage());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            badgeImageUrl, // Replace with your image path
            width: 150.h,
            height: 150.h,
          ),
          WidgetsSpacer.verticalSpacer8,
          Text(
            badgeTitle,
            style: TextStyle(fontSize: FontSize.size14),
          )
        ],
      ),
    );
  }
}
