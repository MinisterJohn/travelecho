import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth_exports.dart';

void handleSignup({
  required BuildContext context,
  required String email,
  required String password,
  required String name,
}) {
  context.read<AuthBloc>().add(
    SignupEvent(email: email, password: password, name: name),
  );
}
