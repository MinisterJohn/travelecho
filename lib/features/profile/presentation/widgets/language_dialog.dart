import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/hoc/bottomModalDraggable.dart';

void showLanguageDialog(BuildContext context) {
  bool isFrenchSelected = false;
  bool isPortugueseSelected = false;
  bool isGermanSelected = false;
  TextEditingController _searchController = TextEditingController();
  DraggableBottomModal(
    context,
    StatefulBuilder(
      builder: (context, setState) {
        // 👈 Use StatefulBuilder to manage state
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Icon(
                    LineIcons.timesCircleAlt,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Search field with the search icon inside
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                fillColor: AppColors.primaryColor100,
                filled: true,
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.primaryColor),
                hintText: "Type your language",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
            WidgetsSpacer.verticalSpacer8,

            // Language selection checkboxes
            CheckboxListTile(
              title: const Text("French"),
              value: isFrenchSelected,
              onChanged: (bool? value) {
                setState(() {
                  isFrenchSelected = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Portuguese"),
              value: isPortugueseSelected,
              onChanged: (bool? value) {
                setState(() {
                  isPortugueseSelected = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("German"),
              value: isGermanSelected,
              onChanged: (bool? value) {
                setState(() {
                  isGermanSelected = value!;
                });
              },
            ),
            WidgetsSpacer.verticalSpacer16,
            Spacer(),
            // "Next" button
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                // Use the selected language values if needed
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
