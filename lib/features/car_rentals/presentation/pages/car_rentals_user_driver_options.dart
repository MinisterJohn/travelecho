import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class CarRentalsUserDriverOptions extends StatelessWidget {
  const CarRentalsUserDriverOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Please Select',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              WidgetsSpacer.verticalSpacer48,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // User Button
                  _RoleOptionButton(
                    icon: Icons.person_outline,
                    label: 'User',
                    color: AppColors.primaryColor,
                    onTap: () {
                      // Handle user selection
                      AppNavigator.push(
                        context,
                        const CarRentalFromScreen(),
                      );
                    },
                  ),
                  // Driver Button
                  _RoleOptionButton(
                    icon: Icons.directions_car_filled_outlined,
                    label: 'Driver',
                    color: AppColors.primaryColor,
                    onTap: () {
                      // Handle driver selection
                      AppNavigator.push(
                        context,
                        const BecomeDriverScreen(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleOptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _RoleOptionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: 110,
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.white, size: 36),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
