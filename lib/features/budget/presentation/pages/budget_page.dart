import 'package:flutter/material.dart';
import "../../budget_exports.dart";

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Budget Page'),
      //   centerTitle: true,
      //   backgroundColor: AppColors.primaryColor,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage Your Budget',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            WidgetsSpacer.verticalSpacer20,
            ElevatedButton(
              onPressed: () {
                // AppNavigator.push(
                //   context,
                //   BlocProvider.value(
                //     value: sl<BudgetBloc>(),
                //     child: const NewBudgetPage(),
                //   ),
                // );
                // Navigate to Add Budget Screen
              },
              style: mergeWithThemeButtonStyle(
                context,
                ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
              ),
              child: Text(
                'Add New Budget',
                style: TextStyle(
                  fontSize: FontSize.size16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
              ),
            ),
            WidgetsSpacer.verticalSpacer20,
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 10, // Replace with actual budget count
            //     itemBuilder: (context, index) {
            //       return Card(
            //         margin: const EdgeInsets.symmetric(vertical: 8),
            //         child: ListTile(
            //           title: Text('Budget ${index + 1}'),
            //           subtitle: const Text('Details about the budget'),
            //           trailing: IconButton(
            //             icon: const Icon(Icons.delete, color: Colors.red),
            //             onPressed: () {
            //               // Handle delete budget
            //             },
            //           ),
            //           onTap: () {
            //             // Navigate to Budget Details
            //           },
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
