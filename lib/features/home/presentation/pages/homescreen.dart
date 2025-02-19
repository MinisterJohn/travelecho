import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/hoc/containerWidget.dart';
import 'package:travelecho/features/currency_converter/presentation/currencyconverter.dart';
import 'package:travelecho/features/milestones/presentation/pages/milestones.dart';
import 'package:travelecho/features/travel_guide/presentation/pages/travelguide.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track the selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ScreenContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Field
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(5, 145, 11, 255),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: const Row(
                    children: [
                      Icon(Icons.search,
                          color: Color.fromARGB(100, 30, 30, 30)),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Where to?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            "Search for Flights and Hotels",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      Spacer(), // Pushes the next icon to the far right
                      Icon(LineIcons.horizontalSliders), // Tune icon
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Currency Converter, Milestones, Travel Guide
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _featureCard(
                      Icons.currency_exchange_outlined,
                      "Currency Converter",
                      context,
                      const CurrencyConverterPage()),
                  _featureCard(LineIcons.trophy, "Milestones", context,
                      MilestonesPage()),
                  _featureCard(LineIcons.globe, "Travel Guide", context,
                      TravelGuidePage()),
                ],
              ),
              WidgetsSpacer.verticalSpacer16,

              CarouselSlider(
                options: CarouselOptions(
                  height: 220,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 1.0,
                ),
                items: [
                  _carouselItem(
                      "assets/images/home_images/france.jpg", "Explore France"),
                  _carouselItem("assets/images/home_images/beinjing.jpeg",
                      "The beauties of Beijing"),
                  _carouselItem("assets/images/home_images/uk.jpeg",
                      "Your next travel should be the UK"),
                ],
              ),

              WidgetsSpacer.verticalSpacer16,

              CarouselSlider(
                options: CarouselOptions(
                  height: 220,
                  autoPlay: false,
                  enlargeCenterPage: false,
                  viewportFraction: 1.0,
                ),
                items: [
                      _carouselItemWithTextInsideImage(
                          "assets/images/home_images/nextcarousel.jpg",
                          "Based on Your Latest Journey"),
                      _carouselItemWithTextInsideImage(
                          "assets/images/home_images/nextcarousel2.jpg",
                          "Based on Your Latest Journey"),
                      _carouselItemWithTextInsideImage(
                          "assets/images/home_images/nextcarousel3.jpg",
                          "Based on Your Latest Journey"),
                    ] ??
                    [],
              ),

              WidgetsSpacer.verticalSpacer16,

              // Bottom Navigation
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureCard(
      IconData icon, String label, BuildContext context, widgetDestination) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        debugPrint("hello");
        AppNavigator.push(context, widgetDestination);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white.withOpacity(0.1),
            child: Icon(icon, color: AppColors.primaryColor, size: 40),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _carouselItem(String imagePath, String cityName) {
    return SizedBox(
      height: 180, // Fixed height for the entire carousel item
      child: Stack(
        children: [
          // Image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover, // Ensure the image covers the container
                ),
              ),
            ),
          ),
          // Text overlay at the bottom
          Positioned(
            bottom: 8.0, // Position text slightly above the bottom
            left: 8.0, // Align text to the left
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              color: Colors.black
                  .withOpacity(0.5), // Semi-transparent background for text
              child: Text(
                cityName,
                style: const TextStyle(
                  color: Colors.white, // White text for visibility
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _carouselItemWithTextInsideImage(String imagePath, String cityName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cityName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
