import 'package:flutter/material.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/features/community/presentation/pages/profile_id.dart';

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Community', textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: -0.2,
                child: Image.asset('assets/images/memories/rectangle1.png', width: 100),
              ),
              Positioned(
                left: 30,
                child: Image.asset('assets/images/memories/rectangle2.png', width: 100),
              ),
              Positioned(
                right: 0,
                child: Transform.rotate(
                  angle: 0.1,
                  child: Image.asset('assets/images/memories/rectangle3.png', width: 100),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Meet Travel Buddies',  
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Connect with friends, travel together, share beautiful memories',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 120),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                AppNavigator.push(context, ProfileIDPage());
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(color: AppColors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 