import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class DriverAgreementScreen extends StatefulWidget {
  const DriverAgreementScreen({super.key});

  @override
  State<DriverAgreementScreen> createState() => _DriverAgreementScreenState();
}

class _DriverAgreementScreenState extends State<DriverAgreementScreen> {
  bool _accepted = false;

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
            FormProgressBar(
              progress: 0.9, // Example: 90% filled
              color: AppColors.primaryColor,
            ),
            WidgetsSpacer.verticalSpacer20,
            const Text(
              "License and Agreement",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.defaultColor,
              ),
            ),
            WidgetsSpacer.verticalSpacer20,
            const Text(
              "By proceeding, you agree to abide by all local and international driving laws, maintain your vehicle in safe condition, and provide courteous service to all passengers. Please read the full agreement before confirming.",
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
            WidgetsSpacer.verticalSpacer20,
            Row(
              children: [
                Checkbox(
                  value: _accepted,
                  activeColor: AppColors.primaryColor,
                  onChanged: (val) {
                    setState(() {
                      _accepted = val ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    "I accept the license and agreement terms.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            WidgetsSpacer.spacer,
            AppPrimaryButton(
              onPressed:
                  _accepted
                      ? () {
                        // Handle the confirmation action
                        AppNavigator.push(
                          context,
                          const DriverDashboardScreen(),
                        );
                      }
                      : null,
              child: const Text(
                "Confirm",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              // Disable the button if not accepted
            ),
          ],
        ),
      ),
    );
  }
}
