import 'package:flutter/material.dart';
import '../../../passport_exports.dart';

class NoTravelDocumentsPlaceholder extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;

  const NoTravelDocumentsPlaceholder({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageAsset = 'assets/NoResultFound.png',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        WidgetsSpacer.verticalSpacer48,
        Center(child: Image.asset(imageAsset, height: 100)),
        WidgetsSpacer.verticalSpacer20,
        const Center(
          child: Text(
            'Nothing to see here!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        WidgetsSpacer.verticalSpacer20,
        Center(
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
