import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../../budget_exports.dart';

class BuildBudget extends StatefulWidget {
  final BudgetModel budget;
  final List<CurrencyInfo> mergedCurrencies;

  const BuildBudget({
    super.key,
    required this.budget,
    required this.mergedCurrencies,
  });

  @override
  _BuildBudgetState createState() => _BuildBudgetState();
}

class _BuildBudgetState extends State<BuildBudget> {
  late BuildContext ancestorContext;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Save a reference to the ancestor context safely
    ancestorContext = context;
  }

  @override
  Widget build(BuildContext context) {
    final currencyInfo = widget.mergedCurrencies.firstWhere(
      (currency) => currency.name == widget.budget.currency,
      orElse:
          () => CurrencyInfo(name: widget.budget.currency, symbol: '', key: ""),
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
                widget.budget.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                currencyInfo.symbol.isNotEmpty
                    ? BudgetUtils.formatAmount(
                      widget.budget.plannedAmount,
                      currencyInfo.symbol,
                    )
                    : BudgetUtils.formatAmount(
                      widget.budget.plannedAmount,
                      widget.budget.currency,
                    ),
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
              builder: (BuildContext dialogContext) {
                return BlocProvider.value(
                  value: sl<BudgetBloc>(),
                  child: Center(
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
                                'Manage ${widget.budget.name}',
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
                              onTap: () {
                                context.read<BudgetBloc>().saveCurrentState();
                                AppNavigator.push(
                                  context,
                                  BlocProvider.value(
                                    value: sl<BudgetBloc>(),
                                    child: ViewBudgetScreen(
                                      budget: widget.budget,
                                      currencyInfo: currencyInfo,
                                    ),
                                  ),
                                );
                              },
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
                                      BlocProvider.value(
                                        value: sl<BudgetBloc>(),
                                      ),
                                      BlocProvider.value(
                                        value: sl<CurrencyBloc>(),
                                      ),
                                    ],
                                    child: NewBudgetPage(
                                      budget: widget.budget,
                                      mergedCurrencyList:
                                          widget.mergedCurrencies,
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
                                      budget: widget.budget,
                                      currency: currencyInfo,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Divider(color: AppColors.defaultColor100),
                            BlocProvider.value(
                              value: sl<BudgetBloc>(),
                              child: OptionButton(
                                context: ancestorContext,
                                text: 'Delete',
                                icon: LineIcons.alternateTrash,
                                onTap: () {
                                  showDialog(
                                    context: ancestorContext,
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        title: const Text('Delete Budget'),
                                        content: const Text(
                                          'Are you sure you want to delete this budget?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              AppNavigator.pop(dialogContext);
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.defaultColor400,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Call the delete budget function
                                              sl<BudgetBloc>().add(
                                                DeleteBudgetEvent(
                                                  widget.budget.id,
                                                ),
                                              );
                                              AppNavigator.pop(dialogContext);
                                            },
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
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
                              ),
                            ),
                          ],
                        ),
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
