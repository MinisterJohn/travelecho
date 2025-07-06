import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../../budget_exports.dart";

class ShowEmptyBudget extends StatelessWidget {
  final VoidCallback onAddBudget;

  const ShowEmptyBudget({super.key, required this.onAddBudget});

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
            'You can set your budget for your next trip\nand manage your finances.',
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
                      return NewBudgetPage(
                        mergedCurrencyList:
                            state is MergedCurrencyListLoaded
                                ? state.currencies
                                : [],
                      );
                    },
                  ),
                ),
              );
            },

            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Set your budget',
                  style: TextStyle(
                    fontSize: FontSize.size16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
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
