import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/appbar.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/core/hoc/containerWidget.dart';

class Pricing extends StatefulWidget {
  const Pricing({super.key});

  @override
  State<Pricing> createState() => _PricingState();
}

class _PricingState extends State<Pricing> {
  String _subscriptionTiming = "monthly";

  bool isMonthly() {
    return _subscriptionTiming == "monthly";
  }

  bool isYearly() {
    return _subscriptionTiming == "yearly";
  }

  Map<String, List> plans = {
    "free": [
      {
        "title": "Automatic Travel Tracking",
        "description":
            "Basic tracking of locations, limited to major destinations, with monthly data or check-ins."
      },
      {
        "title": "Photo and Memory Journal",
        "description":
            "Limited storage for photos and memories, basic journaling options."
      },
      {
        "title": "Social Media Sharing",
        "description":
            "Simple sharing option to post location updates on social media."
      },
      {
        "title": "Currency Converter",
        "description":
            "Access to a simple converter with popular currencies only."
      },
      {
        "title": "Language and Culture Guide",
        "description":
            "Basic phrases and cultural info for popular destinations."
      },
      {
        "title": "Community Building",
        "description": " meeting travel buddies with code verifications"
      },
      {
        "title": "Milestones recognition",
        "description": " with limited badges, rewards "
      },
      {
        "title": "Flight and hotel reservations",
        "description":
            "with integrated booking system, limited recommendations "
      },
    ],
    "paid": [
      {
        "title": "Real-time Tracking",
        "description": "Detailed routes and map integration."
      },
      {
        "title": "Expanded Storage",
        "description":
            "Increased storage for photos and memories, with album organization."
      },
      {
        "title": "Advanced Currency Converter",
        "description":
            "Access to a broader range of currencies and live exchange rates."
      },
      {
        "title": "Travel Budget Tracking",
        "description":
            "Basic and advanced budget planning with detailed analytics."
      },
      {
        "title": "Visa and Immigration Info",
        "description":
            "Comprehensive visa and immigration tips, document checklists, and visa concierge."
      },
      {
        "title": "Flight and Hotel Reservation",
        "description":
            "with personalized support and advanced travel recommendations and  adjustments plus"
      },
      {
        "title": "Milestones and achievements",
        "description":
            "with unlimited rewards, badges, and exclusive member recognition."
      },
      {
        "title": "Travel Recommendations",
        "description":
            "Suggested places to visit, real-time insights, and VIP-only tips."
      },
      {
        "title": "Language and Culture Guide",
        "description":
            "Expanded language support, cultural insights, local expert access, and language practice tools."
      },
      {
        "title": "Photo and Memory Journal",
        "description":
            "Unlimited storage, high-resolution media upload, and memory creation."
      },
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Get Pro", context),
      body: SingleChildScrollView(
        child: ScreenContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidgetsSpacer.verticalSpacer16,
              _pricingIntro(),
              WidgetsSpacer.verticalSpacer48,
              _planCard("Free", 0, true, plans["free"] ?? []),
              WidgetsSpacer.verticalSpacer32,
              _planCard("Premium", isMonthly() ? 9.99 : 9.99 * 12 * 0.9, false,
                  plans["paid"] ?? []),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pricingIntro() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Upgrade to Pro",
            style: TextStyle(
                fontSize: FontSize.size24, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            width: 30, // Line length
            height: 2, // Line thickness
            color: AppColors.defaultColor, // Line color
          )
        ],
      ),
      WidgetsSpacer.verticalSpacer8,
      Text(
        "Get unlimited access.",
        style:
            TextStyle(fontSize: FontSize.size24, fontWeight: FontWeight.bold),
      ),
      WidgetsSpacer.verticalSpacer8,
      if (isYearly())
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: "Save 10%",
                style: const TextStyle(color: AppColors.primaryColor)),
            TextSpan(text: "on yearly subscription")
          ]),
          style: TextStyle(
              fontSize: FontSize.size14, color: AppColors.defaultColor400),
        ),
      WidgetsSpacer.verticalSpacer8,
      IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.defaultColor100,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              _monthlyYearlyBtn("Monthly", isMonthly()),
              _monthlyYearlyBtn("Yearly", isYearly())
            ],
          ),
        ),
      )
    ]);
  }

  Widget _monthlyYearlyBtn(String btnText, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _subscriptionTiming = btnText.toLowerCase();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: isActive ? AppColors.primaryColor : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Text(
          btnText,
          style: TextStyle(
              color: isActive ? AppColors.white : AppColors.defaultColor400,
              fontSize: FontSize.size14),
        ),
      ),
    );
  }

  Widget _planCard(String planTitle, double planPrice, bool planIsActive,
      List planFeatures) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.defaultColor100,
                blurRadius: 10,
                spreadRadius: 5)
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            planTitle,
            style: TextStyle(
                fontSize: FontSize.size24, fontWeight: FontWeight.bold),
          ),
          WidgetsSpacer.verticalSpacer8,
          Text.rich(TextSpan(children: [
            TextSpan(text: "\$$planPrice/${isMonthly() ? "month" : "year"} "),
            planTitle == "Premium" && isYearly()
                ? TextSpan(
                    text: "(10% discount)",
                    style: TextStyle(color: AppColors.primaryColor))
                : TextSpan()
          ], style: TextStyle(fontWeight: FontWeight.bold))),
          WidgetsSpacer.verticalSpacer16,
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: planFeatures.map((feature) {
                return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(LineIcons.check, size: 16),
                    title: Text(feature["title"] ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(feature["description"] ?? "",
                        style: TextStyle(color: AppColors.secondaryColor)));
              }).toList()),
          WidgetsSpacer.verticalSpacer16,
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color: planIsActive
                      ? Colors.transparent
                      : AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                planIsActive ? "Currently in use" : "Choose plan",
                style: TextStyle(
                    color:
                        planIsActive ? AppColors.primaryColor : AppColors.white,
                    fontSize: FontSize.size24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
