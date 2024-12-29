import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:line_icons/line_icons.dart';



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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Field
              GestureDetector(
                onTap: () {
                  // Add the action to perform when the search field is clicked
                  print("Search clicked");
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(5, 145, 11, 255),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
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
              SizedBox(height: 20),

              // Currency Converter, Milestones, Travel Guide
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _featureCard(
                      Icons.currency_exchange_outlined, "Currency Converter"),
                  _featureCard(LineIcons.trophy, "Milestones"),
                  _featureCard(LineIcons.globe, "Travel Guide"),
                ],
              ),
              SizedBox(height: 20),

              CarouselSlider(
                options: CarouselOptions(
                  height: 220,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 1.0,
                ),
                items: [
                  _carouselItem("assets/images/france.jpg", "Explore France"),
                  _carouselItem(
                      "assets/images/beinjing.jpeg", "The beauties of Beijing"),
                  _carouselItem("assets/images/uk.jpeg",
                      "Your next travel should be the UK"),
                ],
              ),
              SizedBox(height: 20),

              CarouselSlider(
                options: CarouselOptions(
                  height: 220,
                  autoPlay: false,
                  enlargeCenterPage: false,
                  viewportFraction: 1.0,
                ),
                items: [
                  _carouselItemWithTextInsideImage("assets/nextcarousel.jpg",
                      "Based on Your Latest Journey"),
                  _carouselItemWithTextInsideImage("assets/nextcarousel2.jpg",
                      "Based on Your Latest Journey"),
                  _carouselItemWithTextInsideImage("assets/nextcarousel3.jpg",
                      "Based on Your Latest Journey"),
                ],
              ),
              SizedBox(height: 20),

              // Bottom Navigation
            ],
          ),
        ),
      ),
    //   bottomNavigationBar: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          
    //       children: [
    //         _bottomNavItem(Icons.home_outlined, Icons.home, "Explore", 0),
    //         _bottomNavItem(Icons.flight_outlined, Icons.flight, "Trip", 1),
    //         _bottomNavItem(Icons.savings_outlined, Icons.savings, "Budget", 2),
    //         _bottomNavItem(Icons.photo_album_outlined, Icons.photo_album, "Memories", 3),
    //         _bottomNavItem(Icons.people_alt_outlined, Icons.people_alt, "Community", 4),
    //         _bottomNavItem(Icons.supervised_user_circle_outlined, Icons.supervised_user_circle, "Profile", 5),
    //       ],
    //     ),
    //   ),
    // 
    );
  }

  Widget _featureCard(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white.withOpacity(0.1),
          child: Icon(icon, color: Color(0xff930BFF), size: 40),
        ),
        SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _carouselItem(String imagePath, String cityName) {
    return Container(
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
                style: TextStyle(
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

  Widget _bottomNavItem(IconData icon, IconData filled_icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index; // Update the selected index
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isSelected ? filled_icon : icon, color: Colors.black),
          SizedBox(height: 1),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color:  Colors.black,
          // Keep text visible even when icon color changes
            ),
          ),
        ],
      ),
    );
  }
}
