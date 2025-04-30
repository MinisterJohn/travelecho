import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../memories_exports.dart';

class MemoriesHomePage extends StatefulWidget {
  const MemoriesHomePage({super.key});

  @override
  State<MemoriesHomePage> createState() => _MemoriesHomePageState();
}

class _MemoriesHomePageState extends State<MemoriesHomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch memories to check if user has any
    context.read<MemoriesBloc>().add(
          const FetchMemories(limit: 10),
        );
  }

  void _retryFetch() {
    context.read<MemoriesBloc>().add(
          const FetchMemories(limit: 10),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoriesBloc, MemoriesState>(
      builder: (context, state) {
        if (state is MemoriesLoaded) {
          // Only show MemoryPage if it's the initial load and there are no memories
          if (state.memories.isEmpty && state.currentPage == 1) {
            return MemoryPage();
          }
          return const MemoriesListPage();
        }

        if (state is MemoryError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _retryFetch,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // Show loading or empty state while checking
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
