import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class SaveBudgetScreen extends StatelessWidget {
  const SaveBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8), // Padding inside the circle
            decoration: const BoxDecoration(
              color: Color.fromRGBO(248, 239, 255, 1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LineIcons.arrowCircleLeft,
              color: Colors.black,
              size: 20, // Adjusted icon size for better fit
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        // foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Icon(
                LineIcons.checkCircle,
                size: 100,
                color: Color(0xFF930BFF),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'You just created your first budget!!!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Enjoy every trip when you set a budget for your trip.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the budget screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF930BFF),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Go back',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
