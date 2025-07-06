import 'package:flutter/material.dart' hide CarouselController;
import "../../community_exports.dart";

class ProfileIDPage extends StatelessWidget {
  const ProfileIDPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Profile ID", context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Your profile ID is TE4797200',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          WidgetsSpacer.verticalSpacer16,
          const Text(
            'This will be used for further connections in the community',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppColors.defaultColor400),
          ),
          WidgetsSpacer.verticalSpacer48,
          WidgetsSpacer.verticalSpacer16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                AppNavigator.push(context, const UserProfilePage());
              },
              style: mergeWithThemeButtonStyle(
                context,
                ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: FontSize.size16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
