import 'package:flutter/material.dart';

class FAQItem {
  final String question;
  final String answer;
  const FAQItem({required this.question, required this.answer});
}

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  // List of 22 FAQ items (without numbering) covering Free and Premium features and extra topics
  final List<FAQItem> faqItems = const [
    FAQItem(
      question: "What free features does Travel Echo offer?",
      answer:
          "Travel Echo free tier includes Automatic Travel Tracking, a Photo and Memory Journal, Social Media Sharing, a Currency Converter, a basic Language and Culture Guide, Community Building, Milestones recognition, and Flight and hotel reservations.",
    ),
    FAQItem(
      question: "Are free features sufficient for casual travelers?",
      answer:
          "Yes, the free tier provides essential functionalities to cover the basic needs of casual travelers, such as tracking, journaling, social sharing, and cultural information.",
    ),
    FAQItem(
      question: "How does Automatic Travel Tracking work?",
      answer:
          "It tracks your major travel destinations with monthly data or check-ins, ensuring you have a record of your journeys.",
    ),
    FAQItem(
      question: "What is included in the free Photo and Memory Journal?",
      answer:
          "It offers limited storage for your photos and memories along with basic journaling options to document your travel experiences.",
    ),
    FAQItem(
      question: "How do I share my travel updates on social media?",
      answer:
          "The free tier includes a simple sharing feature that lets you post location updates and memories directly to your social media accounts.",
    ),
    FAQItem(
      question: "What currencies are available in the free Currency Converter?",
      answer:
          "The free version supports a simple converter with popular currencies, making it easy for basic travel budgeting.",
    ),
    FAQItem(
      question: "How does the Language and Culture Guide work for free users?",
      answer:
          "It provides basic phrases and cultural information for popular destinations to help you navigate local customs.",
    ),
    FAQItem(
      question: "How can I connect with travel buddies using Travel Echo?",
      answer:
          "The free tier includes community building features that allow you to meet travel buddies via code verifications.",
    ),
    FAQItem(
      question: "What are Milestones recognition and rewards in the free version?",
      answer:
          "Free users receive limited badges and rewards when they reach travel milestones, motivating exploration.",
    ),
    FAQItem(
      question: "How do Flight and Hotel Reservations work for free users?",
      answer:
          "Free users can use the integrated booking system to make reservations, although recommendations are limited.",
    ),
    FAQItem(
      question: "What premium features does Travel Echo offer?",
      answer:
          "Premium features include Real-time Tracking, Expanded Storage, an Advanced Currency Converter, Travel Budget Tracking, comprehensive Visa and Immigration Info, personalized Flight and Hotel Reservations, unlimited Milestones and achievements, tailored Travel Recommendations, an enhanced Language and Culture Guide, and an advanced Photo and Memory Journal.",
    ),
    FAQItem(
      question: "How does Real-time Tracking in premium work?",
      answer:
          "Premium users get detailed route mapping and real-time tracking, offering in-depth insights into their travel paths.",
    ),
    FAQItem(
      question: "What is Expanded Storage in the premium plan?",
      answer:
          "It provides increased storage capacity for photos and memories, along with album organization features.",
    ),
    FAQItem(
      question: "What additional benefits does the Advanced Currency Converter offer?",
      answer:
          "It supports a broader range of currencies and provides live exchange rates to help you manage your travel budget more efficiently.",
    ),
    FAQItem(
      question: "How does Travel Budget Tracking help premium users?",
      answer:
          "It offers both basic and advanced budget planning tools, complete with detailed analytics to keep your travel finances in check.",
    ),
    FAQItem(
      question: "What kind of Visa and Immigration Info is available in premium?",
      answer:
          "Premium users have access to comprehensive visa and immigration tips, detailed document checklists, and even visa concierge services.",
    ),
    FAQItem(
      question: "How do Flight and Hotel Reservations differ in premium?",
      answer:
          "Premium reservations come with personalized support and advanced travel recommendations tailored to your preferences.",
    ),
    FAQItem(
      question: "What are the benefits of Milestones and achievements in premium?",
      answer:
          "Premium users enjoy unlimited rewards, badges, and exclusive member recognition as they reach travel milestones.",
    ),
    FAQItem(
      question: "How do Travel Recommendations work in premium?",
      answer:
          "Premium users receive suggested places to visit, real-time insights, and VIP-only travel tips to enhance their experience.",
    ),
    FAQItem(
      question: "What enhancements are available in the premium Language and Culture Guide?",
      answer:
          "Premium access includes expanded language support, deeper cultural insights, local expert access, and advanced language practice tools.",
    ),
    FAQItem(
      question: "How secure is my personal data on Travel Echo?",
      answer:
          "Travel Echo takes your privacy seriously by implementing industry-standard encryption and secure cloud storage protocols to protect your personal information at all times.",
    ),
    FAQItem(
      question: "What customer support options does Travel Echo provide?",
      answer:
          "Travel Echo offers in-app customer support along with a comprehensive help center to address any issues or queries. Premium users receive prioritized support for a smoother experience.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & FAQ", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.grey[200],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Introductory Text
              const Text(
                "Welcome to the Travel Echo Help Center. Here you'll find answers to common questions about our app features.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // List of FAQ items with beautified cards
              ...faqItems.map((faq) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    leading: const Icon(Icons.help_outline, color: Colors.deepPurple),
                    title: Text(
                      faq.question,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          faq.answer,
                          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
