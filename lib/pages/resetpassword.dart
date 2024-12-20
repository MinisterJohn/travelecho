import 'package:flutter/material.dart';
import 'package:travelecho/reuseable_widgets/heading.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isPasswordVisible = false; // Track password visibility
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingText(text: "Reset Password"),
              SizedBox(height: 20.0),
              _newPasswordForm(),
              SizedBox(height: 20.0),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                    // Navigate to Sign-Up Page
                  },
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(color: Color(0xff930BFF)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _newPasswordForm() {
    return Form(
      key: passwordFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _newPasswordController,
            obscureText: !_isPasswordVisible, // Toggle password visibility
            decoration: InputDecoration(
              labelText: 'New Password',
              helperText: "Password must be at least 8 characters",
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible =
                        !_isPasswordVisible; // Toggle visibility
                  });
                },
              ),
            ),
            validator: (newPassword) {
              if (newPassword == null || newPassword.isEmpty) {
                return "Enter new password";
              } else if (newPassword.length < 8) {
                return "Password is less than 8 characters";
              }
              return null; // Return null when password is valid
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _confirmNewPasswordController,
            obscureText: true, // Toggle password visibility
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              border: const OutlineInputBorder(),
            ),
            validator: (cNewPassword) {
              // Check if new password is already validated first
              if (_newPasswordController.text.length >=
                  8) 
                if (cNewPassword == null || cNewPassword.isEmpty) {
                  return "Re-enter new password";
                }
                else if (cNewPassword != _newPasswordController.text) {
                  return "Password Mismatch";
                }
              return null; // Return null if password matches
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (passwordFormKey.currentState?.validate() ?? false) {
                Navigator.pushNamed(context, '/passwordresetsuccess');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff930BFF),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text(
              'Reset Password',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
