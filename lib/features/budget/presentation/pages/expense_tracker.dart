import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../budget_exports.dart';

class ExpenseTracker extends StatefulWidget {
  final CurrencyInfo currencyInfo;
  const ExpenseTracker({super.key, required this.currencyInfo});

  @override
  _ExpenseTrackerState createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  String selectedMonth =
      DateTime.now().month.toString(); // Track the currently selected month
  String selectedYear =
      DateTime.now().year.toString(); // Track the currently selected year
  @override
  void initState() {
    super.initState();
    context.read<BudgetBloc>().add(GetAllExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Expense Categories",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          Text(
            "Percentage of total expenses",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          WidgetsSpacer.verticalSpacer20,
          BlocBuilder<BudgetBloc, BudgetState>(
            builder: (context, state) {
              if (state is BudgetLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ExpensesLoaded) {
                final calculatedGroupedExpenses =
                    calculateCategoryPercentagesByYearAndMonth(state.expenses);

                final expenses = state.expenses;
                final expenseMonths = _getExpenseMonths(expenses);
                final expenseYears = _getExpenseYears(expenses);
                final yearlyCategoryPercentages =
                    _calculateYearlyCategoryPercentages(expenses);
                final hasMonthData =
                    calculatedGroupedExpenses[selectedYear] != null &&
                    calculatedGroupedExpenses[selectedYear]![selectedMonth] !=
                        null &&
                    calculatedGroupedExpenses[selectedYear]![selectedMonth]!
                        .isNotEmpty;
                print(calculatedGroupedExpenses[selectedYear]);
                return Column(
                  children: [
                    ExpenseTrackerHeader(
                      selectedMonth: selectedMonth,
                      selectedYear: selectedYear,
                      expenseMonths: expenseMonths,
                      expenseYears: expenseYears,
                      onMonthYearChanged: (month, year) {
                        setState(() {
                          selectedMonth = month;
                          selectedYear = year;
                        });
                      },
                    ),
                    if (!hasMonthData)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Column(
                          children: [
                            const Text(
                              'No expenses made in this month',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Center(
                              child: Image.asset(
                                'assets/NoResultFound.png',
                                height: 100,
                              ),
                            ),
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
                                'You have not made any expenses for this month.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      ExpenseTrackerList(
                        yearlyCategoryPercentages:
                            calculatedGroupedExpenses[selectedYear]![selectedMonth]!,
                        selectedYear: selectedYear,
                      ),
                  ],
                );
              } else if (state is BudgetError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Map<String, Map<String, List<ExpenseModel>>> groupExpensesByYearAndMonth(
    List<ExpenseModel> expenses,
  ) {
    final Map<String, Map<String, List<ExpenseModel>>> grouped = {};
    for (var expense in expenses) {
      final year = expense.createdAt!.year.toString();
      final month = expense.createdAt!.month.toString();
      grouped.putIfAbsent(year, () => {});
      grouped[year]!.putIfAbsent(month, () => []);
      grouped[year]![month]!.add(expense);
    }
    return grouped;
  }

  /// Returns {year: {month: {category: percentage}}}
  Map<String, Map<String, Map<String, double>>>
  calculateCategoryPercentagesByYearAndMonth(List<ExpenseModel> expenses) {
    final grouped = groupExpensesByYearAndMonth(expenses);
    final Map<String, Map<String, Map<String, double>>> result = {};
    grouped.forEach((year, months) {
      result[year] = {};
      months.forEach((month, expensesList) {
        final total = expensesList.fold<double>(
          0.0,
          (sum, e) => sum + (e.amount <= 0 ? e.plannedAmount! : e.amount),
        );
        final Map<String, double> categoryTotals = {};
        for (var e in expensesList) {
          final amount = e.amount <= 0 ? e.plannedAmount! : e.amount;
          categoryTotals[e.category] =
              (categoryTotals[e.category] ?? 0) + amount;
        }
        final Map<String, double> categoryPercentages = {};
        categoryTotals.forEach((cat, amt) {
          categoryPercentages[cat] = total > 0 ? (amt / total) * 100 : 0;
        });
        result[year]![month] = categoryPercentages;
      });
    });
    return result;
  }

  Map<String, double> _calculateCategoryPercentages(
    List<ExpenseModel> expenses,
  ) {
    final totalAmount = expenses.fold(
      0.0,
      (sum, expense) =>
          sum + (expense.amount <= 0 ? expense.plannedAmount! : expense.amount),
    );

    final Map<String, double> categoryTotals = {};

    for (var expense in expenses) {
      final amount =
          expense.amount <= 0 ? expense.plannedAmount! : expense.amount;
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0) + amount;
    }

    final Map<String, double> categoryPercentages = {};
    categoryTotals.forEach((category, total) {
      categoryPercentages[category] = (total / totalAmount) * 100;
    });

    return categoryPercentages;
  }

  Map<String, Map<String, double>> _calculateYearlyCategoryPercentages(
    List<ExpenseModel> expenses,
  ) {
    final Map<String, Map<String, double>> yearlyCategoryTotals = {};

    for (var expense in expenses) {
      final year = expense.createdAt!.year.toString();
      final amount =
          expense.amount <= 0 ? expense.plannedAmount! : expense.amount;

      yearlyCategoryTotals[year] ??= {};
      yearlyCategoryTotals[year]![expense.category] =
          (yearlyCategoryTotals[year]![expense.category] ?? 0) + amount;
    }

    final Map<String, Map<String, double>> yearlyCategoryPercentages = {};

    yearlyCategoryTotals.forEach((year, categoryTotals) {
      final totalAmount = categoryTotals.values.fold(
        0.0,
        (sum, amount) => sum + amount,
      );

      yearlyCategoryPercentages[year] = {};
      categoryTotals.forEach((category, total) {
        yearlyCategoryPercentages[year]![category] =
            (total / totalAmount) * 100;
      });
    });

    return yearlyCategoryPercentages;
  }

  List<String> _getExpenseMonths(List<ExpenseModel> expenses) {
    final months =
        expenses
            .map((expense) => expense.createdAt!.month.toString())
            .toSet()
            .toList();
    final currentMonth = DateTime.now().month.toString();
    if (!months.contains(currentMonth)) {
      months.add(currentMonth);
    }
    return _sortMonths(months);
  }

  List<String> _getExpenseYears(List<ExpenseModel> expenses) {
    final years =
        expenses
            .map((expense) => expense.createdAt!.year.toString())
            .toSet()
            .toList();
    years.sort();
    return years;
  }

  List<String> _sortMonths(List<String> months) {
    const monthOrder = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
    ];

    months.sort(
      (a, b) => monthOrder.indexOf(a).compareTo(monthOrder.indexOf(b)),
    );
    return months;
  }
}
