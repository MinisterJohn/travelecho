import 'package:flutter/material.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/appbar.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/features/community/presentation/widgets/post.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  bool showComments = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("", context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 40,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                          'assets/images/community/profile_pic2.jpeg'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.settings, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 20),
              const Post(),
              WidgetsSpacer.verticalSpacer48,
              const Post()
            ],
          ),
        ),
      ),
    );
  }
}
