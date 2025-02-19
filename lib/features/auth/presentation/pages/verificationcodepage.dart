import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/features/auth/presentation/pages/resetpassword.dart';
import 'package:travelecho/features/auth/presentation/widgets/heading.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String validPin = "123456";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: SizedBox.expand(
            child: Padding(
      padding: WidgetsSpacer.pagePadding,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const HeadingText(
          text: "Input Code",
        ),
        WidgetsSpacer.verticalSpacer16,
        _subHeadingText(),
        WidgetsSpacer.verticalSpacer48,
        _pinInputForm(),
        WidgetsSpacer.verticalSpacer16,
        _resendCodeLink(),
      ]),
    )));
  }

  Widget _headingText() {
    return const Text("Input Code",
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ));
  }

  Widget _subHeadingText() {
    return const Text("Input 6 digit code sent to your email",
        style: TextStyle(
          fontSize: 16.0,
          color: AppColors.defaultColor,
        ));
  }

  Widget _resendCodeLink() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Didn't get the code? \n Reset code",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: AppColors.defaultColor,
            )),
      ],
    );
  }

  Widget _pinInputForm() {
    return Form(
        key: formKey,
        child: Column(children: [
          Pinput(
            length: 6,
            validator: (value) {
              return value == validPin
                  ? null
                  : value == null || value.isEmpty
                      ? "Enter Code"
                      : "Incorrect code. Crosscheck and input again";
            },
            onCompleted: (pin) {
              // Handle completion, like verifying the PIN
              print("Pin entered: $pin");
              if (pin == validPin) {
                AppNavigator.pushAndRemove(context, const ResetPasswordPage());
              }
            },
            autofocus: true,
            defaultPinTheme: PinTheme(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black12,
              ),
              textStyle:
                  const TextStyle(color: AppColors.defaultColor, fontSize: 24),
            ),
            errorPinTheme: PinTheme(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.defaultColor400,
                border:
                    Border.all(color: AppColors.errorColor), // Example border
              ),
              textStyle:
                  const TextStyle(color: AppColors.defaultColor, fontSize: 24),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          ElevatedButton(
            onPressed: () {
              formKey.currentState!.validate();
              // Handle Login Logic
              // _login();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              'Validate',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ]));
  }
}
