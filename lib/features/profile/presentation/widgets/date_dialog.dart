import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../profile_exports.dart';

void showDateDialog(BuildContext context) {
  DateTime selectedDateOfBirth = DateTime.now().subtract(
    Duration(days: (5 * 365.25).round()),
  ); // Variable to store the selected date

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: BlocProvider.value(
          value: sl<ProfileBloc>(),
          child: Builder(
            builder: (context) {
              return Container(
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
                        final DateTime lastDate = DateTime.now().subtract(
                          Duration(days: (5 * 365.25).round()),
                        );
                        final DateTime initialDate =
                            (state is ProfileLoaded &&
                                    state.profile.dateOfBirth != null)
                                ? state.profile.dateOfBirth!.isAfter(lastDate)
                                    ? lastDate
                                    : state.profile.dateOfBirth!
                                : lastDate.subtract(Duration(days: 1));
              
                        return Expanded(
                          child: CalendarDatePicker(
                            initialDate: initialDate,
                            firstDate: DateTime(1900),
                            lastDate: lastDate,
                            onDateChanged: (DateTime selectedDate) {
                              selectedDateOfBirth = selectedDate;
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        // Handle the selection action
                        context.read<ProfileBloc>().add(
                          ProfileUpdateRequested(
                            selectedDateOfBirth.toIso8601String(),
                            ProfileUpdateKey.dateOfBirth,
                          ),
                        );
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
              );
            }
          ),
        ),
      );
    },
  );
}
