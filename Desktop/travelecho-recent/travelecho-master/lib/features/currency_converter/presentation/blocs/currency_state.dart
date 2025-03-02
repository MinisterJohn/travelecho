// part of "currency_bloc.dart";


abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List convertedRate;
  
  CurrencyLoaded(this.convertedRate);
  
}

class CurrencyListLoaded extends CurrencyState {
  final List<String> currencies;
  CurrencyListLoaded(this.currencies);
}

class CurrencyError extends CurrencyState {
  final String message;
  CurrencyError(this.message);
}
