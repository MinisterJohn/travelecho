import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/features/memories/presentation/pages/creatememory.dart';

class MemoryPage extends StatelessWidget {
  final List<String> images = [
    'assets/images/memories/image3.png',
    'assets/images/memories/image4.png',
    'assets/images/memories/image2.png',
  ];

  MemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enableInfiniteScroll: false,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
            ),
            items: images.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text(
            'Create your first travel memory',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Curate your favorite travel experiences and save them to serve as memories.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              AppNavigator.push(context, CreateMemoryPage());
          
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
