import 'package:flutter/material.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/features/budget/data/models/budget_model.dart';
import 'package:travelecho/features/budget/data/models/expense_model.dart';
// import 'budget_model.dart'; // Your Budget model file
// import 'expense_model.dart'; // Your ExpenseCategory model file

class AddCategoriesScreen extends StatefulWidget {
  final Budget budget;
  const AddCategoriesScreen({super.key, required this.budget});

  @override
  _AddCategoriesScreenState createState() => _AddCategoriesScreenState();
}

class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  final List<ExpenseCategory> _expenseCategories = [
    ExpenseCategory(
        title: "Cruise",
        description: "Travels on ship and boats cruise",
        imagePath: "cruise.png",
        expenseIsAdded: false),
    ExpenseCategory(
        title: "Road Trips",
        description: "Multiple destinations by car or RV",
        imagePath: "carbon_road.png",
        expenseIsAdded: false),
    ExpenseCategory(
        title: "Wildlife Watching",
        description: "Visiting zoos, aquariums, etc.",
        imagePath: "tripsouthafrica.png",
        expenseIsAdded: false),
    ExpenseCategory(
        title: "Accommodation",
        description: "Hotel Bookings",
        imagePath: "accomodation.png",
        expenseIsAdded: false),
    ExpenseCategory(
        title: "Food & Drinks",
        description: "Restaurant and cafes",
        imagePath: "foodanddrinks.png",
        expenseIsAdded: false),
    ExpenseCategory(
        title: "Transportation",
        description: "Flights, taxis, etc.",
        imagePath: "transportation.png",
        expenseIsAdded: false),
    ExpenseCategory(
        title: "Outdoor Adventures",
        description: "Hiking, biking, kayaking, etc.",
        imagePath: "outdooradventures.png",
        expenseIsAdded: false),
    ExpenseCategory(
        title: "Sightseeing",
        description: "Visiting landmarks, historical sites, etc.",
        imagePath: "sightseeing.png",
        expenseIsAdded: false),
  ];

  final TextEditingController _customExpenseCategoryName = TextEditingController();
  final TextEditingController _customExpenseCategoryDescription =
      TextEditingController();
  String _searchExpenseQuery = "";

  void reset() {
    setState(() {
      for (var category in _expenseCategories) {
        category.expenseIsAdded = false;
      }
      widget.budget.expenseList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ExpenseCategory> filteredExpenseCategories = _expenseCategories
        .where((expense) => expense.title
            .toLowerCase()
            .contains(_searchExpenseQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Highlight what best fits your travel experience',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Find what interests you most',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
              onChanged: (query) {
                setState(() {
                  _searchExpenseQuery = query;
                });
              },
            ),
            const SizedBox(height: 20),
            Column(
              children: filteredExpenseCategories.map((expenseCategory) {
                bool isSelected = widget.budget.expenseList.any((expense) =>
                    expense.title.toLowerCase() ==
                    expenseCategory.title.toLowerCase());

                return _buildCategoryItem(
                  imagePath: 'assets/${expenseCategory.imagePath}',
                  title: expenseCategory.title,
                  subtitle: expenseCategory.description,
                  isSelected: isSelected,
                  onChanged: (value) {
                    setState(() {
                      if (value ?? false) {
                        // Add to expenseList
                        if (!widget.budget.expenseList.any((expense) =>
                            expense.title.toLowerCase() ==
                            expenseCategory.title.toLowerCase())) {
                          widget.budget.addNewExpense(
                            ExpenseCategorySelected(
                              amount: 0.0,
                              title: expenseCategory.title,
                              description: expenseCategory.description,
                              imagePath: 'assets/${expenseCategory.imagePath}',
                              expenseIsAdded: true,
                              showExpenseDropdown: false,
                            ),
                          );
                        }
                      } else {
                        // Remove from expenseList
                        widget.budget.removeExpense(expenseCategory.title);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            // TextField(controller: _custom,),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showCustomExpenseDialog(context);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Add Custom Expense Category',
                        style: TextStyle(color: AppColors.primaryColor)),
                    SizedBox(width: 8),
                    Icon(Icons.add, color: AppColors.primaryColor),
                  ],
                )),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    reset();
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement save functionality
                    print('Selected Expenses: ${widget.budget.expenseList}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF930BFF),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem({
    required String imagePath,
    required String title,
    required String subtitle,
    required bool isSelected,
    required ValueChanged<bool?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 40,
            height: 40,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Checkbox(
            value: isSelected,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  void _showCustomExpenseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // bool expenseI = _budget.tripIsToMultipleDestinations;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.white,
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              title: const Center(
                child: Text(
                  'Custom Expense Category',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _customExpenseCategoryName,
                    decoration: const InputDecoration(
                      labelText: 'Expense Category Name',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _customExpenseCategoryDescription,
                    decoration: const InputDecoration(
                      labelText: 'Expense Category Description',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!widget.budget.expenseList.any((expense) =>
                        expense.title.toLowerCase() ==
                        _customExpenseCategoryName.text.toLowerCase())) {
                      widget.budget.addNewExpense(
                        ExpenseCategorySelected(
                          amount: 0.0,
                          title: _customExpenseCategoryName.text,
                          description: _customExpenseCategoryDescription.text,
                          imagePath: 'assets/markicon.png',
                          expenseIsAdded: true,
                          showExpenseDropdown: false,
                        ),
                      );
                      _expenseCategories.add(ExpenseCategory(
                          title: _customExpenseCategoryName.text,
                          description: _customExpenseCategoryDescription.text,
                          imagePath: "markicon.png",
                          expenseIsAdded: true));
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child:
                      const Text("Add", style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
