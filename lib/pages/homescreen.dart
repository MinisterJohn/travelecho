import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/features/currency_converter/presentation/currencyconverter.dart';
import 'package:travelecho/features/milestones/presentation/pages/budgetboss.dart';
import 'package:travelecho/features/milestones/presentation/pages/milestones.dart';
import 'package:travelecho/features/travel_guide/presentation/pages/travelguide.dart';
// import 'package:travelecho/pages/authorizedPages/budgetboss.dart';

class HomeScreen2 extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {
  int _selectedIndex = 0; // Track the selected index
  bool _showMilestoneDialog =
      true; // Control the visibility of the milestone dialog

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Field
                  GestureDetector(
                    onTap: () {
                      print("Search clicked");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(5, 145, 11, 255),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(LineIcons.horizontalSliders),
                        ],
                      ),
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer16,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AppNavigator.push(
                              context, const CurrencyConverterPage());
                        },
                        child: _featureCard(
                          Icons.currency_exchange_outlined,
                          "Currency Converter",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          AppNavigator.push(context, MilestonesPage());
                        },
                        child: _featureCard(
                          LineIcons.trophy,
                          "Milestones",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          AppNavigator.push(context, TravelGuidePage());
                        },
                        child: _featureCard(
                          LineIcons.globe,
                          "Travel Guide",
                        ),
                      ),
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
                          "assets/images/home/france.jpg", "Explore France"),
                      _carouselItem("assets/images/home/beinjing.jpeg",
                          "The beauties of Beijing"),
                      _carouselItem("assets/images/home/uk.jpeg",
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
                          "assets/images/home/nextcarousel.jpg",
                          "Based on Your Latest Journey"),
                      _carouselItemWithTextInsideImage(
                          "assets/images/home/nextcarousel2.jpg",
                          "Based on Your Latest Journey"),
                      _carouselItemWithTextInsideImage(
                          "assets/images/home/nextcarousel3.jpg",
                          "Based on Your Latest Journey"),
                    ],
                  ),
                  WidgetsSpacer.verticalSpacer16,
                ],
              ),
            ),
          ),
          WidgetsSpacer.verticalSpacer32,
          if (_showMilestoneDialog)
            Center(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Stack(
                  children: [
                    // Container for the dialog content
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor, // Purple background
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      width: 300, // Adjustable width
                      height: 150, // Adjustable height
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "New Milestone Unlocked\nMaster Planner",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Padding(
                            padding: const EdgeInsets.only(
                                top:
                                    20.0), // Adjust the top padding to move the button down
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to BudgetBossPage
                                AppNavigator.push(
                                    context, BudgetBossPage());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                minimumSize: const Size(double.infinity,
                                    30), // Adjusted width and height
                              ),
                              child: const Text(
                                "See more",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 41, 40, 41),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Positioned cancel icon on the purple background
                    Positioned(
                      top: 8.0,
                      right: 8.0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showMilestoneDialog = false;
                          });
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _featureCard(IconData icon, String label) {
    return Column(
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
    );
  }

  Widget _carouselItem(String imagePath, String cityName) {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              color: AppColors.defaultColor400,
              child: Text(
                cityName,
                style: const TextStyle(
                  color: AppColors.white,
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
                  backgroundColor: AppColors.defaultColor400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
