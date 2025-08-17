import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/features/memories/presentation/widgets/create_update_memory/create_memory_action_buttons.dart';
import '../../memories_exports.dart';
import 'dart:async';

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
  // Removed unused _prefs
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
      _descriptionController.text = widget.memory!.description;
      _locationController.text = widget.memory!.location;
      _selectedDate = widget.memory!.date;
      _isPublic = widget.memory!.isPublic;
      _tags = List<String>.from(widget.memory!.tags);
      _memoryId = widget.memory!.id;
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
    await selectDate(
      context: context,
      selectedDate: _selectedDate,
      onDateSelected: (picked) {
        if (mounted) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
    );
  }

  Future<void> _handlePost() async {
    await handlePost(
      context: context,
      isEditing: widget.isEditing,
      memory: widget.memory,
      titleController: _titleController,
      descriptionController: _descriptionController,
      locationController: _locationController,
      selectedDate: _selectedDate,
      tags: _tags,
      isPublic: _isPublic,
      onLoading: () {
        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }
      },
    );

    // Check for badge earned and show popup
  }

  void _addTag() {
    addTag(
      tagController: _tagController,
      tags: _tags,
      onTagsChanged: (updatedTags) {
        if (mounted) {
          setState(() {
            _tags = updatedTags;
          });
        }
      },
    );
  }

  void _removeTag(String tag) {
    removeTag(
      tag: tag,
      tags: _tags,
      onTagsChanged: (updatedTags) {
        if (mounted) {
          setState(() {
            _tags = updatedTags;
          });
        }
      },
    );
  }

  void _resetForm() {
    resetForm(
      onReset: () {
        if (mounted) {
          setState(() {
            _titleController.clear();
            _descriptionController.clear();
            _locationController.clear();
            _tagController.clear();
            _tags.clear();
            _selectedDate = null;
            _isPublic = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                  UpdatePicturesButton(
                    memoryId: _memoryId,
                    isEditing: widget.isEditing,
                    existingImages:
                        widget.isEditing && widget.memory != null
                            ? widget.memory!.images
                            : null,
                  ),
                  WidgetsSpacer.verticalSpacer32,

                  // Action buttons
                  CreateMemoryActionButtons(
                    isLoading: _isLoading,
                    isUpdate: widget.isEditing,
                    onCreate: _handlePost,
                    onReset: _resetForm,
                  ),
                  WidgetsSpacer.verticalSpacer32,
                ],
              ),
            ),
          ),
        ),
        MemoryDetailsBlocListener(
          isEditing: widget.isEditing,
          memory: widget.memory,
          onMemoryCreatedOrUpdated: (memoryData) {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _memoryId = memoryData.id;
              });
            }
            DisplayMessage.successMessage(
              widget.isEditing
                  ? 'Memory updated successfully'
                  : 'Memory created successfully',
              context,
            );
            if (memoryData.hasEarnedNewBadge && memoryData.badge != null) {
              final badge = memoryData.badge!;
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Congratulations!'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('You have earned a new badge!'),
                          const SizedBox(height: 16),
                          Text(
                            'Badge: ${badge.name}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Level: ${badge.level}'),
                          Text('Description: ${badge.description}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => {
                            AppNavigator.pop(context),
                            CreateMemoryBottomDialog.show(
                              context: context,
                              onAddPictures: () {
                                    AppNavigator.pop(context);
                                    AppNavigator.push(
                                      context,
                                      BlocProvider.value(
                                        value: sl<MemoriesBloc>(),
                                        child: AddDetailsToMemoryPage(
                                          memoryId: _memoryId,
                                          isEditing: widget.isEditing,
                                          existingImages:
                                              widget.isEditing &&
                                                      widget.memory != null
                                                  ? widget.memory!.images
                                                  : null,
                                        ),
                                      ),
                                    );
                                  },
                                  onSkip: () {
                                    AppNavigator.pop(context);
                                    AppNavigator.pop(context);
                                  },
                                ),
                              },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            } else {
              CreateMemoryBottomDialog.show(
                context: context,
                onAddPictures: () {
                  AppNavigator.pop(context);
                  AppNavigator.push(
                    context,
                    BlocProvider.value(
                      value: sl<MemoriesBloc>(),
                      child: AddDetailsToMemoryPage(
                        memoryId: _memoryId,
                        isEditing: widget.isEditing,
                        existingImages:
                            widget.isEditing && widget.memory != null
                                ? widget.memory!.images
                                : null,
                      ),
                    ),
                  );
                },
                onSkip: () {
                  AppNavigator.pop(context);
                  AppNavigator.pop(context);
                },
              );
            }
          },
          onError: (message) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
            DisplayMessage.errorMessage(message, context);
          },
        ),
      ],
    );
  }
}
