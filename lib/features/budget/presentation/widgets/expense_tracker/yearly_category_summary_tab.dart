import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../budget_exports.dart';

class YearlyCategorySummaryTab extends StatefulWidget {
  final Map<String, double> yearlyCategoryPercentages;
  final Map<String, List<double>> yearlyCategoryAmounts; // [min, max, avg]
  final String currencySymbol;

  const YearlyCategorySummaryTab({
    super.key,
    required this.yearlyCategoryPercentages,
    required this.yearlyCategoryAmounts,
    required this.currencySymbol,
  });

  @override
  State<YearlyCategorySummaryTab> createState() =>
      _YearlyCategorySummaryTabState();
}

class _YearlyCategorySummaryTabState extends State<YearlyCategorySummaryTab> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.yearlyCategoryPercentages.isNotEmpty) {
      selectedCategory = widget.yearlyCategoryPercentages.keys.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.yearlyCategoryPercentages.keys.toList();
    if (categories.isEmpty) {
      return EmptyScreen(description: "No yearly category data available.");
    }
    final selectedAmounts =
        selectedCategory != null
            ? widget.yearlyCategoryAmounts[selectedCategory!]
            : null;
    final selectedPercentage =
        selectedCategory != null
            ? widget.yearlyCategoryPercentages[selectedCategory!] ?? 0.0
            : 0.0;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  categories.map((cat) {
                    return InkWell(
                      onTap: () => setState(() => selectedCategory = cat),
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 100,
                          minHeight: 40,
                        ),
                        decoration: BoxDecoration(
                          color:
                              selectedCategory == cat
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
                                color:
                                    expenseCategories
                                        .firstWhere(
                                          (e) => e.name == cat,
                                          orElse: () => expenseCategories.first,
                                        )
                                        .color ??
                                    Colors.grey,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              cat,
                              style: TextStyle(
                                color:
                                    selectedCategory == cat
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
                alignment: Alignment.center,
                children: [
                  ClipRect(
                    child: SfCircularChart(
                      series: [
                        DoughnutSeries<_YearlyCategoryData, String>(
                          dataSource:
                              categories
                                  .map(
                                    (cat) => _YearlyCategoryData(
                                      cat,
                                      widget.yearlyCategoryPercentages[cat] ??
                                          0.0,
                                      expenseCategories
                                              .firstWhere(
                                                (e) => e.name == cat,
                                                orElse:
                                                    () =>
                                                        expenseCategories.first,
                                              )
                                              .color ??
                                          Colors.grey,
                                    ),
                                  )
                                  .toList(),
                          xValueMapper: (data, _) => data.category,
                          yValueMapper: (data, _) => data.percentage,
                          pointColorMapper: (data, _) => data.color,
                          startAngle: 270,
                          endAngle: 90,
                          radius: '100%',
                          innerRadius: '75%',
                        ),
                      ],
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer32,
                  if (selectedCategory != null && selectedAmounts != null)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Average",
                          style: TextStyle(
                            color: AppColors.defaultColor400,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          BudgetUtils.formatAmount(
                            selectedAmounts.length > 2
                                ? selectedAmounts[2]
                                : 0.0,
                            widget.currencySymbol,
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "${selectedPercentage.toStringAsFixed(2)}%",
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    " of this year was spent on $selectedCategory",
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
                                selectedAmounts.isNotEmpty
                                    ? selectedAmounts[0]
                                    : 0.0,
                                widget.currencySymbol,
                              ),
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
                                selectedAmounts.length > 1
                                    ? selectedAmounts[1]
                                    : 0.0,
                                widget.currencySymbol,
                              ),
                              updatedBudget: null,
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
}

class _YearlyCategoryData {
  final String category;
  final double percentage;
  final Color color;
  _YearlyCategoryData(this.category, this.percentage, this.color);
}
