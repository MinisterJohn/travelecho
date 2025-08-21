import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../features_exports.dart';

class DriverBookingPopup extends StatelessWidget {
  final Map<String, dynamic> booking;
  final VoidCallback onConfirm;
  final VoidCallback onClose;

  const DriverBookingPopup({
    super.key,
    required this.booking,
    required this.onConfirm,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blur background
        GestureDetector(
          onTap: onClose,
          child: Container(
            color: Colors.black.withOpacity(0.3),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: onClose,
                        child: const Icon(Icons.close, color: Colors.black54),
                      ),
                    ],
                  ),
                  WidgetsSpacer.verticalSpacer8,
                  const Text(
                    "Booking Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer16,
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.primaryColor, size: 18),
                      WidgetsSpacer.horizontalSpacer8,
                      Expanded(
                        child: Text(
                          "From\n${booking["from"] ?? ""}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  WidgetsSpacer.verticalSpacer8,
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: AppColors.primaryColor, size: 18),
                      WidgetsSpacer.horizontalSpacer8,
                      Expanded(
                        child: Text(
                          "To\n${booking["to"] ?? ""}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  WidgetsSpacer.verticalSpacer16,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time of ride\n${booking["time"] ?? ""}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        WidgetsSpacer.verticalSpacer8,
                        Text(
                          "Date of ride\n${booking["date"] ?? ""}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        WidgetsSpacer.verticalSpacer8,
                        Text(
                          "${booking["class"] ?? ""}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        WidgetsSpacer.verticalSpacer8,
                        Text(
                          "Price\n${booking["price"] ?? ""}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer16,
                  const Text(
                    "All terms and conditions apply",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 13,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer16,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: onConfirm,
                      child: const Text(
                        "Confirm booking",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}