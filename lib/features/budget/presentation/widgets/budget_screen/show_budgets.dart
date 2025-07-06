import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../budget_exports.dart';

class ShowBudgets extends StatefulWidget {
  final List<BudgetModel> budgetsData;
  final void Function(String) onSearch;

  const ShowBudgets({
    super.key,
    required this.budgetsData,
    required this.onSearch,
  });

  @override
  _ShowBudgetsState createState() => _ShowBudgetsState();
}

class _ShowBudgetsState extends State<ShowBudgets> {
  bool _showSearchBar = false;
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(value);
    });
  }

  void _toggleSearchBar() {
    setState(() {
      _showSearchBar = !_showSearchBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AnimatedPositioned(
        //   duration: Duration(milliseconds: 300),
        //   bottom: 0,
        //   left: 0,
        //   right: 0,
        //   child: Container(
        //     color: Colors.white,
        //     padding: const EdgeInsets.only(bottom: 16.0),
        //     child: TextField(
        //       controller: _searchController,
        //       onChanged: _onSearchChanged,

        //       decoration: InputDecoration(
        //         hintText: 'Search budgets...',
        //         prefixIcon: const Icon(
        //           Icons.search,
        //           color: AppColors.defaultColor400,
        //           size: 20,
        //         ),
        //         filled: true,
        //         fillColor: AppColors.primaryColor100,
        //         suffixIcon:
        //             _searchController.text.isNotEmpty
        //                 ? IconButton(
        //                   icon: const Icon(
        //                     LineIcons.times,
        //                     color: AppColors.defaultColor400,
        //                     size: 20,
        //                   ),
        //                   onPressed: () {
        //                     _searchController.clear();
        //                     widget.onSearch('');
        //                   },
        //                 )
        //                 : null,

        //         contentPadding: const EdgeInsets.symmetric(
        //           horizontal: 10,
        //           vertical: 0,
        //         ),
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(30),
        //           borderSide: BorderSide.none,
        //         ),
        //         enabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(30),
        //           borderSide: BorderSide.none,
        //         ),
        //         focusedBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(30),
        //           borderSide: BorderSide.none,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        const Text(
          "Budget Overview",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // if (_showSearchBar)
        WidgetsSpacer.verticalSpacer20,
        Column(
          spacing: 10,
          children:
              widget.budgetsData.map((budget) {
                return BlocBuilder<CurrencyBloc, CurrencyState>(
                  builder: (context, state) {
                    return BlocProvider.value(
                      value: sl<BudgetBloc>(),
                      child: BuildBudget(
                        budget: budget,
                        mergedCurrencies:
                            state is MergedCurrencyListLoaded
                                ? state.currencies
                                : [],
                      ),
                    );
                  },
                );
              }).toList(),
        ),
        WidgetsSpacer.verticalSpacer20,
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
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
                      return NewBudgetPage(
                        mergedCurrencyList:
                            state is MergedCurrencyListLoaded
                                ? state.currencies
                                : [],
                      );
                    },
                  ),
                ),
              );
              // Add your logic here
            },

            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Add New Budget',
                  style: TextStyle(
                    fontSize: FontSize.size16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
