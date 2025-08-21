import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class DriverVehicleDetailsScreen extends StatefulWidget {
  const DriverVehicleDetailsScreen({super.key});

  @override
  State<DriverVehicleDetailsScreen> createState() => _DriverVehicleDetailsScreenState();
}

class _DriverVehicleDetailsScreenState extends State<DriverVehicleDetailsScreen> {
  final TextEditingController plateController = TextEditingController();
  final TextEditingController makeController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController modelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: setAppBar("Verification", context),
      body: Padding(
        padding: WidgetsSpacer.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetsSpacer.verticalSpacer16,
            // Progress bar at the top
            FormProgressBar(
              progress: 0.4, // Example: 40% filled, pass actual value as needed
              color: AppColors.primaryColor,
            ),
            WidgetsSpacer.verticalSpacer20,
            const Text(
              "Vehicle Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: AppColors.defaultColor,
              ),
            ),
            WidgetsSpacer.verticalSpacer32,
            _buildTextField("Plate number", plateController),
            WidgetsSpacer.verticalSpacer16,
            _buildTextField("Make", makeController),
            WidgetsSpacer.verticalSpacer16,
            _buildTextField("Year", yearController),
            WidgetsSpacer.verticalSpacer16,
            _buildTextField("Model", modelController),
            WidgetsSpacer.spacer,
            AppPrimaryButton(
              child: const Text(
                "Next",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                // Handle next action
                AppNavigator.push(
                  context,
                  const DriverUploadLicenseScreen(),
                );
              },
            ),
            WidgetsSpacer.verticalSpacer16,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.defaultColor100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}