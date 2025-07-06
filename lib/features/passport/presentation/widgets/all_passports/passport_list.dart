import 'package:flutter/material.dart';
import '../../../passport_exports.dart';

class TravelDocumentList extends StatelessWidget {
  final List<TravelDocumentModel> passports;
  final bool isExpired;

  const TravelDocumentList({
    super.key,
    required this.passports,
    this.isExpired = false,
  });

  @override
  Widget build(BuildContext context) {
    if (passports.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: NoTravelDocumentsPlaceholder(
          title:
              isExpired ? 'Expired Travel Documents' : 'Active Travel Documents',
          subtitle:
              isExpired
                  ? 'Your expired travel documents will appear here.'
                  : 'Your active travel documents will appear here.',
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isExpired ? "Expired TravelDocuments" : "Active TravelDocuments",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          WidgetsSpacer.verticalSpacer16,
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children:
                passports
                    .map(
                      (passport) => Column(
                        children: [
                          TravelDocumentCard(
                            passport: passport,
                            isExpired: isExpired,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Divider(
                              height: 1,
                              color: AppColors.defaultColor100,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
