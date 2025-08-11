import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth_exports.dart';

void handleLogin({
  required BuildContext context,
  required String email,
  required String password,
}) {
  if (email.isEmpty || password.isEmpty) {
    DisplayMessage.errorMessage("Please enter all fields", context);
  } else {
    context.read<AuthBloc>().add(LoginEvent(email: email, password: password));
  }
}
