import 'package:travelecho/features/budget/data/models/expense_model.dart';

class ExpenseData {
  //list of  all expenses
  List<ExpenseCategorySelected> expenseList = [];

  //get expense list
  List<ExpenseCategorySelected> getAllExpenseList() {
    return expenseList;
  }

  //add new expense
  void addNewExpense(ExpenseCategorySelected newExpense) {
    expenseList.add(newExpense);
    // notifyListeners()
  }

  // delete expense
  void deleteExpense(String title) {
    expenseList.removeWhere((expense) => expense.title == title);
    // notifyListeners()
    // expenseList.remove(expenseToBeDeleted);
  }
}
