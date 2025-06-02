import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../../budget_exports.dart";

class ShowEmptyBudget extends StatelessWidget {
  final VoidCallback onAddBudget;

  const ShowEmptyBudget({Key? key, required this.onAddBudget})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Set your Budget here',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 40),
        Center(child: Image.asset('assets/NoResultFound.png', height: 100)),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'Nothing to see here!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'You can set your budget for your next trip\nand manage your finances.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: (){
              AppNavigator.push(
                context,
                BlocProvider.value(
                  value: sl<BudgetBloc>(),
                  child: const NewBudgetPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF930BFF),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Set your budget', style: TextStyle(color: Colors.white)),
                SizedBox(width: 8),
                Icon(Icons.add, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
