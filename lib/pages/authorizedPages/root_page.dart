import 'package:flutter/material.dart';
import 'package:travelecho/pages/authorizedPages/homescreen.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(),
        bottomNavigationBar: NavigationBar(
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.home_outlined), label: "Explore"),
        NavigationDestination(icon: Icon(Icons.flight_outlined), label: "Trip"),
        NavigationDestination(
            icon: Icon(Icons.savings_outlined), label: "Budget"),
        NavigationDestination(
            icon: Icon(Icons.photo_album_outlined), label: "Memories"),
        NavigationDestination(
            icon: Icon(Icons.people_alt_outlined), label: "Community"),
        NavigationDestination(
            icon: Icon(Icons.supervised_user_circle_outlined),
            label: "Profile"),
      ],
      onDestinationSelected: (int index) {
        setState(() {
          currentPage = index;
        });
      },
      selectedIndex: currentPage,
    ));
  }
}
