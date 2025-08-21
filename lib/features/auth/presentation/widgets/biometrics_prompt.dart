import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';
import "../../auth_exports.dart";

class BiometricsPrompt extends StatelessWidget {
  final VoidCallback? onEnabled;
  const BiometricsPrompt({super.key, this.onEnabled});

  static Future<void> maybeShow(
    BuildContext context, {
    required String email,
    required String password,
    VoidCallback? onEnabled,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final normalizedEmail = email.trim().toLowerCase();
    final isBiometricsEnabled =
        prefs.getBool('biometrics_enabled_$normalizedEmail') ?? false;
    if (!isBiometricsEnabled) {
      final enable = await showDialog<bool>(
        context: context,
        builder: (context) => BiometricsPrompt(onEnabled: onEnabled),
      );
      if (enable == true) {
        final localAuth = LocalAuthentication();
        final canCheck = await localAuth.canCheckBiometrics;
        if (canCheck) {
          final didAuthenticate = await localAuth.authenticate(
            localizedReason: 'Please authenticate to enable biometrics login',
            options: const AuthenticationOptions(
              biometricOnly: true,
              stickyAuth: true,
            ),
          );
          if (didAuthenticate) {
            final storage = FlutterSecureStorage();
            final normalizedEmail = email.trim().toLowerCase();

            // Save password securely
            await storage.write(
              key: 'biometric_password_$normalizedEmail',
              value: password, // from the login form
            );

            // Also save prefs to know biometrics is enabled
            await prefs.setBool('biometrics_enabled_$normalizedEmail', true);
            await prefs.setString('last_biometric_email', normalizedEmail);
            debugPrint("✅ Biometrics enabled for $normalizedEmail");

            DisplayMessage.successMessage(
              'Biometrics enabled! You can use it to login next time.',
              context,
            );
            if (onEnabled != null) onEnabled();
          } else {
            DisplayMessage.errorMessage(
              'Biometric authentication failed or was cancelled.',
              context,
            );
          }
        } else {
          DisplayMessage.errorMessage(
            'Biometrics not available on this device.',
            context,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.fingerprint,
              size: 48,
              color: AppColors.primaryColor,
            ),
            WidgetsSpacer.verticalSpacer16,
            const Text(
              'Enable Biometrics?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            WidgetsSpacer.verticalSpacer8,
            const Text(
              'Would you like to enable biometrics for easier login next time?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => AppNavigator.pop(context),
                    child: const Text(
                      'No',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
