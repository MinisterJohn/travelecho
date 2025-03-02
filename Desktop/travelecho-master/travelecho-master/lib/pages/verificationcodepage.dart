import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:travelecho/reuseable_widgets/heading.dart';

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
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        HeadingText(text: "Input Code",),
        SizedBox(
          height: 10.0,
        ),
        _subHeadingText(),
        SizedBox(
          height: 40.0,
        ),
        _pinInputForm(),
        SizedBox(
          height: 60.0,
        ),
        _resendCodeLink(),
      ]),
    )));
  }

  Widget _headingText() {
    return Text("Input Code",
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Color(0xff930BFF),
        ));
  }

  Widget _subHeadingText() {
    return Text("Input 6 digit code sent to your email",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black54,
        ));
  }

  Widget _resendCodeLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Didn't get the code? \n Reset code",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
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
                Navigator.pushNamed(context, '/resetpassword');
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
              textStyle: TextStyle(color: Color(0xff930BFF), fontSize: 24),
            ),
            errorPinTheme: PinTheme(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black12,
                border:
                    Border.all(color: Colors.red.shade300), // Example border
              ),
              textStyle: TextStyle(color: Color(0xff930BFF), fontSize: 24),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          ElevatedButton(
            onPressed: () {
              formKey.currentState!.validate();
              // Handle Login Logic
              // _login();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff930BFF),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text(
              'Validate',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ]));
  }
}
