import 'package:flutter/material.dart';
import 'ai_service.dart'; // Import the service you created

class ExploreGuide extends StatefulWidget {
  const ExploreGuide({super.key});

  @override
  _ExploreGuideState createState() => _ExploreGuideState();
}

class _ExploreGuideState extends State<ExploreGuide> {
  String response = "";
  bool isLoading = false;
  final AIService _aiService = AIService();

  void handleUserInput(String input) async {
    setState(() {
      response = "";
      isLoading = true;
    });

    try {
      // Fetch answer from the AI service
      String answer = await _aiService.fetchCultureAnswer(input);
      setState(() {
        response = answer;
      });
    } catch (error) {
      setState(() {
        response = 'Error retrieving answer. Please try again.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.location_on,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                hintText: "Enter the country name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: handleUserInput,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/culture_guide/mdi_globe.png',
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
                  TextField(
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/images/culture_guide/Vector.png',
                          width: 10,
                          height: 10,
                        ),
                      ),
                      hintText: "Ask a question",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: handleUserInput,
                  ),
                  const SizedBox(height: 20),
                  // Show a loading indicator when waiting for a response
                  if (isLoading)
                    const CircularProgressIndicator(),
                  if (response.isNotEmpty && !isLoading)
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
