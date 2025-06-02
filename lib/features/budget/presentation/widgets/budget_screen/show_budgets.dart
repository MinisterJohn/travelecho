import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../budget_exports.dart';

class ShowBudgets extends StatelessWidget {
  final List<BudgetModel> budgetsData;

  const ShowBudgets({Key? key, required this.budgetsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Budget Overview",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Column(
          spacing: 10,
          children:
              budgetsData.map((budget) {
                return BuildBudget(budget: budget);
              }).toList(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            AppNavigator.push(
              context,
              BlocProvider.value(
                value: sl<BudgetBloc>(),
                child: const NewBudgetPage(),
              ),
            );
            // Add your logic here
          },

          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.white),
              SizedBox(width: 8),
              Text('Add New Budget', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
