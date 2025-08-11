import 'package:flutter/material.dart';

class LoginEmailField extends StatelessWidget {
  final TextEditingController controller;
  const LoginEmailField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Email Address',
        prefixIcon: Icon(Icons.email_outlined),
        prefixIconColor: Color(0xff930BFF),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
