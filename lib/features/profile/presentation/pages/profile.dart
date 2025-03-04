import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/appbar.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/core/hoc/containerWidget.dart';
import 'package:travelecho/features/auth/presentation/pages/login.dart';
import 'package:travelecho/features/milestones/presentation/pages/milestones.dart';
import 'package:travelecho/features/profile/presentation/blocs/data_search_bloc.dart';
import 'package:travelecho/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:travelecho/features/profile/presentation/pages/AboutPage.dart';
import 'package:travelecho/features/profile/presentation/pages/AppFeatures.dart';
import 'package:travelecho/features/profile/presentation/pages/HelpPage.dart';
import 'package:travelecho/features/profile/presentation/pages/loginandsecurity.dart';
import 'package:travelecho/features/profile/presentation/pages/passportpage.dart';
import 'package:travelecho/features/profile/presentation/pages/personalinformation.dart';
import 'package:travelecho/service_locator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setAppBar("", context),
        body: SingleChildScrollView(
            child: BlocProvider(
                create: (context) => sl<ProfileBloc>()..add(ProfileRequested()),
                child: ScreenContainer(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Alex David",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                            MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) => sl<DataSearchBloc>(),
                                ),
                                BlocProvider.value(
                                  value: sl<ProfileBloc>(),
                                ),
                              ],
                              child: const EditProfilePage(),
                            ));
                      },
                    ),
                    _buildDivider(),
                    _buildSettingsItem(
                      icon: LineIcons.passport,
                      title: "Passport Information",
                      onTap: () {
                        AppNavigator.push(context, const PassportDetailsPage());
                      },
                    ),
                    _buildDivider(),
                    _buildSettingsItem(
                      icon: LineIcons.cogs,
                      title: "App and Features",
                      onTap: () {
                        AppNavigator.push(context, const FeaturesPage());
                      },
                    ),
                    _buildDivider(),
                    _buildSettingsItem(
                      icon: LineIcons.trophy,
                      title: "Milestones & Achievements",
                      onTap: () {
                        AppNavigator.push(context, const MilestonesPage());
                      },
                    ),
                    _buildDivider(),
                    _buildSettingsItem(
                      icon: LineIcons.alternateShield,
                      title: "Login and Security",
                      onTap: () {
                        AppNavigator.push(
                            context, const LoginAndSecurityPage());
                      },
                    ),
                    _buildDivider(),
                    _buildSettingsItem(
                      icon: LineIcons.questionCircle,
                      title: "Help",
                      onTap: () {
                        AppNavigator.push(context, const HelpPage());
                      },
                    ),
                    _buildDivider(),
                    _buildSettingsItem(
                      icon: LineIcons.infoCircle,
                      title: "About",
                      onTap: () {
                        AppNavigator.push(context, const AboutPage());
                      },
                    ),
                    _buildDivider(),
                    _buildLogoutButton(),
                  ],
                )))));
  }

  Widget _buildDivider() {
    return Divider(color: AppColors.defaultColor100);
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

  Widget _buildLogoutButton() {
    return _buildSettingsItem(
      icon: LineIcons.alternateSignOut,
      title: "Logout",
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 0,
              backgroundColor: Colors.white,
              title: const Text(
                "Are you sure you want to exit?",
                style: TextStyle(fontSize: 16),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () {
                        AppNavigator.pushReplacement(
                            context, const LoginPage());
                      },
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
