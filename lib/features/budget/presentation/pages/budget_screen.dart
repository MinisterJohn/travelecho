import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../budget_exports.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class BudgetController {
  String name;
  bool tripIsToMultipleDestinations;

  BudgetController({
    required this.name,
    this.tripIsToMultipleDestinations = false,
  });
}

class _BudgetScreenState extends State<BudgetScreen> {
  final TextEditingController _budgetNameController = TextEditingController();
  final BudgetController _budget = BudgetController(
    name: "",
    tripIsToMultipleDestinations: false,
  );
  // Budget _selectedBudget = Budget(amount: 0.0, name: "");

  @override
  void initState() {
    super.initState();
    // Fetch all budgets when the screen is initialized
    print("Getting budgets");
    context.read<BudgetBloc>().add(GetAllBudgetsEvent());

    // _budgetNameController.text = _budget.name;
    // _budgetNameController.addListener(() {
    //   setState(() {
    //     _budget.name = _budgetNameController.text; // Update the Budget name
    //   });
    // });
  }

  @override
  void dispose() {
    _budgetNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          if (state is BudgetLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BudgetLoaded) {
            return Container(
              child:
                  state.budgets.isNotEmpty
                      ? BlocProvider.value(
                        value: sl<BudgetBloc>(),
                        child: ShowBudgets(budgetsData: state.budgets),
                      )
                      : ShowEmptyBudget(
                        onAddBudget: () => _showNewBudgetDialog(context),
                      ),
            );
          } else if (state is BudgetError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return ShowEmptyBudget(
            onAddBudget: () => _showNewBudgetDialog(context),
          );
        },
      ),
    );
  }

  void _createBudget() {
    // Budget newBudget = Budget(
    //   name: _budget.name,
    //   amount: 0.0,
    //   isForMultipleDestinations: _budget.tripIsToMultipleDestinations,
    // );
    // _selectedBudget = newBudget;
    // Provider.of<BudgetsData>(context, listen: false).addNewBudget(newBudget);
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
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
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
                        color: Colors.grey,
                      ),
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
                    context.read<BudgetBloc>().add(
                      CreateBudgetEvent(
                        BudgetParams(
                          name: _budget.name,
                          plannedAmount: 0.0,
                          // createdAt: DateTime.now(),
                        ),
                      ),
                    );
                    _budgetNameController.clear();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetBudgetScreen(),
                        // settings: RouteSettings(arguments: _selectedBudget),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Create Budget",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
