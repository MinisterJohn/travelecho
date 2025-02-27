import 'package:flutter/material.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/features/auth/presentation/pages/forgotpassword.dart';
import 'package:travelecho/features/profile/presentation/pages/changepassword.dart';
import 'package:travelecho/features/profile/presentation/pages/passsavepref.dart';

class LoginAndSecurityPage extends StatelessWidget {
  const LoginAndSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Login and Security'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Password Section
          const Text(
            'Password',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to the InterestSelectionPage when tapped
              AppNavigator.push(context, const ChangePasswordPage());
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Forgot Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Add navigation logic here later
              AppNavigator.push(context, const ForgotPasswordPage());
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Password Saving Preference'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Add navigation logic here
             AppNavigator.push(context, const PasswordSavingPreferencePage());
            },
          ),
          const SizedBox(height: 24),

          // Biometrics Section
          const Text(
            'Biometrics',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            title: const Text('Login with Fingerprint'),
            trailing: Switch(
              value: true, // Default value
              onChanged: (bool value) {
                // Handle switch state change
              },
            ),
          ),
        ],
      ),
    );
  }
}
