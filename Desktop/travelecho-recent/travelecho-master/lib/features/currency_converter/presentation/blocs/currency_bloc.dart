import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/features/currency_converter/domain/usecases/convert_currency_usecase.dart';
import 'package:travelecho/service_locator.dart';
import 'currency_event.dart';
import 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(CurrencyInitial()) {
    on<ConvertRequested>((event, emit) async {
      emit(CurrencyLoading());

      final result = await sl<ConvertCurrency>()
          .execute(event.base, event.target, event.amount);
      print("|Yeah");
      result.fold(
        (failure) => emit(CurrencyError(failure)),
        (convertedRate) => emit(CurrencyLoaded(convertedRate)),
      );
      print("|Yeah2");
    });
    on<CurrencyListRequested>((event, emit) async {
      // Corrected event name
      emit(CurrencyLoading());

      final result = await sl<GetCurrencyList>().getList();

      result.fold(
        (failure) => emit(CurrencyError(failure)),
        (currencies) => emit(CurrencyListLoaded(currencies)),
      );
    });
  }
}
