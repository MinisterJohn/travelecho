import 'package:flutter/material.dart';
import '../../../budget_exports.dart';
// TODO: Replace the below import with the correct path if ExpenseCategoryModel is defined elsewhere

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
  _ExpenseCategorySelectorState createState() =>
      _ExpenseCategorySelectorState();
}

class _ExpenseCategorySelectorState extends State<ExpenseCategorySelector> {
  String selectedCategory = "";

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory.isNotEmpty
        ? widget.initialCategory
        : "Select Category";
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
                padding: const EdgeInsets.symmetric(vertical: 16.0,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Center(
                        child: const Text(
                          'Highlight what best fits your travel experience',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    WidgetsSpacer.verticalSpacer20,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.builder(
                        itemCount: widget.categories.length,
                        itemBuilder: (context, index) {
                          final category = widget.categories[index];
                          return ListTile(
                            leading: category.icon,
                            title: Text(category.name),
                            subtitle: Text(category.description),
                            onTap: () {
                              setState(() {
                                selectedCategory = category.name;
                              widget.onCategorySelected(category.name);
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
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
          children: <Widget>[
            Text(
              selectedCategory,
              style: TextStyle(
                color:
                    selectedCategory == "Select Category"
                        ? AppColors.defaultColor400
                        : AppColors.defaultColor,
              ),
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
