import 'package:flutter/material.dart';
import 'package:travelecho/core/constants/appbar.dart';

class NoMileStonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Milestones", context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image at the center of the page
            Center(
              child: Image.asset(
                'assets/NoResultFound.png', // Replace with your image path
                width: 200, // Adjust image size as needed
                height: 200,
              ),
            ),
            SizedBox(height: 20),

            // "Nothing to see here!" text in bold
            Text(
              "Nothing to see here!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),

            // Message at the center of the page
            Center(
              child: Text(
                "You do not have any milestones or\n achievements yet",
                textAlign: TextAlign.center, // Ensures the text itself is centered
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
