import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';

class InterestSelectionPage extends StatefulWidget {
  @override
  _InterestSelectionPageState createState() => _InterestSelectionPageState();
}

class _InterestSelectionPageState extends State<InterestSelectionPage> {
  List<String> interests = [
    "Beaches",
    "Pets",
    "Modeling",
    "Shopping",
    "Hiking",
    "Gaming",
    "Swimming",
    "Soccer",
    "Tech"
  ];

  List<String> selectedInterests = [];
  TextEditingController interestController = TextEditingController();

  void addCustomInterest(String interest) {
    if (interest.isNotEmpty && !interests.contains(interest)) {
      setState(() {
        interests.add(interest);
        if (selectedInterests.length < 3) {
          selectedInterests.add(interest);
        }
      });
    }
    interestController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading and description
          const Text(
            "What are you into?",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            "Pick up to 3 interests that you will love to show on your profile.",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),

          // Custom interest input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: interestController,
                  decoration: InputDecoration(
                    hintText: "Add your interest",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 12.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              //
            ],
          ),
          WidgetsSpacer.verticalSpacer16,

          // Interest buttons in a grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Display 3 buttons in a row
                crossAxisSpacing: 10.0, // Space between columns
                mainAxisSpacing: 10.0, // Space between rows
                childAspectRatio: 2, // Adjusts the size of the buttons
              ),
              itemCount: interests.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (selectedInterests.contains(interests[index])) {
                        selectedInterests.remove(interests[index]);
                      } else if (selectedInterests.length < 3) {
                        selectedInterests.add(interests[index]);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size(30.w, 65.h),
                    backgroundColor: AppColors.primaryColor100,
                    foregroundColor:
                        selectedInterests.contains(interests[index])
                            ? AppColors.primaryColor
                            : AppColors.defaultColor,

                    side: BorderSide(
                        color: selectedInterests.contains(interests[index])
                            ? AppColors.primaryColor
                            : Colors.transparent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 8.0), // Reduced padding
                  ),
                  child: Text(
                    interests[index],
                    style: const TextStyle(
                      fontSize: 12.0, // Reduced font size for smaller buttons
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          WidgetsSpacer.verticalSpacer16,

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () => addCustomInterest(interestController.text),
                style: ElevatedButton.styleFrom(
                    // backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
                child: const Text(
                  "Add More Interests",
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
              WidgetsSpacer.verticalSpacer8,
              // Save button
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(),
                  child: Text("Done")),
            ],
          ),
          // GestureDetector(
          //   onTap: () {
          //     // Handle the save action here
          //     Navigator.of(context).pop(); // Close the page
          //     // Optionally, you can use the selected interests here
          //   },
          //   child: Container(
          //     width: double.infinity, // Full width
          //     height: 46,

          //      // Updated height
          //     child: Center(
          //       child: Text(
          //         "Save",
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
