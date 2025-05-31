import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features_exports.dart';

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
              child: Column(
                children: [
                  // Expanded PageView takes the top part
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (currentPageIndex) {
                        context
                            .read<OnboardingPageCubit>()
                            .changePageIndex(currentPageIndex);
                      },
                      children: List.generate(
                          _pages.length, (index) => _page(index, context)),
                    ),
                  ),

                  // 👇 This part is fixed at the bottom
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment:
                              state.currentPage == _pages.length - 1
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (state.currentPage < _pages.length - 1) {
                                  _pageController.animateToPage(
                                    state.currentPage + 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                } else {
                                  AppNavigator.pushReplacement(
                                      context, const SignUpPage());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize:
                                    state.currentPage == _pages.length - 1
                                        ? const Size(200, 75)
                                        : const Size(125, 55),
                              ),
                              child: Text(
                                state.currentPage == _pages.length - 1
                                    ? 'Get Started'
                                    : 'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      state.currentPage == _pages.length - 1
                                          ? FontSize.size24
                                          : FontSize.size16,
                                ),
                              ),
                            ),
                            if (state.currentPage < _pages.length - 1)
                              WidgetsSpacer.horizontalSpacer20,
                            if (state.currentPage < _pages.length - 1)
                              OutlinedButton(
                                onPressed: () {
                                  AppNavigator.pushReplacement(
                                      context, const SignUpPage());
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: AppColors.primaryColor,
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize: const Size(125, 55),
                                ),
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: FontSize.size16,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        WidgetsSpacer.verticalSpacer16,
                        if (state.currentPage == _pages.length - 1)
                          Center(
                            child: Text.rich(
                              TextSpan(children: [
                                const TextSpan(text: 'You have an account? '),
                                TextSpan(
                                  text: "Login",
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      AppNavigator.push(
                                          context, const LoginPage());
                                    },
                                ),
                              ]),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
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
          ],
        ),
      ),
    );
  }
}
