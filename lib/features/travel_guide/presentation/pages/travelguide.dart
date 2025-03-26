import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/appbar.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/hoc/containerWidget.dart';
import 'exploreguide.dart';

class TravelGuidePage extends StatelessWidget {
  const TravelGuidePage({super.key});

  final List<Map<String, dynamic>> guideFeatures = const [
    {
      "icon": Icons.chat_outlined,
      "title": "Local greetings\nand phrases",
    },
    {
      "icon": Icons.lan_outlined,
      "title": "Cultural dos\nand don'ts",
    },
    {
      "icon": Icons.star_outline,
      "title": "Traditional Customs",
    },
    {
      "icon": Icons.menu_book_sharp,
      "title": "Local Behavioral \nTips",
    },
    {
      "icon": LineIcons.utensils,
      "title": "Local Cuisine \n& Drinks",
    },
    {
      "icon": Icons.attractions,
      "title": "Tourist Attraction",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Culture Guide", context),
      body: SingleChildScrollView(
        child: ScreenContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidgetsSpacer.verticalSpacer32,
              // Globe illustration
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.defaultColor100,
                      ),
                    ),
                    const Icon(
                      LineIcons.globe,
                      color: AppColors.primaryColor,
                      size: 150,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Your Culture Guide",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Discover local customs, traditions, and etiquette with your personal guide. Get instant answers about:",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // GridView for guide features
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10,
                ),
                itemCount: guideFeatures.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Icon(
                        guideFeatures[index]["icon"],
                        color: AppColors.primaryColor,
                        size: 30,
                      ),
                      WidgetsSpacer.horinzontalSpacer8,
                      Expanded(
                        child: Text(
                          guideFeatures[index]["title"],
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  );
                },
              ),

              WidgetsSpacer.verticalSpacer32,
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExploreGuide(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Start Exploring",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
