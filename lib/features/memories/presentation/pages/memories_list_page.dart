import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../memories_exports.dart';

class MemoriesListPage extends StatefulWidget {
  const MemoriesListPage({super.key});

  @override
  State<MemoriesListPage> createState() => _MemoriesListPageState();
}

class _MemoriesListPageState extends State<MemoriesListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String? _currentSearch;
  String? _currentTitle;
  String? _currentLocation;
  String? _currentTag;
  String? _currentSort;
  DateTime? _currentDate;
  String _username = '';
  List<MemoryModel> _memories = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchMemories();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('user_name') ?? '';
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_currentSearch == null &&
          _currentLocation == null &&
          _currentSort == null) {
        _fetchMemories();
      }
    }
  }

  void _onSearch(String value) {
    setState(() {
      _currentSearch = value.isEmpty ? null : value;
      _memories = [];
    });
    _fetchMemories();
  }

  void _onApplyFilters(String? location, DateTime? date) {
    setState(() {
      _currentLocation = location;
      _currentDate = date;
      _currentSort = date?.toIso8601String();
      _memories = [];
    });
    _fetchMemories();
  }

  void _fetchMemories() {
    final currentState = context.read<MemoriesBloc>().state;
    if (currentState is MemoriesLoaded &&
        _currentSearch == null &&
        _currentLocation == null &&
        _currentSort == null) {
      if ((_memories.length % 10) == 0) return;
      context.read<MemoriesBloc>().add(
            FetchMemories(
              search: _currentSearch,
              title: _currentTitle,
              location: _currentLocation,
              tag: _currentTag,
              sort: _currentSort,
              skip: currentState.memories.length,
            ),
          );
    } else {
      context.read<MemoriesBloc>().add(
            FetchMemories(
              search: _currentSearch,
              title: _currentTitle,
              location: _currentLocation,
              tag: _currentTag,
              sort: _currentSort,
              skip: 0,
            ),
          );
    }
  }

  void _handleViewMemory(MemoryModel memory) {
    // TODO: Implement view memory functionality
    DisplayMessage.successMessage(
        'View memory functionality coming soon', context);
  }

  void _handleEditMemory(MemoryModel memory) {
    AppNavigator.push(
      context,
      BlocProvider.value(
        value: context.read<MemoriesBloc>(),
        child: CreateMemoryDetailsPage(
          memory: memory,
          isEditing: true,
        ),
      ),
    );
  }

  void _handleDeleteMemory(MemoryModel memory) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Memory'),
          content: const Text('Are you sure you want to delete this memory?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<MemoriesBloc>().add(
                      DeleteMemory(memoryId: memory.id),
                    );
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemoriesBloc, MemoriesState>(
      listener: (context, state) {
        if (state is MemoryDeleted) {
          DisplayMessage.successMessage('Memory deleted successfully', context);
        } else if (state is MemoryUpdated) {
          DisplayMessage.successMessage('Memory updated successfully', context);
          _fetchMemories();
        } else if (state is MemoryError) {
          DisplayMessage.errorMessage(state.message, context);
          _fetchMemories();
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () {
            AppNavigator.push(
              context,
              BlocProvider.value(
                value: context.read<MemoriesBloc>(),
                child: const CreateMemoryDetailsPage(),
              ),
            );
          },
          child: const Icon(Icons.add, color: AppColors.white),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                MemorySearchFilterSection(
                  searchController: _searchController,
                  onSearch: _onSearch,
                  currentLocation: _currentLocation,
                  currentDate: _currentDate,
                  onApplyFilters: _onApplyFilters,
                ),
                Expanded(
                  child: Padding(
                    padding: WidgetsSpacer.pagePadding,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          _memories = [];
                        });
                        _fetchMemories();
                      },
                      child: BlocBuilder<MemoriesBloc, MemoriesState>(
                        builder: (context, state) {
                          if (state is MemoriesLoaded) {
                            _memories = state.memories;
                          } else if (state is MemoriesLoading) {
                            _memories = state.memories;
                          }

                          return MemoriesListSection(
                            memories: _memories,
                            username: _username,
                            state: state,
                            scrollController: _scrollController,
                            onView: _handleViewMemory,
                            onEdit: _handleEditMemory,
                            onDelete: _handleDeleteMemory,
                            onRetry: _fetchMemories,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<MemoriesBloc, MemoriesState>(
              builder: (context, state) {
                if (state is MemoriesLoading) {
                  return Positioned(
                    top: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Loading memories...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
