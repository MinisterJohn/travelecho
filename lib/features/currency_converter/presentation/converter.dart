import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/config/theme/colors.dart';

import 'package:travelecho/core/constants/appbar.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/features/currency_converter/presentation/blocs/currency_bloc.dart';
import 'package:travelecho/features/currency_converter/presentation/blocs/currency_event.dart';
import 'package:travelecho/features/currency_converter/presentation/blocs/currency_state.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = "USD - US Dollar";
  String _toCurrency = "USD - US Dollar";
  List _convertedAmount = [];

  List<String> _currencies = [
    "USD - US Dollar",
    "EUR - Euro",
    "GBP - British Pound",
    "NGN - Nigerian Naira",
  ];

  @override
  void initState() {
    super.initState();
    context
        .read<CurrencyBloc>()
        .add(CurrencyListRequested()); // Dispatch event to get currencies
  }

  void _convertCurrency() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;

    if (amount <= 0) return;
    print(_fromCurrency.split(" - ")[0].toLowerCase());

    context.read<CurrencyBloc>().add(ConvertRequested(
          base: _fromCurrency
              .split(" - ")[0]
              .toLowerCase(), // Extract currency code
          target: _toCurrency.split(" - ")[0].toLowerCase(),
          amount: amount,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Currency Converter", context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<CurrencyBloc, CurrencyState>(
            builder: (context, state) {
              print("Current State: $state");
              if (state is CurrencyLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is CurrencyListLoaded) {
                _currencies = state.currencies;
              }
              if (state is CurrencyLoaded) {
                print("Currency Loaded");
                _convertedAmount = state.convertedRate;
                print(state.convertedRate);
              }

              if (state is CurrencyError) {
                return Center(child: Text("Error: ${state.message}"));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Amount",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Amount",
                    ),
                    // onChanged: (value) {
                    //   _convertCurrency(); // Trigger conversion on amount change
                    // },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "From",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _fromCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _fromCurrency = newValue!;
                      });
                    },
                    items: _currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "To",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _toCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _toCurrency = newValue!;
                      });
                    },
                    items: _currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer16,
                  ElevatedButton(
                    onPressed: () {
                      _convertCurrency();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(
                      "Convert",
                      style: TextStyle(
                          color: AppColors.white, fontSize: FontSize.size16),
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer16,
                  if (_convertedAmount.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.transparent, // Transparent box background
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            width: 1, color: AppColors.defaultColor400),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Converted Amount:",
                            style: TextStyle(
                                fontSize: FontSize.size16,
                                color: AppColors.defaultColor400),
                          ),
                          WidgetsSpacer.verticalSpacer8,
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text:
                                    "${double.parse(_convertedAmount[1].toStringAsFixed(4))} ",
                                style: TextStyle(
                                  fontSize: FontSize.size24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                  text: _toCurrency.split(" - ")[0],
                                  style: TextStyle(
                                    fontSize: FontSize.size16,
                                  ))
                            ]),
                          ),
                          WidgetsSpacer.verticalSpacer8,
                          Text(
                            "1 $_fromCurrency = ${_convertedAmount[0]} ${_toCurrency.split(" - ")[0]}",
                            style: TextStyle(
                              fontSize: FontSize.size16,
                              color: AppColors.defaultColor400,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
