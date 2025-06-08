part of 'currency_bloc.dart';

abstract class CurrencyEvent {}

class ConvertRequested extends CurrencyEvent {
  final String base;
  final String target;
  final double amount;

  ConvertRequested({
    required this.base,
    required this.target,
    required this.amount,
  });
}

class CurrencyListRequested extends CurrencyEvent {}

class MergedCurrencyListRequested extends CurrencyEvent {
  BuildContext context;
  MergedCurrencyListRequested({required this.context});
}
