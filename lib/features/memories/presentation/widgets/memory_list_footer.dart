import 'package:flutter/material.dart';
import '../../memories_exports.dart';

class MemoryListFooter extends StatelessWidget {
  final MemoriesState state;

  const MemoryListFooter({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state is MemoriesLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state is MemoriesLoaded && (state as MemoriesLoaded).hasMore == false) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('No more memories'),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
