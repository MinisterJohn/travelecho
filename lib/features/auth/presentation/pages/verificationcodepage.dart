import 'package:flutter/material.dart' hide CarouselController;
import 'package:pinput/pinput.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth_exports.dart';

class OtpForm extends StatefulWidget {
  final String email;
  final bool isSignup;
  final bool isPasswordReset;

  const OtpForm({
    super.key,
    required this.email,
    this.isSignup = false,
    this.isPasswordReset = false,
  });

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final TextEditingController _otpController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isResending = false;
  bool _isVerifying = false;
  int _resendCount = 0;
  static const int maxResendAttempts = 3;

  @override
  void initState() {
    super.initState();
    if (widget.isPasswordReset) {
      _sendOtp();
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!mounted || _isResending || _resendCount >= maxResendAttempts) return;

    setState(() => _isResending = true);
    try {
      final result = await sl<SendOtpUseCase>().call(params: widget.email);
      if (!mounted) return;

      result.fold(
        (error) {
          DisplayMessage.errorMessage(error, context);
        },
        (success) {
          setState(() => _resendCount++);
          DisplayMessage.successMessage("OTP sent successfully", context);
        },
      );
    } catch (e) {
      if (!mounted) return;
      DisplayMessage.errorMessage(e.toString(), context);
    } finally {
      if (mounted) {
        setState(() => _isResending = false);
      }
    }
  }

  void _verifyOtp() {
    if (_isVerifying || !formKey.currentState!.validate()) return;

    setState(() => _isVerifying = true);
    context.read<AuthBloc>().add(
          VerifyOtpEvent(
            email: widget.email,
            otp: _otpController.text,
          ),
        );
  }

  void _handleVerificationSuccess() {
    setState(() => _isVerifying = false);

    // Show success message
    DisplayMessage.successMessage(
      widget.isSignup
          ? "Account verified successfully!"
          : "OTP verified successfully!",
      context,
    );

    // Add a small delay to show the success message
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;

      if (widget.isSignup) {
        // For signup, navigate to welcome page
        AppNavigator.pushAndRemove(context,  const NewUserWelcomePage());
      } else if (widget.isPasswordReset) {
        // For password reset, navigate to reset password page
        AppNavigator.push(context, ResetPasswordPage(email: widget.email));
      } else {
        // For other verification flows, just pop back
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("", context),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _handleVerificationSuccess();
          } else if (state is AuthFailure) {
            setState(() => _isVerifying = false);
            DisplayMessage.errorMessage(state.error, context);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SizedBox.expand(
              child: Padding(
                padding: WidgetsSpacer.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingText(text: "Email Verification"),
                    WidgetsSpacer.verticalSpacer16,
                    _subHeadingText(),
                    WidgetsSpacer.verticalSpacer48,
                    _pinInputForm(),
                    WidgetsSpacer.verticalSpacer16,
                    _resendCodeLink(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _subHeadingText() {
    return Text(
      "Input 6 digit code sent to ${widget.email}",
      style: const TextStyle(
        fontSize: 16.0,
        color: AppColors.defaultColor,
      ),
    );
  }

  Widget _resendCodeLink() {
    final canResend = !_isResending && _resendCount < maxResendAttempts;
    final remainingAttempts = maxResendAttempts - _resendCount;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: canResend ? _sendOtp : null,
              child: Text(
                _isResending
                    ? "Sending..."
                    : canResend
                        ? "Didn't get the code? Resend"
                        : "Maximum resend attempts reached",
                style: TextStyle(
                  fontSize: 16.0,
                  color: canResend
                      ? AppColors.primaryColor
                      : AppColors.defaultColor400,
                ),
              ),
            ),
          ],
        ),
        if (!canResend && remainingAttempts > 0)
          Text(
            "You have $remainingAttempts attempts remaining",
            style: const TextStyle(
              fontSize: 12.0,
              color: AppColors.defaultColor400,
            ),
          ),
      ],
    );
  }

  Widget _pinInputForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Pinput(
            controller: _otpController,
            length: 6,
            enabled: !_isVerifying,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Code";
              }
              if (value.length != 6) {
                return "Code must be 6 digits";
              }
              return null;
            },
            onCompleted: (pin) => _verifyOtp(),
            autofocus: true,
            defaultPinTheme: PinTheme(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black12,
              ),
              textStyle: const TextStyle(
                color: AppColors.defaultColor,
                fontSize: 24,
              ),
            ),
            errorPinTheme: PinTheme(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.defaultColor400,
                border: Border.all(color: AppColors.errorColor),
              ),
              textStyle: const TextStyle(
                color: AppColors.defaultColor,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            onPressed: _isVerifying ? null : _verifyOtp,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: _isVerifying
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Verify',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
          ),
        ],
      ),
    );
  }
}
