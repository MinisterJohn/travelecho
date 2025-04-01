import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../trip_exports.dart';

class DestinationBottomBar extends StatelessWidget {
  final VoidCallback onClear;
  final VoidCallback onNext;

  const DestinationBottomBar({
    super.key,
    required this.onClear, 
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
            onPressed: onClear,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(100, 40),
              
            ),
            child: const Text("Clear"),
          ),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(100, 40),
            ),
            child: const Text(
              "Next",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
