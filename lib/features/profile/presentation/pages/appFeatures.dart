import 'package:flutter/material.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  // List of Free tier features
  final List<String> freeFeatures = const [
    "Automatic Travel Tracking: Basic tracking of locations, limited to major destinations, with monthly data or check-ins.",
    "Photo and Memory Journal: Limited storage for photos and memories, basic journaling options.",
    "Social Media Sharing: Simple sharing option to post location updates on social media.",
    "Currency Converter: Access to a simple converter with popular currencies only.",
    "Language and Culture Guide: Basic phrases and cultural info for popular destinations.",
    "Community Building: Meeting travel buddies with code verifications.",
    "Milestones recognition: With limited badges, rewards.",
    "Flight and hotel reservations: With integrated booking system, limited recommendations."
  ];

  // List of Premium tier features
  final List<String> premiumFeatures = const [
    "Real-time Tracking: Detailed routes and map integration.",
    "Expanded Storage: Increased storage for photos and memories, with album organization.",
    "Advanced Currency Converter: Access to a broader range of currencies and live exchange rates.",
    "Travel Budget Tracking: Basic and advanced budget planning with detailed analytics.",
    "Visa and Immigration Info: Comprehensive visa and immigration tips, document checklists, and visa concierge.",
    "Flight and Hotel Reservation: With personalized support and advanced travel recommendations and adjustments.",
    "Milestones and achievements: With unlimited rewards, badges, and exclusive member recognition.",
    "Travel Recommendations: Suggested places to visit, real-time insights, and VIP-only tips.",
    "Language and Culture Guide: Expanded language support, cultural insights, local expert access, and language practice tools.",
    "Photo and Memory Journal: Unlimited storage, high-resolution media upload, and memory creation."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Features", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.grey[200],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              const Center(
                child: Column(
                  children: [
                    Text(
                      "Discover Travel Echo",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Choose a plan that suits your travel style",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Free Features Section
              const Text(
                "Free Features",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              ...freeFeatures.map(
                (feature) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline, color: Colors.green),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            feature,
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Premium Features Section
              const Text(
                "Premium Features",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              ...premiumFeatures.map(
                (feature) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            feature,
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
