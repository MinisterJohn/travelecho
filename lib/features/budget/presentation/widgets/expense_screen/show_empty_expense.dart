import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../../budget_exports.dart";

class ShowEmptyExpense extends StatelessWidget {
  final VoidCallback onAddExpense;
  final BudgetModel budget;

  const ShowEmptyExpense({
    super.key,
    required this.onAddExpense,
    required this.budget,
  });

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
        WidgetsSpacer.verticalSpacer20,
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
        WidgetsSpacer.verticalSpacer20,
        const Center(
          child: Text(
            'Your travel expenses will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        WidgetsSpacer.verticalSpacer20,
        Center(
          child: ElevatedButton(
            onPressed: () {
              AppNavigator.push(
                context,

                MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: sl<CurrencyBloc>()),
                    BlocProvider.value(value: sl<BudgetBloc>()),
                  ],
                  child: BlocBuilder<CurrencyBloc, CurrencyState>(
                    builder: (context, state) {
                      return AddExpensePage(
                        budget: budget,
                        mergedCurrencies:
                            state is MergedCurrencyListLoaded
                                ? state.currencies
                                : [],
                      );
                    },
                  ),
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
                Text(
                  'Plan your Expense',
                  style: TextStyle(color: Colors.white),
                ),
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
