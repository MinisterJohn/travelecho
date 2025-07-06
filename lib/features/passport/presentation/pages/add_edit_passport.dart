import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../passport_exports.dart";

class AddEditTravelDocumentPage extends StatefulWidget {
  final TravelDocumentModel? passport;
  const AddEditTravelDocumentPage({super.key, this.passport});

  @override
  State<AddEditTravelDocumentPage> createState() =>
      _AddEditTravelDocumentPageState();
}

class _AddEditTravelDocumentPageState extends State<AddEditTravelDocumentPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController passportNumberController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController placeOfIssueController = TextEditingController();
  DateTime? issueDate;
  DateTime? expiryDate;

  String? selectedTravelDocuments;

  @override
  void initState() {
    super.initState();
    if (widget.passport != null) {
      passportNumberController.text = widget.passport!.passportNumber;
      selectedTravelDocuments = widget.passport!.passportType;
      fullNameController.text = widget.passport!.fullName;
      nationalityController.text = widget.passport!.nationality;
      issueDate = widget.passport!.issueDate;
      expiryDate = widget.passport!.expiryDate;
      placeOfIssueController.text = widget.passport!.placeOfIssue ?? '';
    }
  }

  @override
  void dispose() {
    passportNumberController.dispose();
    fullNameController.dispose();
    nationalityController.dispose();
    placeOfIssueController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, bool isIssueDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isIssueDate) {
          issueDate = picked;
        } else {
          expiryDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(
        widget.passport == null ? 'Add TravelDocument' : 'Edit TravelDocument',
        context,
      ),
      body: BlocListener<TravelDocumentBloc, TravelDocumentState>(
        listener: (context, state) {
          if (state is TravelDocumentError) {
            DisplayMessage.errorMessage(state.message, context);
          }
          if (state is TravelDocumentSuccess) {
            if (_formKey.currentState!.validate()) {
              AppNavigator.pushAndRemove(
                context,
                BlocProvider.value(
                  value: sl<TravelDocumentBloc>(),
                  child: UploadTravelDocumentPhotoPage(
                    passport: state.passport,
                  ),
                ),
              );
            }
          }
        },
        child: BlocBuilder<TravelDocumentBloc, TravelDocumentState>(
          builder: (context, state) {
            final isLoading = state is TravelDocumentLoading;
            return Stack(
              children: [
                AbsorbPointer(
                  absorbing: isLoading,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        spacing: 16,
                        children: [
                          TravelDocumentForm(
                            formKey: _formKey,
                            passportNumberController: passportNumberController,
                            selectedTravelDocuments: selectedTravelDocuments,
                            onTravelDocumentSelected: (value) {
                              setState(() {
                                selectedTravelDocuments = value;
                              });
                            },
                            onCountrySelected: (value) {
                              setState(() {
                                nationalityController.text = value;
                              });
                            },
                            fullNameController: fullNameController,
                            nationalityController: nationalityController,
                            issueDate: issueDate,
                            expiryDate: expiryDate,
                            placeOfIssueController: placeOfIssueController,
                            onPickIssueDate: () => _pickDate(context, true),
                            onPickExpiryDate: () => _pickDate(context, false),
                          ),
                          if (widget.passport != null)
                            OutlinedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  AppNavigator.pushAndRemove(
                                    context,
                                    BlocProvider.value(
                                      value: sl<TravelDocumentBloc>(),
                                      child: UploadTravelDocumentPhotoPage(
                                        passport: widget.passport!,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                widget.passport != null
                                    ? "Update TravelDocument images"
                                    : "Upload TravelDocument images",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                // if (isLoading)
                //   Container(
                //     color: Colors.black.withOpacity(0.2),
                //     child: const Center(
                //       child: CircularProgressIndicator(),
                //     ),
                //   ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar:
          BlocConsumer<TravelDocumentBloc, TravelDocumentState>(
            listener: (context, state) {
              if (state is TravelDocumentLoaded ||
                  state is TravelDocumentSuccess) {
                AppNavigator.pop(context);
              }
            },
            builder: (context, state) {
              final isLoading = state is TravelDocumentLoading;

              return AddEditTravelDocumentBottomButtons(
                formKey: _formKey,
                isEdit: widget.passport != null,
                isLoading: isLoading,
                onSave: () async {
                  if (_formKey.currentState!.validate()) {
                    final params = TravelDocumentParams(
                      passportNumber: passportNumberController.text,
                      passportType: selectedTravelDocuments!,
                      fullName: fullNameController.text,
                      nationality: nationalityController.text,
                      issueDate: issueDate!,
                      expiryDate: expiryDate!,
                      placeOfIssue:
                          placeOfIssueController.text.isEmpty
                              ? null
                              : placeOfIssueController.text,
                    );
                    if (widget.passport == null) {
                      // Create
                      context.read<TravelDocumentBloc>().add(
                        CreateTravelDocumentEvent(params),
                      );
                    } else {
                      // Update
                      final id = widget.passport!.id;
                      context.read<TravelDocumentBloc>().add(
                        UpdateTravelDocumentEvent(id, params),
                      );
                    }
                    // Do not pop here; wait for BlocConsumer listener
                  }
                },
                onReset: () {
                  passportNumberController.text = "";
                  selectedTravelDocuments = "";
                  fullNameController.text = "";
                  nationalityController.text = "";
                  issueDate = null;
                  expiryDate = null;
                  placeOfIssueController.text = "";
                },
              );
            },
          ),
    );
  }
}
