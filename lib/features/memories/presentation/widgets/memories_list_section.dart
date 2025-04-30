import 'package:flutter/material.dart';
import '../../memories_exports.dart';
import 'memory_card.dart';
import 'memory_list_footer.dart';

class MemoriesListSection extends StatelessWidget {
  final List<MemoryModel> memories;
  final String username;
  final MemoriesState state;
  final ScrollController scrollController;
  final Function(MemoryModel) onView;
  final Function(MemoryModel) onEdit;
  final Function(MemoryModel) onDelete;
  final VoidCallback onRetry;

  const MemoriesListSection({
    super.key,
    required this.memories,
    required this.username,
    required this.state,
    required this.scrollController,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (state is MemoriesLoading && memories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is MemoryError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text((state as MemoryError).message),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (memories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No memories found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters or search terms',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: memories.length +
          (state is MemoriesLoaded && (state as MemoriesLoaded).hasMore
              ? 1
              : 0),
      itemBuilder: (context, index) {
        if (index == memories.length) {
          return const Center(child: CircularProgressIndicator());
        }

        final memory = memories[index];
        final isDeleting = state is MemoriesLoaded &&
            (state as MemoriesLoaded).deletingMemoryId == memory.id;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isDeleting
              ? const SizedBox.shrink()
              : MemoryCard(
                  key: ValueKey(memory.id),
                  memory: memory,
                  username: username,
                  onView: () => onView(memory),
                  onEdit: () => onEdit(memory),
                  onDelete: () => onDelete(memory),
                ),
        );
      },
    );
  }
}
