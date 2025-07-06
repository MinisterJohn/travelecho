import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../budget_exports.dart';

class ViewBudgetScreen extends StatefulWidget {
  final BudgetModel budget;
  final CurrencyInfo currencyInfo;

  const ViewBudgetScreen({
    super.key,
    required this.budget,
    required this.currencyInfo,
  });

  @override
  _ViewBudgetScreenState createState() => _ViewBudgetScreenState();
}

class _ViewBudgetScreenState extends State<ViewBudgetScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild when tab changes
    });
    context.read<BudgetBloc>().add(
      GetBudgetWithExpensesEvent(widget.budget.id),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(
        widget.budget.name.isNotEmpty ? widget.budget.name : "Budget Overview",
        context,
        actions: [
          BlocBuilder<BudgetBloc, BudgetState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(
                  LineIcons.infoCircle,
                  size: 20,
                  color: AppColors.defaultColor400,
                ),
                onPressed: () {
                  print("Budget Info Icon Pressed");
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return BudgetInfoBottomSheet(
                        budget:
                            state is SingleBudgetLoaded
                                ? state.budget
                                : widget.budget,
                        currencyInfo: widget.currencyInfo,
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          if (state is SingleBudgetLoaded) {
            final updatedBudget = state.budget;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAmountRow(context, updatedBudget),
                WidgetsSpacer.verticalSpacer20,

                TabBar(
                  isScrollable: false, // ⬅️ Allows custom tab width
                  indicatorColor: Colors.transparent,
                  dividerHeight: 0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: EdgeInsets.zero,
                  controller: _tabController,
                  tabs: [
                    _buildTab(context, 0, LineIcons.moneyBill, 'Expenses'),
                    _buildTab(context, 1, LineIcons.pieChart, 'Categories'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildExpensesTab(context, updatedBudget),
                      _buildCategoriesTab(context, updatedBudget),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is BudgetLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("Error loading budget."));
          }
        },
      ),
    );
  }

  Widget _buildAmountRow(BuildContext context, BudgetModel updatedBudget) {
    return AmountRow(
      updatedBudget: updatedBudget,
      currencyInfo: widget.currencyInfo,
    );
  }

  Widget _buildExpensesTab(BuildContext context, BudgetModel updatedBudget) {
    return ExpensesTab(
      updatedBudget: updatedBudget,
      currencyInfo: widget.currencyInfo,
    );
  }

  Widget _buildCategoriesTab(BuildContext context, BudgetModel updatedBudget) {
    return CategoriesTab(
      updatedBudget: updatedBudget,
      currencyInfo: widget.currencyInfo,
    );
  }

  Widget _buildTab(
    BuildContext context,
    int index,
    IconData icon,
    String label,
  ) {
    final bool isSelected = _tabController.index == index;

    return Tab(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Container(
          constraints: const BoxConstraints(minWidth: double.infinity / 2),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border:
                isSelected
                    ? null
                    : Border.all(color: AppColors.defaultColor400),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
