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
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("Fetching budgets again");
    context.read<BudgetBloc>().add(GetAllBudgetsEvent());
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
            return SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: 3, // Number of placeholders to show
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: SizedBox(
                      height: 80,

                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 10,
                                  width: 150,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 10,
                                  width: 100,
                                  color: Colors.grey[400],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is BudgetsLoaded) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: sl<BudgetBloc>()),
                BlocProvider.value(value: sl<CurrencyBloc>()),
              ],
              child: Container(
                child:
                    state.budgets.isNotEmpty
                        ? ShowBudgets(budgetsData: state.budgets)
                        : ShowEmptyBudget(
                          onAddBudget:
                              () => AppNavigator.push(
                                context,
                                MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(
                                      value: sl<CurrencyBloc>(),
                                    ),
                                    BlocProvider.value(value: sl<BudgetBloc>()),
                                  ],
                                  child: BlocBuilder<
                                    CurrencyBloc,
                                    CurrencyState
                                  >(
                                    builder: (context, state) {
                                      return NewBudgetPage(
                                        mergedCurrencyList:
                                            state is MergedCurrencyListLoaded
                                                ? state.currencies
                                                : [],
                                      );
                                    },
                                  ),
                                ),
                              ),
                        ),
              ),
            );
          } else if (state is BudgetError) {
            // DisplayMessage.errorMessage('Error: ${state.message}', context);
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
