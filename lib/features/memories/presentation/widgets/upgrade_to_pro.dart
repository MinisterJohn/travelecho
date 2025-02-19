import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/features/memories/presentation/pages/pricing.dart';

void upgradeToPro(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Align(
            alignment: Alignment.bottomCenter, // Moves it to the bottom
            child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 10.0), // Adjust bottom spacing
                child: Material(
                    color: Colors.transparent, // Transparent background
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    16), // Ensures border radius applies
                                child: Image.asset(
                                  "assets/images/memories/rectangle1.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            WidgetsSpacer.verticalSpacer16,
                            Text(
                              "Capture Every Moment, Limitlessly!",
                              style: TextStyle(
                                  fontSize: FontSize.size16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Enjoy unlimited photo and memory journal uploads to capture every unforgettable moment of your travels.",
                              style: TextStyle(
                                  fontSize: FontSize.size16,
                                  leadingDistribution:
                                      TextLeadingDistribution.even),
                              textAlign: TextAlign.center,
                            ),
                            WidgetsSpacer.verticalSpacer16,
                            ElevatedButton(
                                onPressed: () {
                                  print("pricing");
                                  Navigator.pop(context);
                                  AppNavigator.push(context, const Pricing());
                                },
                                child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Upgrade to Pro"),
                                      WidgetsSpacer.horinzontalSpacer8,
                                      Icon(Icons.diamond_outlined)
                                    ])),
                            WidgetsSpacer.verticalSpacer16,
                            Text(
                              "Compare all plans - Change or cancel anytime.",
                              style: TextStyle(
                                  color: AppColors.defaultColor400,
                                  fontSize: FontSize.size14),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )))));
      });
}
