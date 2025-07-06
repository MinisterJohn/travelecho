import 'package:flutter/material.dart';
import '../../../passport_exports.dart';

class TravelDocumentsLoadingOverlay extends StatelessWidget {
  const TravelDocumentsLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 0,
      child: Column(
        children: [
          const SizedBox(height: 8),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Loading passports...',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Skeleton list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 4,
              itemBuilder:
                  (context, index) => const SkeletonTravelDocumentCard(),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class SkeletonTravelDocumentCard extends StatelessWidget {
  const SkeletonTravelDocumentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 110,
      decoration: BoxDecoration(
        // color: AppColors.defaultColor100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        spacing: 8,
        children: [
          Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.defaultColor400,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    height: 16,
                    color: AppColors.defaultColor400,
                  ),
                  Container(
                    width: 80,
                    height: 12,
                    color: AppColors.defaultColor400,
                  ),
                  Container(
                    width: 60,
                    height: 12,
                    color: AppColors.defaultColor400,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
