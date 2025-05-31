import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
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
  String _memoryId = '';
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

  Future<void> _handlePost() async {
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
            _memoryId = state.memory['_id'] ?? state.memory['id'];
          });
          print("Memory Created: ${state.memory}");
          DisplayMessage.successMessage('Memory created successfully', context);
        } else if (state is MemoryUpdated) {
          setState(() {
            _isLoading = false;
            _memoryId = state.memory['_id'] ?? state.memory['id'];
          });
          print("Memory Updated: ${state.memory}");
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetsSpacer.verticalSpacer32,

                // Memory form fields
                MemoryFormFields(
                  titleController: _titleController,
                  descriptionController: _descriptionController,
                  locationController: _locationController,
                  selectedDate: _selectedDate,
                  isPublic: _isPublic,
                  onPublicChanged: (value) {
                    setState(() {
                      _isPublic = value ?? true;
                    });
                  },
                  onDateTap: _selectDate,
                ),
                WidgetsSpacer.verticalSpacer16,

                // Tags section
                MemoryTagsSection(
                  tagController: _tagController,
                  tags: _tags,
                  onAddTag: _addTag,
                  onRemoveTag: _removeTag,
                ),
                WidgetsSpacer.verticalSpacer32,

                // Action buttons
                MemoryActionButtons(
                  isLoading: _isLoading,
                  isEditing: widget.isEditing,
                  onCreateUpdate: () async {
                    if (_titleController.text.isEmpty) {
                      DisplayMessage.errorMessage(
                          'Please enter a title', context);
                      return;
                    }
                    await _handlePost();
                    // ignore: use_build_context_synchronously
                    AppNavigator.pop(context);
                  },
                  onAddUpdatePictures: () async {
                    print("pictures");
                    await _handlePost();
                    final currentState = context.read<MemoriesBloc>().state;
                    print(currentState);
                   
                      AppNavigator.push(
                        context,
                        BlocProvider.value(
                          value: context.read<MemoriesBloc>(),
                          child: AddDetailsToMemoryPage(
                            memoryId: widget.memory!.id,
                            isEditing: widget.isEditing,
                            existingImages:
                                widget.isEditing && widget.memory != null
                                    ? widget.memory!.images
                                    : null,
                          ),
                        ),
                      );
                    
                  },
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
