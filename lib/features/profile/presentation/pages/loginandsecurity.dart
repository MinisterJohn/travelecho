import 'package:flutter/material.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/features/auth/presentation/pages/forgotpassword.dart';
import 'package:travelecho/features/profile/presentation/pages/changepassword.dart';
import 'package:travelecho/features/profile/presentation/pages/passsavepref.dart';

class LoginAndSecurityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Login and Security'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Password Section
          Text(
            'Password',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          ListTile(
            title: Text('Change Password'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to the InterestSelectionPage when tapped
              AppNavigator.push(context, ChangePasswordPage());
            },
          ),
          Divider(),
          ListTile(
            title: Text('Forgot Password'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Add navigation logic here later
              AppNavigator.push(context, ForgotPasswordPage());
            },
          ),
          Divider(),
          ListTile(
            title: Text('Password Saving Preference'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Add navigation logic here
             AppNavigator.push(context, PasswordSavingPreferencePage());
            },
          ),
          SizedBox(height: 24),

          // Biometrics Section
          Text(
            'Biometrics',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          ListTile(
            title: Text('Login with Fingerprint'),
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
