import 'package:flutter/material.dart';

class UrbanExplorerPage extends StatelessWidget {
  const UrbanExplorerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: const Text(""),
        elevation: 0, // Remove AppBar shadow for a cleaner look
        backgroundColor: Colors.transparent, // Make AppBar background transparent
      ),
      body: SingleChildScrollView( // Enable scrolling
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Milestones header
            const Text(
              "Milestones",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Depth3 image with sharearrow beside it
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min, // Ensures the row takes only as much space as needed
              children: [
                Image.asset(
                  'assets/Depth3.png', // Replace with your image path
                  width: 200,
                  height: 200,
                ),
                
              ],
            ),
          ),
            const SizedBox(height: 20),

            // Congratulations section
            const Text(
              "Congratulations on earning the Urban Explorer badge!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),

            // Milestone achieved
            const Text(
              "Milestone Achieved:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Complete 5 trips to urban cities and unlock exclusive rewards!",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Badge Details
            const Text(
              "Badge Details:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Name: Urban Explorer",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Type: Travel Milestone",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Description: Awarded to travelers who explore multiple urban cities.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Requirements
            const Text(
              "Requirements:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "1. Complete 5 trips to urban cities.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "2. Visit 2 unique cities.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "3. Share 2 travel stories.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Badge Levels
            const Text(
              "Badge Levels:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "1. Bronze: 5 urban cities.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "2. Silver: 10 urban cities.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "3. Gold: 20 urban cities.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "4. Platinum: 50 urban cities.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
