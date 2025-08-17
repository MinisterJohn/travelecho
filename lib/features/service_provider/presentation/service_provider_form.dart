import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import '../domain/service_provider_model.dart';
// import '../data/sources/service_provider_remote_source.dart';
import "../service_provider_exports.dart";

class ServiceProviderForm extends StatefulWidget {
  // final ServiceProviderRepository repository;
  // final String? userId;
  const ServiceProviderForm({super.key});

  @override
  State<ServiceProviderForm> createState() => _ServiceProviderFormState();
}

class _ServiceProviderFormState extends State<ServiceProviderForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedMake;
  String? _selectedModel;
  List<String> _makes = [];
  List<String> _models = [];
  List<Map<String, dynamic>> _carData = [];
  final _yearController = TextEditingController();
  final _colorController = TextEditingController();
  Color _selectedColor = Colors.blue;
  final _licensePlateController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descController = TextEditingController();
  final bool _isLoading = false;

  @override
  void dispose() {
    _yearController.dispose();
    _colorController.dispose();
    _licensePlateController.dispose();
    _phoneController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadCarData();
  }

  Future<void> _loadCarData() async {
    // Load car-models.json from assets
    final data = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/json/car-models.json');
    final List<Map<String, dynamic>> jsonResult =
        List<Map<String, dynamic>>.from(
          await Future.value(
            List<Map<String, dynamic>>.from(json.decode(data)),
          ),
        );
    print("Car JSON Result: $jsonResult");
    setState(() {
      _carData = jsonResult;
      _makes = _carData.map((e) => e['brand'] as String).toList();
    });
  }

  void _onMakeChanged(String? make) {
    setState(() {
      _selectedMake = make;
      _selectedModel = null;
      _models =
          _carData
              .firstWhere(
                (e) => e['brand'] == make,
                orElse: () => {'models': []},
              )['models']
              .cast<String>();
    });
  }

  // Future<void> _submit() async {
  //   if (!_formKey.currentState!.validate()) return;
  //   setState(() => _isLoading = true);
  //   final car = Car(
  //     make: _makeController.text.trim(),
  //     model: _modelController.text.trim(),
  //     year: int.parse(_yearController.text.trim()),
  //     color: _colorController.text.trim(),
  //     licensePlate: _licensePlateController.text.trim(),
  //   );
  //   final provider = ServiceProvider(
  //     car: car,
  //     phoneNumber:
  //         _phoneController.text.trim().isEmpty
  //             ? null
  //             : _phoneController.text.trim(),
  //     serviceDescription:
  //         _descController.text.trim().isEmpty
  //             ? null
  //             : _descController.text.trim(),
  //   );
  //   try {
  //     // final result = await widget.repository.createServiceProvider(
  //     //   provider,
  //     //   userId: widget.userId,
  //     // );
  //     if (result['success'] == true) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             result['message'] ?? 'Driver profile created successfully',
  //           ),
  //         ),
  //       );
  //       Navigator.pop(context);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(result['message'] ?? 'Failed to create profile'),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Service Provider')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Car Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              WidgetsSpacer.verticalSpacer16,
              DropdownSearch<String>(
                items: (String? filter, _) {
                  if (filter == null || filter.isEmpty) {
                    return _makes;
                  }
                  return _makes
                      .where(
                        (make) =>
                            make.toLowerCase().contains(filter.toLowerCase()),
                      )
                      .toList();
                },
                selectedItem: _selectedMake,
                decoratorProps: const DropDownDecoratorProps(
                  decoration: InputDecoration(labelText: 'Make'),
                ),
                onChanged: _onMakeChanged,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                  fit: FlexFit.loose,
                ),
              ),
              WidgetsSpacer.verticalSpacer8,

              DropdownSearch<String>(
                items: (String? filter, _) {
                  if (filter == null || filter.isEmpty) {
                    return _models;
                  }
                  return _models
                      .where(
                        (model) =>
                            model.toLowerCase().contains(filter.toLowerCase()),
                      )
                      .toList();
                },
                selectedItem: _selectedModel,
                decoratorProps: const DropDownDecoratorProps(
                  decoration: InputDecoration(labelText: 'Model'),
                ),
                onChanged: (model) => setState(() => _selectedModel = model),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                  fit: FlexFit.loose,
                ),
              ),
              WidgetsSpacer.verticalSpacer8,

              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  final n = int.tryParse(v);
                  if (n == null) return 'Enter a valid number';
                  return null;
                },
              ),
              WidgetsSpacer.verticalSpacer8,

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _colorController,
                      decoration: const InputDecoration(labelText: 'Color'),
                      readOnly: true,
                      validator:
                          (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () async {
                      Color pickedColor = _selectedColor;
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Pick a color'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: pickedColor,
                                onColorChanged: (color) {
                                  pickedColor = color;
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Select'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      setState(() {
                        _selectedColor = pickedColor;
                        _colorController.text =
                            '#${pickedColor.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _selectedColor,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              WidgetsSpacer.verticalSpacer8,

              TextFormField(
                controller: _licensePlateController,
                decoration: const InputDecoration(labelText: 'License Plate'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              WidgetsSpacer.verticalSpacer16,

              const Text(
                'Contact & Service',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              WidgetsSpacer.verticalSpacer8,

              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number (optional)',
                ),
                keyboardType: TextInputType.phone,
              ),
              WidgetsSpacer.verticalSpacer8,

              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Service Description (optional)',
                ),
                maxLines: 2,
              ),
              WidgetsSpacer.verticalSpacer20,

              ElevatedButton(
                onPressed: _isLoading ? null : null,
                child:
                    _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Create Service Provider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
