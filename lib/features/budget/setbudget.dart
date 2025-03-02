import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/features/budget/data/models/budget_model.dart';
import 'package:travelecho/features/budget/data/models/expense_model.dart';
import 'addcategories.dart';
import 'savebudget.dart';

class SetBudgetScreen extends StatefulWidget {
  const SetBudgetScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SetBudgetScreenState createState() => _SetBudgetScreenState();
}

class _SetBudgetScreenState extends State<SetBudgetScreen> {
  late Budget _budget;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the Budget object passed as arguments
    final Budget passedBudget =
        ModalRoute.of(context)!.settings.arguments as Budget;
    setState(() {
      _budget =
          passedBudget; // Store the passed Budget object in a local variable
    });
  }

  final TextEditingController _budgetAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8), // Padding inside the circle
              decoration: const BoxDecoration(
                color: Color.fromRGBO(248, 239, 255, 1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LineIcons.arrowCircleLeft,
                color: Colors.black,
                size: 20, // Adjusted icon size for better fit
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            _budget.name,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Segoe UI',
                overflow: TextOverflow.ellipsis),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Set a budget for your trip!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _budgetAmountController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your budget amount',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _budget.amount = double.parse(value);
                  },
                ),
                const SizedBox(height: 5),
                const Text(
                  'Plan your expenses for the trip.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Expense Categories',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // TextButton(
                //   onPressed: () {
                //     _showModal(context);

                //   },
                //   child: const Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           Text(
                //             'Add expense category',
                //             style: TextStyle(
                //               color: Colors.black,
                //               fontSize: 16,
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(width: 8),
                //       Icon(Icons.add, color: Colors.black),
                //     ],
                //   ),
                // ),
                _budget.expenseList.isNotEmpty
                    ? Column(
                        children: _budget.getExpenses().map((expense) {
                          return _buildCategoryDropdown(
                            expense: expense,
                            onTap: () {
                              setState(() {
                                expense.showExpenseDropdown =
                                    !expense.showExpenseDropdown;
                              });
                            },
                          );
                        }).toList(),
                      )
                    : _showEmptyExpense(),

                // SizedBox(height: 25),

                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Implement reset functionality
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
                        // Navigate to the SaveBudgetScreen when the Save button is clicked
                        print(_budget.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SaveBudgetScreen()),
                        );
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
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: _budget.expenseList.isNotEmpty
            ? FloatingActionButton(
                backgroundColor: AppColors.primaryColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                onPressed: () {
                  _showModal(context);
                },
                child: const Icon(Icons.add, color: Colors.white),
              )
            : null);
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow full-screen height if needed
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand:
              false, // Keeps the modal from snapping to full height automatically
          initialChildSize: 0.75, // Default height as 75% of the screen
          minChildSize: 0.5, // Minimum height when dragged down
          maxChildSize: 0.95, // Maximum height when dragged up
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: AddCategoriesScreen(
                budget: _budget,
              ),
            );
          },
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildCategoryDropdown({
    required ExpenseCategorySelected expense,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    expense.imagePath,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expense.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        expense.description,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    _budget.removeExpense(expense.title);
                  });
                },
                icon: const Icon(
                  Icons.delete_outlined,
                  color: Colors.red,
                ))
          ],
        ),
        // SizedBox(height: 5),

        if (expense.showExpenseDropdown) ...[
          const SizedBox(height: 5),
          const Text(
            'Set Your Budget',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Enter your budget',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (amount) {
              expense.amount = double.parse(amount);
            },
          ),
          const SizedBox(height: 5),
          Text(
            'Plan your expenses for ${expense.title}',
            style: const TextStyle(
                fontSize: 10, color: Color.fromRGBO(0, 0, 0, .4)),
          ),
          const SizedBox(height: 5),
        ],
        const SizedBox(height: 5),

        const Divider(
          height: 3,
          color: Color.fromRGBO(0, 0, 0, .2),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _showEmptyExpense() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            'assets/NoResultFound.png',
            height: 100,
          ),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'Nothing to see here!',
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'You can add your expense categories for your next trip\nand manage your finances.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // _showNewBudgetDialog(context);
              _showModal(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF930BFF),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add Expense Category',
                    style: TextStyle(color: Colors.white)),
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
