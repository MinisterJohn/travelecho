import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/features/currency_converter/presentation/currencyconverter.dart';
import 'package:travelecho/features/travel_guide/presentation/pages/travelguide.dart';
import 'visaandimmigration.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {
  final int _selectedIndex = 0; // Track the selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              // Feature Cards Row
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
                      AppNavigator.push(
                          context, const VisaImmigrationApp());
                    },
                    child: _featureCard(
                      LineIcons.passport, // Visa & Immigration icon
                      "Visa & Immigration",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppNavigator.push(
                          context, const TravelGuidePage());
                    },
                    child: _featureCard(
                      LineIcons.globe,
                      "Travel Guide",
                    ),
                  ),
                ],
              ),
              WidgetsSpacer.verticalSpacer16,
              // First Carousel
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
              // Second Carousel
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
