import 'package:flutter/material.dart' hide CarouselController;
import '../../profile_exports.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  // List of 22 FAQ items (without numbering) covering Free and Premium features and extra topics

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Help & FAQ", context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Introductory Text
            // const Text(
            //   "Welcome to the Travel Echo Help Center. Here you'll find answers to common questions about our app features.",
            //   style: TextStyle(fontSize: 16),
            //   textAlign: TextAlign.center,
            // ),
            // const SizedBox(height: 24),

            // List of FAQ items with beautified cards
            ...faqItems.map((faq) {
              return Column(
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 0,

                    child: ExpansionTile(
                      shape: Border.all(color: Colors.transparent),
                      leading: Icon(faq.icon, color: AppColors.primaryColor),
                      title: Text(
                        faq.question,
                        style: const TextStyle(fontSize: 18),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            faq.answer,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.defaultColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
            WidgetsSpacer.verticalSpacer8,
            Divider(height: 1, color: AppColors.defaultColor400),
          ],
        ),
      ),
    );
  }
}
