import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../budget_exports.dart';

class CategoriesTab extends StatefulWidget {
  final BudgetModel updatedBudget;
  final CurrencyInfo currencyInfo;

  const CategoriesTab({
    super.key,
    required this.updatedBudget,
    required this.currencyInfo,
  });

  @override
  _CategoriesTabState createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  int? touchedIndex;
  CategoryExpense? selectedCategory;
  late List<CategoryExpense> categoryData;

  @override
  void initState() {
    super.initState();
    // Trigger the animation
    Future.delayed(Duration.zero, () {
      setState(() {
        selectedCategory =
            categoryData.isNotEmpty
                ? categoryData[0]
                : null; // Reset selected category
        // Removed unused field
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenses = widget.updatedBudget.expenses ?? [];
    categoryData = _generateCategoryData(expenses);
    // selectedCategory = categoryData.isNotEmpty ? categoryData[0] : null;

    final symbol =
        widget.currencyInfo.symbol.isNotEmpty
            ? widget.currencyInfo.symbol
            : widget.updatedBudget.currency;
    print("Category Data: $categoryData");
    print("Expenses: $expenses");

    if (categoryData.isEmpty) {
      return EmptyScreen(
        description:
            "No Expense Category data since \nno expense has been created.",
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: 16,
        ),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  categoryData.map((data) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategory = data;
                        });
                      },
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: 100,
                          minHeight: 40,
                        ),
                        decoration: BoxDecoration(
                          color:
                              (selectedCategory != null &&
                                      selectedCategory!.category ==
                                          data.category)
                                  ? AppColors.primaryColor
                                  : AppColors.primaryColor100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: data.color,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              data.category,
                              style: TextStyle(
                                color:
                                    (selectedCategory != null &&
                                            selectedCategory!.category ==
                                                data.category)
                                        ? AppColors.white
                                        : AppColors.defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
            WidgetsSpacer.verticalSpacer16,
            Container(
              constraints: const BoxConstraints(maxHeight: 400, minHeight: 200),
              child: Stack(
                // fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  ClipRect(
                    child: SfCircularChart(
                      onLegendTapped: (LegendTapArgs details) {
                        setState(() {
                          touchedIndex = details.pointIndex;
                          selectedCategory = categoryData[touchedIndex!];
                        });
                      },
                      series: [
                        DoughnutSeries<CategoryExpense, String>(
                          dataSource: categoryData,
                          xValueMapper: (data, _) => data.category,
                          yValueMapper: (data, _) => data.plannedAmount,
                          pointColorMapper: (data, _) => data.color,
                          startAngle: 270,
                          endAngle: 90,
                          radius: '100%',
                          innerRadius: '75%',
                          // dataLabelSettings: const DataLabelSettings(
                          //   isVisible: true,
                          // ),
                        ),
                      ],
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer32,
                  if (selectedCategory != null)
                    Column(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Average",
                          style: TextStyle(color: AppColors.defaultColor400, fontSize: 14),
                        ),
                        Text(
                          BudgetUtils.formatAmount(
                            selectedCategory!.averageAmount,
                            symbol,
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text:
                                "${selectedCategory!.percentageOfTotal.toStringAsFixed(2)}%",
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    " of this budget \n was spent on ${selectedCategory!.category}",
                                style: const TextStyle(
                                  color: AppColors.defaultColor400,
                                ),
                              ),
                            ],
                          ),
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildBudgetInfoCard(
                              title: "Minimum Amount",
                              amount: BudgetUtils.formatAmount(
                                selectedCategory!.minimumAmount,
                                symbol,
                              ),
                              updatedBudget: widget.updatedBudget,
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1.0,
                              indent: 0,
                              endIndent: 0,
                            ),
                            buildBudgetInfoCard(
                              title: "Maximum Amount",
                              amount: BudgetUtils.formatAmount(
                                selectedCategory!.maximumAmount,
                                symbol,
                              ),
                              updatedBudget: widget.updatedBudget,
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),

            WidgetsSpacer.verticalSpacer16,
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  List<CategoryExpense> _generateCategoryData(List<ExpenseModel> expenses) {
    final totalAmount = expenses
        .map((e) => e.amount != 0.0 ? e.amount : e.plannedAmount ?? 0.0)
        .reduce((a, b) => a + b);
    final categoryMap = <String, Map<String, double>>{};

    for (var expense in expenses) {
      final category = expense.category;
      final double plannedAmount = expense.plannedAmount ?? 0.0;
      final double spentAmount = expense.amount;

      if (!categoryMap.containsKey(category)) {
        categoryMap[category] = {'plannedAmount': 0.0, 'spentAmount': 0.0};
      }

      categoryMap[category]!['plannedAmount'] =
          (categoryMap[category]!['plannedAmount'] ?? 0.0) + plannedAmount;
      categoryMap[category]!['spentAmount'] =
          (categoryMap[category]!['spentAmount'] ?? 0.0) + spentAmount;
    }

    return categoryMap.entries.map((entry) {
      final amounts =
          expenses
              .where((expense) => expense.category == entry.key)
              .map((e) => e.amount == 0.0 ? e.plannedAmount ?? 0.0 : e.amount)
              .toList();
      final minAmount = amounts.reduce((a, b) => a < b ? a : b);
      final maxAmount = amounts.reduce((a, b) => a > b ? a : b);
      final avgAmount = amounts.reduce((a, b) => a + b) / amounts.length;
      final percentageOfTotal =
          ((entry.value['spentAmount'] != 0.0
                  ? entry.value['spentAmount']!
                  : entry.value['plannedAmount']!) /
              totalAmount) *
          100;
      print(
        "Category: ${entry.key}, Spent: ${entry.value['spentAmount']}, Planned: ${entry.value['plannedAmount']}, Percentage: $percentageOfTotal",
      );
      return CategoryExpense(
        category: entry.key,
        amount: entry.value['spentAmount']!,
        plannedAmount: entry.value['plannedAmount']!,
        color:
            expenseCategories.map((e) => e.name).contains(entry.key)
                ? expenseCategories
                    .firstWhere((e) => e.name == entry.key)
                    .color!
                : Colors.grey,
        minimumAmount: minAmount,
        maximumAmount: maxAmount,
        averageAmount: avgAmount,
        percentageOfTotal: percentageOfTotal,
      );
    }).toList();
  }
}

class CategoryExpense {
  final String category;
  final double amount;
  final double plannedAmount;
  final double minimumAmount;
  final double maximumAmount;
  final double averageAmount;
  final double percentageOfTotal;
  final Color color;

  CategoryExpense({
    required this.category,
    required this.amount,
    required this.plannedAmount,
    required this.color,
    this.minimumAmount = 0.0,
    this.maximumAmount = 0.0,
    this.averageAmount = 0.0,
    this.percentageOfTotal = 0.0,
  });
}
