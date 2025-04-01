import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../trip_exports.dart';

class TripProgressDisplay extends StatelessWidget {
  final String progressKey;
  final String progressValue;
  final VoidCallback onPressed;
  const TripProgressDisplay(
      {super.key,
      required this.progressKey,
      required this.progressValue,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 70),
        backgroundColor: Colors.white,
        // foregroundColor: Colors.black,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            progressKey,
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
          WidgetsSpacer.horinzontalSpacer8,
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 14,
              ),
              Text(
                progressValue,
                style: const TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
