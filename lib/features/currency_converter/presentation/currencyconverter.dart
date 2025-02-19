import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/features/currency_converter/presentation/blocs/currency_bloc.dart';
import 'dart:math';
import 'converter.dart';
import 'package:travelecho/core/constants/appbar.dart';

class CurrencyConverterPage extends StatelessWidget {
  const CurrencyConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: appBarIconButton(context)),
      body: const CurrencyConverterBody(),
    );
  }
}

class CurrencyConverterBody extends StatefulWidget {
  const CurrencyConverterBody({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterBodyState createState() => _CurrencyConverterBodyState();
}

class _CurrencyConverterBodyState extends State<CurrencyConverterBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _rotationAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 4.0 * pi)
            .chain(CurveTween(curve: Curves.easeInOut)), // Fast rotation
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ConstantTween(4.0 * pi), // Pause
        weight: 0.5,
      ),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 70),
          Text(
            "Currency Converter",
            style: TextStyle(
              fontSize: FontSize.size24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          WidgetsSpacer.verticalSpacer16,
          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value,
                child: child,
              );
            },
            child: SizedBox(
              height: 320,
              width: double.infinity,
              child: Image.asset(
                'assets/images/currency_converter/animation.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          WidgetsSpacer.verticalSpacer16,
          const Text(
            "Convert Currencies on the go",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          WidgetsSpacer.verticalSpacer32,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                AppNavigator.pushReplacement(
                    context,
                    BlocProvider(
                      create: (context) => CurrencyBloc(),
                      child: ConverterPage(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 0),
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
