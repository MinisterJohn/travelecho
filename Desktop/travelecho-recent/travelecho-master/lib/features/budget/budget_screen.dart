import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/features/budget/addcategories.dart';
import 'package:travelecho/features/budget/data/budget_data.dart';
import 'package:travelecho/features/budget/data/models/budget_model.dart';
import 'package:travelecho/features/budget/setbudget.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class BudgetController {
  String name;
  bool tripIsToMultipleDestinations;

  BudgetController(
      {required this.name, this.tripIsToMultipleDestinations = false});
}

class _BudgetScreenState extends State<BudgetScreen> {
  final TextEditingController _budgetNameController = TextEditingController();
  final BudgetController _budget =
      BudgetController(name: "", tripIsToMultipleDestinations: false);
  Budget _selectedBudget = Budget(amount: 0.0, name: "");

  @override
  void initState() {
    super.initState();
    _budgetNameController.text = _budget.name;
    _budgetNameController.addListener(() {
      setState(() {
        _budget.name = _budgetNameController.text; // Update the Budget name
      });
    });
  }

  @override
  void dispose() {
    _budgetNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<BudgetsData>(
          builder: (context, value, child) => Container(
            child: value.getAllBudgets().isNotEmpty
                ? _showBudgets(value)
                : _showEmptyBudget(),
          ),
        ),
      ),
    );
  }

  Widget _showBudgets(BudgetsData budgetsData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Budget Overview",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Consumer<BudgetsData>(
          builder: (context, provider, child) {
            return Column(
              children: provider.getAllBudgets().map((budget) {
                return _buildBudget(budget: budget);
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 20),

        ElevatedButton(
            onPressed: () {
              _showNewBudgetDialog(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add New Budget', style: TextStyle(color: Colors.white)),
                SizedBox(width: 8),
                Icon(Icons.add, color: Colors.white),
              ],
            ))
        //         Positioned(
        //   bottom: 16, // Distance from the bottom of the screen
        //   left: 16, // Distance from the left of the screen
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       // Add your onPressed logic here
        //     },
        //     backgroundColor: AppColors.primaryColor,
        //     child: const Icon(
        //       Icons.add,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _showEmptyBudget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Set your Budget here',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
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
            'You can set your budget for your next trip\nand manage your finances.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              _showNewBudgetDialog(context);
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
                Text('Set your budget', style: TextStyle(color: Colors.white)),
                SizedBox(width: 8),
                Icon(Icons.add, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _createBudget() {
    Budget newBudget = Budget(
      name: _budget.name,
      amount: 0.0,
      isForMultipleDestinations: _budget.tripIsToMultipleDestinations,
    );
    _selectedBudget = newBudget;
    Provider.of<BudgetsData>(context, listen: false).addNewBudget(newBudget);
  }

  void _showNewBudgetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool dialogIsChecked = _budget.tripIsToMultipleDestinations;

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
                  'New Budget',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _budgetNameController,
                    decoration: const InputDecoration(
                      labelText: 'Budget Name',
                      border: OutlineInputBorder(),
                      helperText: "e.g. Trip to the United States for tourism",
                      helperStyle: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: dialogIsChecked,
                        onChanged: (bool? value) {
                          setDialogState(() {
                            dialogIsChecked = value ?? false;
                          });
                        },
                        activeColor: AppColors.primaryColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          setDialogState(() {
                            dialogIsChecked = !dialogIsChecked;
                          });
                        },
                        child: const Text(
                          'Budget for multiple destinations \nin a trip',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _createBudget();
                    Navigator.pop(context);
                    _budgetNameController.clear();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetBudgetScreen(),
                        settings: RouteSettings(arguments: _selectedBudget),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Create Budget",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildBudget({required Budget budget}) {
    // ignore: avoid_unnecessary_containers
    return Row(
      children: [
        const Icon(Icons.account_balance_wallet_outlined,
            size: 40, weight: 0.5, grade: 1),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(budget.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 5),
              Text(
                "${budget.amount} Expenses",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, weight: 1, grade: 1),
          onPressed: () {
            _selectedBudget = budget;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SetBudgetScreen(),
                settings: RouteSettings(arguments: _selectedBudget),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
