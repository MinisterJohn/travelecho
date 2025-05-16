// import 'package:shared_preferences/shared_preferences.dart';
// import '../../budget_exports.dart';

// class BudgetLocalSource {
//   final SharedPreferences _prefs;
//   static const String _budgetsKey = 'budgets';

//   BudgetLocalSource({required SharedPreferences prefs}) : _prefs = prefs;

//   Future<void> saveBudget(Budget budget) async {
//     final budgets = await getBudgets();
//     final index = budgets.indexWhere((b) => b.id == budget.id);

//     if (index != -1) {
//       budgets[index] = budget;
//     } else {
//       budgets.add(budget);
//     }

//     await saveBudgets(budgets);
//   }

//   Future<void> saveBudgets(List<Budget> budgets) async {
//     final jsonList = budgets.map((budget) => budget.toJson()).toList();
//     await _prefs.setString(_budgetsKey, jsonEncode(jsonList));
//   }

//   Future<List<Budget>> getBudgets() async {
//     final jsonString = _prefs.getString(_budgetsKey);
//     if (jsonString == null) return [];

//     final List<dynamic> jsonList = jsonDecode(jsonString);
//     return jsonList.map((json) => Budget.fromJson(json)).toList();
//   }

//   Future<Budget> getBudgetById(String budgetId) async {
//     final budgets = await getBudgets();
//     final budget = budgets.firstWhere(
//       (b) => b.id == budgetId,
//       orElse: () => throw Exception('Budget not found'),
//     );
//     return budget;
//   }

//   Future<void> updateBudget(Budget budget) async {
//     await saveBudget(budget);
//   }

//   Future<void> deleteBudget(String budgetId) async {
//     final budgets = await getBudgets();
//     budgets.removeWhere((b) => b.id == budgetId);
//     await saveBudgets(budgets);
//   }
// }
