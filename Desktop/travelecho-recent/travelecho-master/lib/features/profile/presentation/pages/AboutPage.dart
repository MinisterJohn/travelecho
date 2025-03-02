import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  // List of Free Tier features.
  final List<String> freeTierFeatures = const [
    "Automatic Travel Tracking: Track your journeys with ease.",
    "Photo and Memory Journal: Capture and store your travel moments.",
    "Social Media Sharing: Share your adventures with friends.",
    "Currency Converter: Manage your travel expenses.",
    "Language and Culture Guide: Access basic cultural insights.",
    "Community Building: Connect with fellow travelers.",
    "Milestones Recognition: Earn badges as you explore.",
    "Flight and Hotel Reservations: Book your travels with ease."
  ];

  // List of Premium Tier features.
  final List<String> premiumTierFeatures = const [
    "Real-time Tracking: Detailed route information and real-time updates.",
    "Expanded Storage: More space for your photos and memories.",
    "Advanced Currency Converter: Live exchange rates and more currencies.",
    "Travel Budget Tracking: Advanced budgeting and analytics.",
    "Visa and Immigration Info: Comprehensive travel documentation support.",
    "Personalized Flight and Hotel Reservations: Tailored recommendations and support.",
    "Unlimited Milestones & Achievements: Earn rewards without limits.",
    "Travel Recommendations: Exclusive tips and insights.",
    "Enhanced Language and Culture Guide: In-depth cultural guidance and language support.",
    "Advanced Photo and Memory Journal: High-resolution uploads and advanced organization."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Travel Echo"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            elevation: 8,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Travel Echo",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[800],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      "Your ultimate travel companion that keeps track of your journeys and memories.",
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Free Tier",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: freeTierFeatures.map((feature) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle_outline,
                                color: Colors.deepPurple, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                feature,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Premium Tier",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: premiumTierFeatures.map((feature) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.star_border,
                                color: Colors.deepPurple, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                feature,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      "Join us on your next adventure with Travel Echo and experience travel like never before.",
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AboutPage(),
  ));
}
