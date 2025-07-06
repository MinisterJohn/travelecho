import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../budget_exports.dart';

class ExpenseScreen extends StatefulWidget {
  final BudgetModel budget;
  final CurrencyInfo currency;

  const ExpenseScreen({
    super.key,
    required this.budget,
    required this.currency,
  });

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final TextEditingController _budgetNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch all budgets when the screen is initialized
    print("Getting expenses");
    context.read<BudgetBloc>().add(
      GetBudgetWithExpensesEvent(widget.budget.id),
    );

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
    final budgetBloc = context.read<BudgetBloc>();
    return Scaffold(
      appBar: setAppBar("Track Expense", context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigator.push(
            context,
            MultiBlocProvider(
              providers: [
                BlocProvider.value(value: sl<BudgetBloc>()),
                BlocProvider.value(value: sl<CurrencyBloc>()),
              ],
              child: BlocBuilder<CurrencyBloc, CurrencyState>(
                builder: (context, state) {
                  return AddExpensePage(
                    budget: widget.budget,
                    mergedCurrencies:
                        state is MergedCurrencyListLoaded
                            ? state.currencies
                            : [],
                  );
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.budget.name} Expenses",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Track your spending",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              WidgetsSpacer.verticalSpacer20,
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Budget",
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.defaultColor400,
                          ),
                        ),
                        Text(
                          "${widget.currency.symbol.isNotEmpty ? widget.currency.symbol : widget.budget.currency} ${widget.budget.plannedAmount.toString()}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Spent Amount",
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.defaultColor400,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        BlocBuilder<BudgetBloc, BudgetState>(
                          builder: (context, state) {
                            return Text(
                              "${widget.currency.symbol.isNotEmpty ? widget.currency.symbol : widget.budget.currency} ${state is SingleBudgetLoaded ? BudgetUtils.calculateSpentAmount(state.budget.expenses) : 0.0}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              WidgetsSpacer.verticalSpacer20,
              BlocBuilder<BudgetBloc, BudgetState>(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                  } else if (state is SingleBudgetLoaded ||
                      state is ExpensesLoaded) {
                    final List<ExpenseModel> expensesData =
                        (state is SingleBudgetLoaded
                                ? state.budget.expenses
                                : state is ExpensesLoaded
                                ? state.expenses
                                : [])
                            as List<ExpenseModel>;
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: sl<BudgetBloc>()),
                        BlocProvider.value(value: sl<CurrencyBloc>()),
                      ],
                      child: Container(
                        child:
                            expensesData.isNotEmpty
                                ? ShowExpenses(
                                  expensesData: expensesData,
                                  budget: widget.budget,
                                  currency: widget.currency,
                                )
                                : ShowEmptyExpense(
                                  budget: widget.budget,
                                  onAddExpense:
                                      () => AppNavigator.push(
                                        context,
                                        MultiBlocProvider(
                                          providers: [
                                            BlocProvider.value(
                                              value: sl<CurrencyBloc>(),
                                            ),
                                            BlocProvider.value(
                                              value: sl<BudgetBloc>(),
                                            ),
                                          ],
                                          child: BlocBuilder<
                                            CurrencyBloc,
                                            CurrencyState
                                          >(
                                            builder: (context, state) {
                                              return AddExpensePage(
                                                budget: widget.budget,
                                                mergedCurrencies:
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
            ],
          ),
        ),
      ),
    );
  }
}
