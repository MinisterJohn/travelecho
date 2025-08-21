import 'package:flutter_bloc/flutter_bloc.dart';
import '../../budget_exports.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final CreateBudgetUseCase createBudgetUseCase = sl<CreateBudgetUseCase>();
  final UpdateBudgetUseCase updateBudgetUseCase = sl<UpdateBudgetUseCase>();
  final DeleteBudgetUseCase deleteBudgetUseCase = sl<DeleteBudgetUseCase>();

  final CreateExpenseUseCase createExpenseUseCase = sl<CreateExpenseUseCase>();
  final UpdateExpenseUseCase updateExpenseUseCase = sl<UpdateExpenseUseCase>();
  final DeleteExpenseUseCase deleteExpenseUseCase = sl<DeleteExpenseUseCase>();
  final UploadExpenseReceiptUseCase uploadExpenseReceiptUseCase =
      sl<UploadExpenseReceiptUseCase>();

  final GetAllBudgetsUseCase getAllBudgetsUseCase = sl<GetAllBudgetsUseCase>();
  final GetBudgetWithExpensesUseCase getBudgetWithExpensesUseCase =
      sl<GetBudgetWithExpensesUseCase>();
  final GetExpensesUseCase getExpensesUseCase = sl<GetExpensesUseCase>();

  BudgetState? _previousState;

  void saveCurrentState() {
    _previousState = state;
  }

  void restorePreviousState() {
    if (_previousState != null) {
      emit(_previousState!);
    }
  }

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

    on<DeleteBudgetEvent>((event, emit) async {
      emit(BudgetLoading());
      final result = await deleteBudgetUseCase(event.id);
      result.fold(
        (error) => emit(BudgetError(error)),
        (_) => add(GetAllBudgetsEvent()),
      );
    });

    on<CreateExpenseEvent>((event, emit) async {
      emit(BudgetLoading());
      final result = await createExpenseUseCase(event.expense);
      result.fold((error) => emit(BudgetError(error)), (expenseModel) async {
        if (event.expense.receiptFilePath != null) {
          final uploadResult = await uploadExpenseReceiptUseCase(
            expenseModel.id,
            event.expense.receiptFilePath!,
          );
          uploadResult.fold((uploadError) => emit(BudgetError(uploadError)), (
            receiptUrl,
          ) {
            emit(ExpenseSaved()); // ✅ success even after upload
            add(GetBudgetWithExpensesEvent(event.expense.budgetId));
          });
        } else {
          emit(ExpenseSaved()); // ✅ success without upload
          add(GetBudgetWithExpensesEvent(event.expense.budgetId));
        }
      });
    });

    on<UpdateExpenseEvent>((event, emit) async {
      emit(BudgetLoading());
      final result = await updateExpenseUseCase(event.id, event.expense);
      result.fold((error) => emit(BudgetError(error)), (expenseModel) async {
        if (event.expense.receiptFilePath != null) {
          final uploadResult = await uploadExpenseReceiptUseCase(
            expenseModel.id,
            event.expense.receiptFilePath!,
          );
          print("uploadResult $uploadResult");

          uploadResult.fold(
            (uploadError) {
              // Handle upload error
            },
            (receiptUrl) {
              // Handle success, maybe update the expense with the receipt URL if needed
              add(GetBudgetWithExpensesEvent(event.expense.budgetId));
            },
          );
        }
      });
    });

    on<DeleteExpenseEvent>((event, emit) async {
      emit(BudgetLoading());
      print("Deleting expense with ID: ${event.expenseId}");
      final result = await deleteExpenseUseCase(event.expenseId);
      result.fold(
        (error) => emit(BudgetError(error)),
        (_) => add(GetBudgetWithExpensesEvent(event.budgetId)),
      );
    });

    on<UploadExpenseReceiptEvent>((event, emit) async {
      emit(BudgetLoading());
      print("Deleting expense with ID: ${event.expenseId}");
      final result = await uploadExpenseReceiptUseCase(
        event.expenseId,
        event.filePath,
      );
      result.fold(
        (error) => emit(BudgetError(error)),
        (_) => add(GetExpenseByIdEvent(event.expenseId)),
      );
    });

    on<GetAllBudgetsEvent>((event, emit) async {
      try {
        final currentState = state;
        emit(BudgetLoading());

        final result = await getAllBudgetsUseCase(
          sort: event.sort,
          limit: event.limit,
          skip: event.skip,
        );

        result.fold(
          (error) {
            print('Error fetching budgets: $error');
            emit(BudgetError(error));
          },
          (budgets) {
            final currentBudgets =
                currentState is BudgetsLoaded
                    ? currentState.budgets
                    : <BudgetModel>[];

            final allBudgets =
                event.append ? [...currentBudgets, ...budgets] : budgets;

            final hasMore = budgets.length == event.limit;
            emit(
              BudgetsLoaded(
                budgets: allBudgets,
                hasMore: hasMore,
                currentPage: event.skip ~/ event.limit + 1,
                append: event.append,
              ),
            );
          },
        );
      } catch (e) {
        emit(BudgetError(e.toString()));
      }
    });

    on<GetAllExpensesEvent>((event, emit) async {
      emit(BudgetLoading());
      final result = await getExpensesUseCase();
      result.fold(
        (error) => emit(BudgetError(error)),
        (expenses) => emit(ExpensesLoaded(expenses)),
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
