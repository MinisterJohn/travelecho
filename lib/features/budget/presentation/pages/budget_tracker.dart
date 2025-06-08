import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../budget_exports.dart';

class BudgetTracker extends StatefulWidget {
  const BudgetTracker({super.key});

  @override
  _BudgetTrackerState createState() => _BudgetTrackerState();
}

class _BudgetTrackerState extends State<BudgetTracker> {
  String currentBudgetTool = "Budget Overview";
  List<CurrencyInfo> _mergedCurrencies = [];

  @override
  void initState() {
    super.initState();
    context.read<CurrencyBloc>().add(
      MergedCurrencyListRequested(context: context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar('Travel Budget', context),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              context.read<BudgetBloc>().add(GetAllBudgetsEvent());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row with Budget Overview and Expense Tracker images
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _budgetTools(LineIcons.piggyBank, "Budget Overview"),
                        const SizedBox(width: 8.0),
                        _budgetTools(
                          LineIcons.clipboardList,
                          "Expense Tracker",
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // currentBudgetTool == "Budget Overview"
                    MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: sl<BudgetBloc>()),
                        BlocProvider.value(value: sl<CurrencyBloc>()),
                      ],
                      child: BudgetScreen(),
                    ),
                    // : Container()
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<BudgetBloc, BudgetState>(
            builder: (context, budgetState) {
              if (budgetState is BudgetLoading) {
                return Positioned(
                  top: 4,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Loading budgets...',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<BudgetBloc, BudgetState>(
            builder: (context, budgetState) {
              if (budgetState is BudgetError) {
                return Positioned(
                  top: 4,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: Icon(Icons.refresh, color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Refresh to load budgets',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<CurrencyBloc, CurrencyState>(
            builder: (context, state) {
              if (state is MergedCurrencyListLoaded) {
                _mergedCurrencies = state.currencies;
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),

      // floatingActionButton: Positioned(
      //   bottom: 16, // Distance from the bottom of the screen
      //   left: 16, // Distance from the left of the screen
      //   child: FloatingActionButton(
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(50)), // Rounded corners
      //     ),
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
    );
  }

  // Widget for Budget Overview and Expense Tracker images
  Widget _budgetTools(IconData icon, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentBudgetTool = label;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border:
                currentBudgetTool != label
                    ? Border.all(color: const Color.fromRGBO(0, 0, 0, 0.1))
                    : null,
            color:
                currentBudgetTool == label
                    ? AppColors.primaryColor
                    : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color:
                      currentBudgetTool == label ? Colors.white : Colors.black,
                  size: 50,
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  style: TextStyle(
                    color:
                        currentBudgetTool == label
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
