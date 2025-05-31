import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../currency_converter_exports.dart';

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

  List<String> _currencies = []; // Initialize as empty

  bool _isLoading = false; // Add a loading state

  @override
  void initState() {
    super.initState();
    // Load the initial currency list
    context.read<CurrencyBloc>().add(CurrencyListRequested());
  }

  void _convertCurrency() async {
    setState(() {
      _isLoading = true;
      _convertedAmount = [];
    });

    double amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount <= 0) {
      DisplayMessage.errorMessage("Please enter a valid amount", context);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    context.read<CurrencyBloc>().add(ConvertRequested(
          base: _fromCurrency.split(" - ")[0].toLowerCase(),
          target: _toCurrency.split(" - ")[0].toLowerCase(),
          amount: amount,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Currency Converter", context),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CurrencyBloc>().add(CurrencyListRequested());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<CurrencyBloc, CurrencyState>(
              builder: (context, state) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (state is CurrencyError && _isLoading) {
                    setState(() {
                      _isLoading = false;
                    });
                    DisplayMessage.errorMessage(state.message, context);
                  } else if (state is CurrencyLoaded && _isLoading) {
                    setState(() {
                      _isLoading = false;
                      _convertedAmount = state.convertedRate;
                    });
                  }
                });

                if (state is CurrencyListLoaded) {
                  _currencies = state.currencies; // Update the currency list
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Amount",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Amount",
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "From",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _convertCurrency,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              "Convert",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                    ),
                    if (_convertedAmount.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(top: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1, color: AppColors.defaultColor100),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Converted Amount:",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.defaultColor400),
                            ),
                            const SizedBox(height: 8),
                            Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                  text:
                                      "${double.parse(_convertedAmount[1].toStringAsFixed(2)).toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => "${match[1]},")} ",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                    text: _toCurrency.split(" - ")[0],
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ))
                              ]),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "1 $_fromCurrency = ${double.parse(_convertedAmount[0].toStringAsFixed(2)).toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => "${match[1]},")} ${_toCurrency.split(" - ")[0]}",
                              style: const TextStyle(
                                fontSize: 16,
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
      ),
    );
  }
}
