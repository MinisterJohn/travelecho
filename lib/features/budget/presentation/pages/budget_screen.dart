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

  BudgetController({required this.name});
}

class _BudgetScreenState extends State<BudgetScreen> {
  final TextEditingController _budgetNameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _currentSearch;
  List<BudgetModel> _allBudgets = [];
  bool _restored = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_restored) {
      context.read<BudgetBloc>().restorePreviousState();
      _restored = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchAllBudgets();
  }

  @override
  void dispose() {
    _budgetNameController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_currentSearch == null) {
        _fetchAllBudgets(append: true);
      }
    }
  }

  void _onSearch(String value) {
    setState(() {
      _currentSearch = value.isEmpty ? null : value;
      // _allBudgets = [];
    });
    _fetchAllBudgets();
  }

  void _fetchAllBudgets({bool append = false}) {
    if (append && (_allBudgets.length % 10) != 0) {
      return;
    }
    context.read<BudgetBloc>().add(
      GetAllBudgetsEvent(
        append: append,
        sort: _currentSearch,
        skip: append ? _allBudgets.length : 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocListener<BudgetBloc, BudgetState>(
        listener: (context, state) {
          if (state is BudgetLoading) {
            // Show loading indicator
          } else if (state is BudgetsLoaded) {
            setState(() {
              if (state.append) {
                _allBudgets.addAll(state.budgets);
              } else {
                _allBudgets = state.budgets;
              }
            });
          } else if (state is BudgetError) {
            // Show error message
            Text(state.message);
          } else {
            Text("WHatt's happening");
          }
        },
        child: BlocBuilder<BudgetBloc, BudgetState>(
          builder: (context, state) {
            if (state is BudgetLoading && _allBudgets.isEmpty) {
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
            } else if (state is BudgetsLoaded || _allBudgets.isNotEmpty) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: sl<BudgetBloc>()),
                  BlocProvider.value(value: sl<CurrencyBloc>()),
                  BlocProvider.value(value: sl<LevelBloc>(),)
                ],
                child: Container(
                  child:
                      (state is BudgetsLoaded && state.budgets.isNotEmpty ||
                              _allBudgets.isNotEmpty)
                          ? ShowBudgets(
                            budgetsData:
                                state is BudgetsLoaded
                                    ? state.budgets
                                    : _allBudgets,
                            onSearch: _onSearch,
                          )
                          : ShowEmptyBudget(
                            onAddBudget:
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
      ),
    );
  }
}
