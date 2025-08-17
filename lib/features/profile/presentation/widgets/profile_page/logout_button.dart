import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../../profile_exports.dart';
import './settings_list_item.dart';

class LogoutButton extends StatelessWidget {
  final String email;

  const LogoutButton({super.key, required this.email});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              AppNavigator.pushReplacement(context, const LoginPage());
            }
          },
          child: AlertDialog(
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
                    onPressed: () => Navigator.pop(context),
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
                      context.read<AuthBloc>().add(LogoutEvent(email: email));
                      Navigator.pop(context); // Close dialog first
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SettingsListItem(
      icon: LineIcons.alternateSignOut,
      title: "Logout",
      onTap: () => _showLogoutDialog(context),
    );
  }
}
