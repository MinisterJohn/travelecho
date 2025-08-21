import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../../auth_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget signInText(BuildContext context) {
  return Center(
    child: Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: 'Already have an account? '),
          TextSpan(
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.pushAndRemove(
                      context,
                      BlocProvider.value(
                        value: sl<AuthBloc>(),
                        child: const LoginPage(),
                      ),
                    );
                  },
            text: 'Login',
          ),
        ],
      ),
    ),
  );
}
