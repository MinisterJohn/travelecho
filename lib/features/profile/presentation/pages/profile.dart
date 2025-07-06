import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../../profile_exports.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SharedPreferences _prefs = sl<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    final fullname = _prefs.getString('name');
    final email = _prefs.getString('email') ?? "";
    final isVerified = _prefs.getBool('verified') ?? false;

    return Scaffold(
      // appBar: setAppBar("", context),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              context.read<ProfileBloc>().add(ProfileLoadRequested());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: BlocProvider.value(
                value: sl<AuthBloc>(),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                    if (authState is AuthSuccess ||
                        authState is AuthLoginSuccess) {
                      return BlocProvider.value(
                        value: sl<ProfileBloc>()..add(ProfileLoadRequested()),
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, profileState) {
                            return Column(
                              children: [
                                ScreenContainer(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 8.0,
                                        ),
                                        child: Text(
                                          "Profile",
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      WidgetsSpacer.verticalSpacer16,
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey[300],
                                                image:
                                                    profileState
                                                                is ProfileLoaded &&
                                                            profileState
                                                                .profile
                                                                .image
                                                                .isNotEmpty
                                                        ? DecorationImage(
                                                          image: NetworkImage(
                                                            profileState
                                                                .profile
                                                                .image,
                                                          ),
                                                          fit: BoxFit.cover,
                                                          alignment:
                                                              Alignment
                                                                  .topCenter,
                                                        )
                                                        : null,
                                              ),
                                            ),
                                            WidgetsSpacer.horizontalSpacer16,
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    fullname ??
                                                        (profileState
                                                                is ProfileLoaded
                                                            ? profileState
                                                                .profile
                                                                .userId
                                                            : 'User'),
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    email,
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        94,
                                                        97,
                                                        99,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            isVerified
                                                ? const Icon(
                                                  Icons.verified_outlined,
                                                  color: AppColors.primaryColor,
                                                )
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                        ),
                                        child: Text(
                                          "Settings",
                                          style: TextStyle(
                                            fontSize: FontSize.size16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      WidgetsSpacer.verticalSpacer16,
                                      _buildSettingsItem(
                                        icon: LineIcons.userCircle,
                                        title: "Personal Information",
                                        onTap: () {
                                          AppNavigator.push(
                                            context,
                                            MultiBlocProvider(
                                              providers: [
                                                BlocProvider(
                                                  create:
                                                      (context) =>
                                                          sl<DataSearchBloc>(),
                                                ),
                                                BlocProvider.value(
                                                  value: sl<ProfileBloc>(),
                                                ),
                                              ],
                                              child:
                                                  const EditPersonalInformation(),
                                            ),
                                          );
                                        },
                                      ),
                                      _buildDivider(),
                                      _buildSettingsItem(
                                        icon: LineIcons.passport,
                                        title: "Travel Documents",
                                        onTap: () {
                                          AppNavigator.push(
                                            context,
                                            BlocProvider.value(
                                              value: sl<TravelDocumentBloc>(),
                                              child:
                                                  const TravelDocumentDetailsPage(),
                                            ),
                                          );
                                        },
                                      ),
                                      _buildDivider(),
                                      _buildSettingsItem(
                                        icon: LineIcons.cogs,
                                        title: "App and Features",
                                        onTap: () {
                                          AppNavigator.push(
                                            context,
                                            const FeaturesPage(),
                                          );
                                        },
                                      ),
                                      _buildDivider(),
                                      _buildSettingsItem(
                                        icon: LineIcons.trophy,
                                        title: "Milestones & Achievements",
                                        onTap: () {
                                          AppNavigator.push(
                                            context,
                                            const MilestonesPage(),
                                          );
                                        },
                                      ),
                                      _buildDivider(),
                                      _buildSettingsItem(
                                        icon: LineIcons.alternateShield,
                                        title: "Login and Security",
                                        onTap: () {
                                          AppNavigator.push(
                                            context,
                                            const LoginAndSecurityPage(),
                                          );
                                        },
                                      ),
                                      _buildDivider(),
                                      _buildSettingsItem(
                                        icon: LineIcons.questionCircle,
                                        title: "Help",
                                        onTap: () {
                                          AppNavigator.push(
                                            context,
                                            const HelpPage(),
                                          );
                                        },
                                      ),
                                      _buildDivider(),
                                      _buildSettingsItem(
                                        icon: LineIcons.infoCircle,
                                        title: "About",
                                        onTap: () {
                                          AppNavigator.push(
                                            context,
                                            const AboutPage(),
                                          );
                                        },
                                      ),
                                      _buildDivider(),
                                      _buildLogoutButton(),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text("Authentication required."),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, profileState) {
              if (profileState is ProfileLoading) {
                return Positioned(
                  top: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
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
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Loading profile...',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, profileState) {
              if (profileState is ProfileFailure) {
                return Positioned(
                  top: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: Icon(Icons.refresh, color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Refresh to load profile',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: AppColors.defaultColor100);
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
                      child: const Text(
                        "No",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.defaultColor400,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(LogoutEvent());
                        AppNavigator.pushReplacement(
                          context,
                          const LoginPage(),
                        );
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
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
    );
  }
}
