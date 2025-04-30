// import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../memories_exports.dart';

class CreateMemoryDetailsPage extends StatefulWidget {
  final MemoryModel? memory;
  final bool isEditing;

  const CreateMemoryDetailsPage({
    super.key,
    this.memory,
    this.isEditing = false,
  });

  @override
  State<CreateMemoryDetailsPage> createState() =>
      _CreateMemoryDetailsPageState();
}

class _CreateMemoryDetailsPageState extends State<CreateMemoryDetailsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final SharedPreferences _prefs = sl<SharedPreferences>();
  DateTime? _selectedDate;
  bool _isPublic = true;
  List<String> _tags = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.memory != null) {
      _titleController.text = widget.memory!.title;
      _descriptionController.text = widget.memory!.description ?? '';
      _locationController.text = widget.memory!.location ?? '';
      _selectedDate = widget.memory!.date;
      _isPublic = widget.memory!.isPublic;
      _tags = List<String>.from(widget.memory!.tags);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _handlePost() {
    if (_titleController.text.isEmpty) {
      DisplayMessage.errorMessage('Please enter a title', context);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    if (widget.isEditing && widget.memory != null) {
      context.read<MemoriesBloc>().add(
            EditMemory(
              memoryId: widget.memory!.id,
              title: _titleController.text,
              description: _descriptionController.text.isNotEmpty
                  ? _descriptionController.text
                  : null,
              location: _locationController.text.isNotEmpty
                  ? _locationController.text
                  : null,
              date: _selectedDate,
              tags: _tags.isNotEmpty ? _tags : null,
              isPublic: _isPublic,
            ),
          );
    } else {
      context.read<MemoriesBloc>().add(
            CreateMemory(
              title: _titleController.text,
              description: _descriptionController.text.isNotEmpty
                  ? _descriptionController.text
                  : null,
              location: _locationController.text.isNotEmpty
                  ? _locationController.text
                  : null,
              date: _selectedDate,
              tags: _tags.isNotEmpty ? _tags : null,
              isPublic: _isPublic,
            ),
          );
    }
  }

  void _addTag() {
    if (_tagController.text.isNotEmpty) {
      setState(() {
        _tags.add(_tagController.text.trim());
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemoriesBloc, MemoriesState>(
      listener: (context, state) {
        if (state is MemoryCreated) {
          setState(() {
            _isLoading = false;
          });
          print("Add Details: ${state.memory}");
          AppNavigator.push(
            context,
            BlocProvider.value(
              value: context.read<MemoriesBloc>(),
              child: AddDetailsToMemoryPage(
                  memoryId: state.memory['_id'] ?? state.memory['id']),
            ),
          );
          DisplayMessage.successMessage('Memory created successfully', context);
        } else if (state is MemoryUpdated) {
          setState(() {
            _isLoading = false;
          });
          AppNavigator.push(
            context,
            BlocProvider.value(
              value: context.read<MemoriesBloc>(),
              child: const MemoriesListPage(),
            ),
          );
          DisplayMessage.successMessage('Memory updated successfully', context);
        } else if (state is MemoryError) {
          setState(() {
            _isLoading = false;
          });
          print(state.message);
          DisplayMessage.errorMessage(state.message, context);
        }
      },
      child: Scaffold(
        appBar: setAppBar(
          widget.isEditing ? "Edit Memory" : "Create Memory",
          context,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetsSpacer.verticalSpacer32,

                // Title field
                Text(
                  'Add a title to describe',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.size16,
                  ),
                ),
                WidgetsSpacer.verticalSpacer8,

                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter title',
                    hintStyle: const TextStyle(color: AppColors.secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(fontSize: 16),
                  maxLines: 1,
                ),
                WidgetsSpacer.verticalSpacer16,

                // Description field
                Text(
                  'Add a description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.size16,
                  ),
                ),
                WidgetsSpacer.verticalSpacer8,

                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter description',
                    hintStyle: const TextStyle(color: AppColors.secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(fontSize: 16),
                  maxLines: 3,
                ),
                WidgetsSpacer.verticalSpacer16,

                // Location field
                Text(
                  'Add location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.size16,
                  ),
                ),
                WidgetsSpacer.verticalSpacer8,

                // TextField(
                //   controller: _locationController,
                //   decoration: InputDecoration(
                //     hintText: 'Enter location',
                //     hintStyle: const TextStyle(color: AppColors.secondaryColor),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                //   style: const TextStyle(fontSize: 16),
                //   maxLines: 1,
                // ),
                BlocProvider.value(
                    value: sl<DataSearchBloc>(),
                    child: LocationSearchField(
                      controller: _locationController,
                      onLocationSelected: (location) {
                        setState(() {
                          _locationController.text = location;
                        });
                      },
                    )),
                WidgetsSpacer.verticalSpacer16,

                // Date picker
                Text(
                  'Select date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.size16,
                  ),
                ),
                WidgetsSpacer.verticalSpacer8,

                InkWell(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.secondaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: AppColors.secondaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _selectedDate != null
                              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                              : 'Select date',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                WidgetsSpacer.verticalSpacer16,

                // Public/Private toggle
                Row(
                  children: [
                    Checkbox(
                      value: _isPublic,
                      onChanged: (value) {
                        setState(() {
                          _isPublic = value ?? true;
                        });
                      },
                    ),
                    const Text('Make this memory public'),
                  ],
                ),
                WidgetsSpacer.verticalSpacer16,

                // Tags section
                Text(
                  'Add tags that describe your experience',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.size14,
                  ),
                ),
                WidgetsSpacer.verticalSpacer8,

                // Tag input field
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _tagController,
                        decoration: InputDecoration(
                          hintText: 'Enter tag',
                          hintStyle:
                              const TextStyle(color: AppColors.secondaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: const TextStyle(fontSize: 16),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _addTag,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: Size(0, 0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                WidgetsSpacer.verticalSpacer8,

                // Tags list
                if (_tags.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _tags.map((tag) {
                      return Chip(
                        label: Text(tag),
                        onDeleted: () => _removeTag(tag),
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(0.1),
                        labelStyle: TextStyle(color: AppColors.primaryColor),
                      );
                    }).toList(),
                  ),
                WidgetsSpacer.verticalSpacer32,

                // Post button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handlePost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            widget.isEditing
                                ? 'Update Memory'
                                : 'Create Memory',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                WidgetsSpacer.verticalSpacer32,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
