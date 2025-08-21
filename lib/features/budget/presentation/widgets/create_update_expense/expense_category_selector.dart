import 'package:flutter/material.dart';
import '../../../budget_exports.dart';

class ExpenseCategorySelector extends StatefulWidget {
  final List<ExpenseCategoryModel> categories;
  final ValueChanged<String> onCategorySelected;
  final String initialCategory;

  const ExpenseCategorySelector({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    this.initialCategory = "Select Category",
  });

  @override
  State<ExpenseCategorySelector> createState() =>
      _ExpenseCategorySelectorState();
}

class _ExpenseCategorySelectorState extends State<ExpenseCategorySelector> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory =
        widget.initialCategory.isNotEmpty
            ? widget.initialCategory
            : "Select Category";
  }

  @override
  void didUpdateWidget(covariant ExpenseCategorySelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 🔑 When parent updates the category, refresh here too
    if (widget.initialCategory != oldWidget.initialCategory) {
      setState(() {
        selectedCategory = widget.initialCategory;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Center(
                        child: Text(
                          'Highlight what best fits your travel experience',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    WidgetsSpacer.verticalSpacer20,
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.categories.length,
                      itemBuilder: (context, index) {
                        final category = widget.categories[index];
                        return ListTile(
                          leading: category.icon,
                          title: Text(category.name),
                          subtitle: Text(category.description),
                          trailing:
                              selectedCategory == category.name
                                  ? const Icon(
                                    Icons.check,
                                    color: Colors.purple,
                                  )
                                  : null,
                          onTap: () {
                            setState(() {
                              selectedCategory = category.name;
                            });
                            widget.onCategorySelected(category.name);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedCategory,
              style: TextStyle(
                color:
                    selectedCategory == "Select Category"
                        ? AppColors.defaultColor400
                        : AppColors.defaultColor,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
