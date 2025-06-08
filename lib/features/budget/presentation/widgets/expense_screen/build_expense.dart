import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../../budget_exports.dart';
import '../create_update_expense/expense_categories.dart';

class BuildExpense extends StatefulWidget {
  final ExpenseModel expense;
  final CurrencyInfo currency;

  const BuildExpense({
    super.key,
    required this.expense,
    required this.currency,
  });

  @override
  State<BuildExpense> createState() => _BuildExpenseState();
}

class _BuildExpenseState extends State<BuildExpense> {
  late BuildContext ancestorContext;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Save a reference to the ancestor context safely
    ancestorContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Icon(
              expenseCategories
                  .firstWhere(
                    (category) =>
                        category.name.toLowerCase() ==
                        widget.expense.category.toLowerCase(),
                    orElse:
                        () => ExpenseCategoryModel(
                          name: 'Miscellaneous',
                          description:
                              'Unexpected or uncategorized travel-related expenses.',
                          icon: Icon(LineIcons.horizontalEllipsis),
                        ),
                  )
                  .icon
                  .icon,
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
                widget.expense.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${widget.currency.symbol.isNotEmpty ? widget.currency.symbol : widget.currency.key} ${widget.expense.plannedAmount}",
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
                              'Manage ${widget.expense.title}',
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
                              // AppNavigator.push(
                              //   context,
                              //   MultiBlocProvider(
                              //     providers: [
                              //       BlocProvider.value(value: sl<BudgetBloc>()),
                              //       BlocProvider.value(
                              //         value: sl<CurrencyBloc>(),
                              //       ),
                              //     ],
                              //     child: AddExpensePage(
                              //       budget: widget.expense.budgetId,
                              //       mergedCurrencyList: mergedCurrencies,
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                          const Divider(color: AppColors.defaultColor100),
                          // OptionButton(
                          //   context: context,
                          //   text: 'Manage Expenses',
                          //   icon: LineIcons.editAlt,
                          //   onTap: () {
                          //     AppNavigator.push(
                          //       context,
                          //       BlocProvider.value(
                          //         value: sl<BudgetBloc>(),
                          //         child: AddExpensePage(
                          //           budget: budget,
                          //           mergedCurrencies: mergedCurrencies,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          // const Divider(color: AppColors.defaultColor100),
                          BlocProvider.value(
                            value: sl<BudgetBloc>(),
                            child: Builder(
                              builder: (builderContext) {
                                return OptionButton(
                                  context:
                                      ancestorContext, // Use the saved ancestor context
                                  text: 'Delete',
                                  icon: LineIcons.alternateTrash,
                                  onTap: () {
                                    showDialog(
                                      context:
                                          ancestorContext, // Use the saved ancestor context
                                      builder: (BuildContext dialogContext) {
                                        return AlertDialog(
                                          title: Text(
                                            'Delete ${widget.expense.title}',
                                          ),
                                          content: const Text(
                                            'Are you sure you want to delete this expense?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed:
                                                  () => AppNavigator.pop(
                                                    dialogContext,
                                                  ),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.defaultColor400,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                ancestorContext
                                                    .read<BudgetBloc>()
                                                    .add(
                                                      DeleteExpenseEvent(
                                                        widget.expense.id,
                                                      ),
                                                    );
                                                AppNavigator.pop(dialogContext);
                                              },
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: AppColors.errorColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  isDelete: true,
                                );
                              },
                            ),
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
