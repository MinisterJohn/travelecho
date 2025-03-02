import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/core/hoc/containerWidget.dart';
import 'package:travelecho/navigation_menu/presentation/root_page.dart';

class NewUserWelcomePage extends StatelessWidget {
  const NewUserWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenContainer(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                WidgetsSpacer.verticalSpacer16,
                WidgetsSpacer.verticalSpacer48,
                Text(
                  "Welcome",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: FontSize.size32,
                      fontWeight: FontWeight.bold),
                ),
                WidgetsSpacer.verticalSpacer32,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Your Account has been Created",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.size16,
                        ),
                        textAlign: TextAlign.center),
                    WidgetsSpacer.verticalSpacer8,
                    Text("Experience a flawless, stress free journey",
                        style: TextStyle(fontSize: FontSize.size16),
                        textAlign: TextAlign.center)
                  ],
                ),
                WidgetsSpacer.verticalSpacer32,
                Image.asset("assets/images/auth/welcome_gif.gif", scale: 1.5),
                WidgetsSpacer.verticalSpacer16,
                WidgetsSpacer.verticalSpacer48,
                ElevatedButton(
                  onPressed: () {
                    AppNavigator.pushAndRemove(context, const RootPage());
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50)),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                        color: AppColors.white, fontSize: FontSize.size16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
