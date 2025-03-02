import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:travelecho/service_locator.dart';

void showDateDialog(BuildContext context) {
  DateTime? selectedDate; // Variable to store the selected date

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: sl<ProfileBloc>(),
        child: Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: 300, // Adjusted width
            height: 400, // Adjusted height
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Icon(
                        LineIcons.timesCircleAlt,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    final DateTime dob = state is ProfileLoaded
                        ? state.profile.dob
                        : DateTime.now();

                    return Expanded(
                      child: CalendarDatePicker(
                        initialDate: DateTime.now()
                            .subtract(Duration(days: (5 * 365.25).round())),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now()
                            .subtract(Duration(days: (5 * 365.25).round())),
                        onDateChanged: (DateTime selectedDate) {
                          context.read<ProfileBloc>().add(
                              ProfileUpdateRequested(
                                  selectedDate,
                                  ProfileUpdateKey
                                      .dob)); // Store the selected date
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    // Handle the selection action
                    Navigator.of(context).pop();
                    // Optionally, you can use _selectedDate here
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Select",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
