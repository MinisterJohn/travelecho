import 'package:flutter/material.dart';
import 'package:travelecho/pages/authorizedPages/homescreen.dart';
import 'package:travelecho/pages/authorizedPages/trip/trip_screen.dart';
import 'package:travelecho/pages/authorizedPages/budget/budget.dart';
import 'package:line_icons/line_icons.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  final List<Widget> pages = [
    HomeScreen(),
    TripScreen(), // Replace with your Trip page widget
    BudgetScreen(), // Replace with your Budget page widget
    // MemoriesPage(), // Replace with your Memories page widget
    // CommunityPage(), // Replace with your Community page widget
    // ProfilePage(), // Replace with your Profile page widget
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentPage],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.transparent, // Remove the background
            iconTheme: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return IconThemeData(
                    color: Color(0xff930BFF), size: 30); // Active icon color
              }
              return IconThemeData(
                  color: Colors.black, size: 25); // Inactive icon color
            }),
            labelTextStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return TextStyle(
                    color: Color(0xff930BFF),
                    fontSize: 10); // Active label style
              }
              return TextStyle(
                  color: Colors.black, fontSize: 10); // Inactive label style
            }),
          ),
          child: NavigationBar(
            destinations: const [
              NavigationDestination(
                  icon: Icon(LineIcons.home), label: "Explore"),
              NavigationDestination(
                icon: Icon(LineIcons.plane),
                label: "Trip",
              ),
              NavigationDestination(
                icon: Icon(LineIcons.piggyBank),
                label: "Budget",
              ),
              NavigationDestination(
                  icon: Icon(LineIcons.image), label: "Memories"),
              NavigationDestination(
                  icon: Icon(LineIcons.users), label: "Community"),
              NavigationDestination(
                  icon: Icon(LineIcons.userCircle), label: "Profile"),
            ],
            onDestinationSelected: (int index) {
              setState(() {
                currentPage = index;
              });
            },
            selectedIndex: currentPage,
          ),
        ));
  }
}
