import 'package:flutter/material.dart';
import '../../memories_exports.dart';

class MemorySkeletonCard extends StatelessWidget {
  const MemorySkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title placeholder
                Container(
                  height: 24,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                // Location placeholder
                Container(
                  height: 16,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 16),
                // Tags placeholder
                Row(
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      height: 24,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
      return ListView.builder(
        itemCount: 3, // Show 3 skeleton cards while loading
        itemBuilder: (context, index) => const MemorySkeletonCard(),
      );
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
              state is MemoriesLoaded && (state as MemoriesLoaded).isSearching
                  ? 'No memories found matching your search'
                  : 'No memories found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state is MemoriesLoaded && (state as MemoriesLoaded).isSearching
                  ? 'Try different search terms'
                  : 'Try adjusting your filters or search terms',
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
                  onView: () => onView(memory),
                  onEdit: () => onEdit(memory),
                  onDelete: () => onDelete(memory),
                ),
        );
      },
    );
  }
}
