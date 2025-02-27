import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/core/hoc/containerWidget.dart';
import 'package:travelecho/features/auth/presentation/pages/login.dart';
import 'package:travelecho/features/auth/presentation/pages/signup.dart';
import 'package:travelecho/features/onboarding/presentation/blocs/onboardingpage_cubit.dart';
import 'package:travelecho/features/onboarding/presentation/blocs/onboardingpage_state.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> _pages = [
    {
      "image": "assets/images/onboarding/welcome_pic1.png",
      "text": "Travel Smart!\nStay Informed \nTravel without worries"
    },
    {
      "image": "assets/images/onboarding/welcome_pic2.png",
      "text":
          "Book flights and hotels effortlessly and track your journey in real time"
    },
    {
      "image": "assets/images/onboarding/welcome_pic3.png",
      "text":
          "Access immigration info, airport schedules and more at your finger tips."
    },
    {
      "image": "assets/images/onboarding/welcome_pic4.png",
      "text": "Your all in one travel buddy"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingPageCubit(),
      child: Scaffold(
        body: BlocBuilder<OnboardingPageCubit, OnboardingPageState>(
          builder: (context, state) {
            return ScreenContainer(
                child: Stack(children: [
              PageView(
                  controller: _pageController,
                  onPageChanged: (currentPageIndex) {
                    // print(current_page_index);
                    context
                        .read<OnboardingPageCubit>()
                        .changePageIndex(currentPageIndex);
                    // state.currentPage,
                  },
                  children: [
                    _page(0, context),
                    _page(1, context),
                    _page(2, context),
                    _page(3, context),
                  ])
            ]));
          },
        ),
      ),
    );
  }

  Widget _page(int pageIndex, BuildContext context) {
    return ScreenContainer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Flexible container for image and page indicator
            Container(
              margin: EdgeInsets.only(top: 30.h),
              child: Center(
                child: SizedBox(
                  width: 365.w,
                  height: 365.h,
                  child: Image.asset(_pages[pageIndex]["image"]!),
                ),
              ),
            ),
            WidgetsSpacer.verticalSpacer32,

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  padding: EdgeInsets.symmetric(
                      horizontal: pageIndex == index ? 20.0 : 0.0),
                  width: pageIndex == index ? 20.0 : 10.0,
                  height: pageIndex == index ? 10.0 : 10.0,
                  decoration: BoxDecoration(
                      color: pageIndex == index
                          ? AppColors.primaryColor
                          : AppColors.secondaryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            WidgetsSpacer.verticalSpacer32,
            Text(
              _pages[pageIndex]["text"]!,
              style: TextStyle(fontSize: FontSize.size28),
              textAlign: pageIndex == _pages.length - 1
                  ? TextAlign.center
                  : TextAlign.left,
            ),
            WidgetsSpacer.verticalSpacer32,
            // Buttons (next and previous)
            Row(
              mainAxisAlignment: pageIndex == _pages.length - 1
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start, // Center buttons
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (pageIndex < _pages.length - 1) {
                        _pageController.animateToPage(pageIndex + 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.ease);
                      } else {
                        AppNavigator.pushReplacement(
                            context, const SignUpPage());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: pageIndex == _pages.length - 1
                          ? Size(200.w, 75.h)
                          : Size(55.w, 55.h),
                    ),
                    child: Text(
                      pageIndex == _pages.length - 1 ? 'Get Started' : 'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: pageIndex == _pages.length - 1
                              ? FontSize.size24
                              : FontSize.size16),
                    )),
                WidgetsSpacer.horinzontalSpacer20,
                if (pageIndex < _pages.length - 1)
                  OutlinedButton(
                    onPressed: () {
                      // Navigate to signup page
                      AppNavigator.pushReplacement(context, const SignUpPage());
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.primaryColor, // Border color
                        width: 1, // Border width
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Apply border radius
                      ),
                      minimumSize: Size(55.w, 55.h), // Button size
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: AppColors
                            .primaryColor, // Text color to match the border color
                        fontSize: FontSize.size16,
                      ),
                    ),
                  ),
              ],
            ),
            WidgetsSpacer.verticalSpacer16,

            // Add some space at the bottom
            if (pageIndex == _pages.length - 1)
              Center(
                  child: Text.rich(TextSpan(children: [
                const TextSpan(text: 'You have an account? '),
                TextSpan(
                    text: "Login",
                    style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        AppNavigator.push(context, const LoginPage());
                      })
              ]))),
          ],
        ),
      ),
    );
  }
}
