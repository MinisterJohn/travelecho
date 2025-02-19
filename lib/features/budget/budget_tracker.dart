import 'package:flutter/material.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'setbudget.dart';
import 'package:line_icons/line_icons.dart';
import 'budget_screen.dart';

class BudgetTracker extends StatefulWidget {
  @override
  _BudgetTrackerState createState() => _BudgetTrackerState();
}

class _BudgetTrackerState extends State<BudgetTracker> {
  String currentBudgetTool = "Budget Overview";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Travel Budget',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Segoe UI',
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row with Budget Overview and Expense Tracker images
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _budgetTools(
                    LineIcons.piggyBank,
                    "Budget Overview",
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  _budgetTools(
                    LineIcons.clipboardList,
                    "Expense Tracker",
                  ),
                ],
              ),
              const SizedBox(height: 30),

              currentBudgetTool == "Budget Overview"
                  ? BudgetScreen()
                  : Container()
            ],
          ),
        ),
      ),
      // floatingActionButton: Positioned(
      //   bottom: 16, // Distance from the bottom of the screen
      //   left: 16, // Distance from the left of the screen
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       // Add your onPressed logic here
      //     },
      //     backgroundColor: AppColors.primaryColor,
      //     child: const Icon(
      //       Icons.add,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
    );
  }

  // Widget for Budget Overview and Expense Tracker images
  Widget _budgetTools(IconData icon, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentBudgetTool = label;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: currentBudgetTool != label
                ? Border.all(color: Color.fromRGBO(0, 0, 0, 0.1))
                : null,
            color: currentBudgetTool == label
                ?  AppColors.primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon,
                    color: currentBudgetTool == label
                        ? Colors.white
                        : Colors.black,
                    size: 50),
                SizedBox(height: 10),
                Text(
                  label,
                  style: TextStyle(
                      color: currentBudgetTool == label
                          ? Colors.white
                          : Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
