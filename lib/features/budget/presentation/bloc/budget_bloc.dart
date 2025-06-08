import 'package:flutter_bloc/flutter_bloc.dart';
import '../../budget_exports.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final GetAllBudgetsUseCase getAllBudgetsUseCase = sl<GetAllBudgetsUseCase>();
  final CreateBudgetUseCase createBudgetUseCase = sl<CreateBudgetUseCase>();
  final UpdateBudgetUseCase updateBudgetUseCase = sl<UpdateBudgetUseCase>();
  final DeleteBudgetUseCase deleteBudgetUseCase = sl<DeleteBudgetUseCase>();
  final GetBudgetWithExpensesUseCase getBudgetWithExpensesUseCase = sl<GetBudgetWithExpensesUseCase>();
  final GetExpensesUseCase getExpensesUseCase = sl<GetExpensesUseCase>();
  final CreateExpenseUseCase createExpenseUseCase = sl<CreateExpenseUseCase>();
  final UpdateExpenseUseCase updateExpenseUseCase = sl<UpdateExpenseUseCase>();
  final DeleteExpenseUseCase deleteExpenseUseCase = sl<DeleteExpenseUseCase>();

  BudgetBloc() : super(BudgetInitial()) {
    on<CreateBudgetEvent>((event, emit) async {
      emit(BudgetLoading());
      final result = await createBudgetUseCase(event.budget);
      print("Budget created: $result");
      result.fold((error) => emit(BudgetError(error)), (budget) {
        // final Map<String, dynamic> budgetData = budget['budget'];
        add(GetAllBudgetsEvent());
      });
    });

    on<UpdateBudgetEvent>((event, emit) async {
      emit(BudgetLoading());
      final result = await updateBudgetUseCase(event.id, event.budget);
      result.fold(
        (error) => emit(BudgetError(error)),
        (_) => add(GetAllBudgetsEvent()),
      );
    });

    on<GetAllBudgetsEvent>((event, emit) async {
      emit(BudgetLoading());
      final result = await getAllBudgetsUseCase();
      print("Budgets fetched: $result");
      result.fold(
        (error) => emit(BudgetError(error)),
        (budgets) => emit(BudgetsLoaded(budgets)),
      );
    });

    on<DeleteBudgetEvent>((event, emit) async {
      emit(BudgetLoading());
      final result = await deleteBudgetUseCase(event.id);
      result.fold(
        (error) => emit(BudgetError(error)),
        (_) => add(GetAllBudgetsEvent()),
      );
    });

    on<GetAllExpensesEvent>((event, emit) async {
      emit(BudgetLoading());
      final result = await getExpensesUseCase();
      result.fold(
        (error) => emit(BudgetError(error)),
        (expenses) => emit(ExpensesLoaded(expenses)),
      );
    });

    on<CreateExpenseEvent>((event, emit) async {
      emit(BudgetLoading());
      final result = await createExpenseUseCase(event.expense);
      result.fold(
        (error) => emit(BudgetError(error)),
        (_) => add(GetAllExpensesEvent()),
      );
    });

    on<UpdateExpenseEvent>((event, emit) async {
      emit(BudgetLoading());
      final result = await updateExpenseUseCase(event.id, event.expense);
      result.fold(
        (error) => emit(BudgetError(error)),
        (_) => add(GetAllExpensesEvent()),
      );
    });

    on<DeleteExpenseEvent>((event, emit) async {
      emit(BudgetLoading());
      final result = await deleteExpenseUseCase(event.expenseId);
      result.fold(
        (error) => emit(BudgetError(error)),
        (_) => add(GetAllExpensesEvent()),
      );
    });
   on<GetBudgetWithExpensesEvent>((event, emit) async {
      emit(BudgetLoading());
      final result = await getBudgetWithExpensesUseCase(event.id);
      result.fold(
        (error) => emit(BudgetError(error)),
        (budget) => emit(SingleBudgetLoaded(budget)),
      );
    });
  }

}
