import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../currency_converter_exports.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(CurrencyInitial()) {
    on<ConvertRequested>((event, emit) async {
      emit(CurrencyLoading());

      final result = await sl<ConvertCurrency>().execute(
        event.base,
        event.target,
        event.amount,
      );
      print("Yeah");
      result.fold(
        (failure) => emit(CurrencyError(failure)),
        (convertedRate) => emit(CurrencyLoaded(convertedRate)),
      );
      print("Yeah2");
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
    on<MergedCurrencyListRequested>((event, emit) async {
      // Corrected event name
      emit(CurrencyLoading());

      final result = await sl<GetCurrencyList>().getMergedList(event.context);

      result.fold(
        (failure) => emit(CurrencyError(failure)),
        (currencies) => emit(MergedCurrencyListLoaded(currencies)),
      );
    });
  }
}
