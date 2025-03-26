import 'package:flutter/material.dart';

class ExploreGuide extends StatefulWidget {
  const ExploreGuide({super.key});

  @override
  _ExploreGuideState createState() => _ExploreGuideState();
}

class _ExploreGuideState extends State<ExploreGuide> {
  String response = ""; // Variable to hold the response text

  void handleUserInput(String input) {
    setState(() {
      if (input.toLowerCase().contains("south africa")) {
        response =
            "South Africa is known for its diverse cultures, stunning landscapes, and rich history. Key attractions include Table Mountain, Kruger National Park, and Robben Island.";
      } else {
        response =
            "Sorry, I currently don't have information on that. Please try another query.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Culture Guide",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(thickness: 1),
            const SizedBox(height: 20),
            const Text(
              "Where are you travelling to?",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Input field with image on the left
            TextField(
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/icons/location.png', // Replace with your image asset path
                    width: 24,
                    height: 24,
                  ),
                ),
                hintText: "Enter the country name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: handleUserInput, // Handle input submission
            ),
            const SizedBox(height: 20),

            // Rectangle box with corner radius
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo and AI guide text
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Space for logo image
                      Image.asset(
                        'assets/images/culture_guide/mdi_globe.png', // Replace with your image asset path
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "Hello! I'm your culture guide. How can I help you understand the local culture better?",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Field for user to ask a question
                  TextField(
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/images/culture_guide/Vector.png', // Replace with your image asset path
                          width: 10,
                          height: 10,
                        ),
                      ),
                      hintText: "Ask a question",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: handleUserInput, // Handle input submission
                  ),
                  const SizedBox(height: 20),
                  // Display response
                  if (response.isNotEmpty)
                    Text(
                      response,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
