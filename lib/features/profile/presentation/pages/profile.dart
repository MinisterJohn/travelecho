import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/appbar.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/core/hoc/containerWidget.dart';
import 'package:travelecho/features/auth/presentation/pages/login.dart';
import 'package:travelecho/features/profile/presentation/blocs/data_search_bloc.dart';
import 'package:travelecho/features/profile/presentation/pages/loginandsecurity.dart';
import 'package:travelecho/features/profile/presentation/pages/passportpage.dart';
import 'package:travelecho/features/profile/presentation/pages/personalinformation.dart';
import 'package:travelecho/features/profile/presentation/pages/AddCardDetails.dart';
import 'package:travelecho/service_locator.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("", context),
      body: SingleChildScrollView(
        child: ScreenContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Alex David",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Show Profile",
                            style: TextStyle(
                                color: Color.fromARGB(255, 94, 97, 99)),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.black),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: FontSize.size16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildSettingsItem(
                icon: LineIcons.userCircle,
                title: "Personal Information",
                onTap: () {
                  AppNavigator.push(
                      context,
                      BlocProvider(
                        create: (context) => sl<DataSearchBloc>(),
                        child: EditProfilePage(),
                      ));
                },
              ),
              Divider(color: AppColors.defaultColor100),
              _buildSettingsItem(
                icon: LineIcons.alternateShield,
                title: "Login and Security",
                onTap: () {
                  AppNavigator.push(context, LoginAndSecurityPage());
                  // Navigate to Login and Security
                },
              ),
              Divider(color: AppColors.defaultColor100),
              _buildSettingsItem(
                icon: LineIcons.creditCardAlt,
                title: "Cards",
                onTap: () {
                  AppNavigator.push(context, AddCardDetailsPage());
                },
              ),
              Divider(color: AppColors.defaultColor100),
              _buildSettingsItem(
                icon: LineIcons.passport,
                title: "Passport Information",
                onTap: () {
                  AppNavigator.push(context, PassportDetailsPage());
                },
              ),
              Divider(color: AppColors.defaultColor100),
              _buildSettingsItem(
                icon: LineIcons.alternateSignOut,
                title: "Logout",
                onTap: () {
                  // Show the confirmation dialog before proceeding with logout
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        elevation: 0,
                        backgroundColor:
                            Colors.white, // Set white background for the dialog
                        title: const Text(
                          "Are you sure you want to exit?",
                          style: TextStyle(fontSize: 16),
                        ),
                        actions: <Widget>[
                          // Wrap the buttons in a Row to create a gap between them
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // "No" button with increased size
                              SizedBox(
                                width: 104, // Adjust width for button
                                height: 38, // Adjust height for button
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  style: TextButton.styleFrom(
                                    side: const BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 2), // Purple outline
                                  ),
                                  child: const Text(
                                    'No',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              // "Yes" button with increased size
                              SizedBox(
                                width: 104, // Adjust width for button
                                height: 38, // Adjust height for button
                                child: TextButton(
                                  onPressed: () {
                                    AppNavigator.pushReplacement(context,
                                        const LoginPage()); // Navigate to login
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                  ),
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.black),
      onTap: onTap,
    );
  }
}
