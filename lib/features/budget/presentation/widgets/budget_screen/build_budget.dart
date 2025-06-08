import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../../budget_exports.dart';

class BuildBudget extends StatelessWidget {
  final BudgetModel budget;
  final List<CurrencyInfo> mergedCurrencies;

  const BuildBudget({
    super.key,
    required this.budget,
    required this.mergedCurrencies,
  });

  @override
  Widget build(BuildContext context) {
    print("Build: $mergedCurrencies");
    final currencyInfo = mergedCurrencies.firstWhere(
      (currency) => currency.name == budget.currency,
      orElse: () => CurrencyInfo(name: budget.currency, symbol: '', key: ""),
    );
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Center(
            child: Icon(
              LineIcons.wallet,
              size: 24,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        WidgetsSpacer.horizontalSpacer20,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                budget.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                currencyInfo.symbol.isNotEmpty
                    ? "${currencyInfo.symbol} ${budget.plannedAmount}"
                    : "${budget.currency} ${budget.plannedAmount}",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(LineIcons.cog),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Manage ${budget.name}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.defaultColor400,
                              ),
                            ),
                          ),
                          OptionButton(
                            context: context,
                            text: 'View ',
                            icon: LineIcons.eye,
                            onTap: () {},
                          ),
                          const Divider(color: AppColors.defaultColor100),
                          OptionButton(
                            context: context,
                            text: 'Edit',
                            icon: LineIcons.editAlt,
                            onTap: () {
                              AppNavigator.push(
                                context,
                                MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(value: sl<BudgetBloc>()),
                                    BlocProvider.value(
                                      value: sl<CurrencyBloc>(),
                                    ),
                                  ],
                                  child: NewBudgetPage(
                                    budget: budget,
                                    mergedCurrencyList: mergedCurrencies,
                                  ),
                                ),
                              );
                            },
                          ),
                          const Divider(color: AppColors.defaultColor100),
                          OptionButton(
                            context: context,
                            text: 'Manage Expenses',
                            icon: LineIcons.editAlt,
                            onTap: () {
                              AppNavigator.push(
                                context,
                                BlocProvider.value(
                                  value: sl<BudgetBloc>(),
                                  child: ExpenseScreen(
                                    budget: budget,
                                    currency: currencyInfo,
                                  ),
                                ),
                              );
                            },
                          ),
                          const Divider(color: AppColors.defaultColor100),
                          OptionButton(
                            context: context,
                            text: 'Delete',
                            icon: LineIcons.alternateTrash,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete Budget'),
                                    content: const Text(
                                        'Are you sure you want to delete this budget?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                         AppNavigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Call the delete budget function
                                          context.read<BudgetBloc>().add(
                                            DeleteBudgetEvent(budget.id),
                                          );
                                          AppNavigator.pop(context);
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            isDelete: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
