import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../features_exports.dart';

class CarRentalsSelectTimeScreen extends StatefulWidget {
  final bool returnResult;
  const CarRentalsSelectTimeScreen({super.key, this.returnResult = false});

  @override
  State<CarRentalsSelectTimeScreen> createState() =>
      _CarRentalsSelectTimeScreenState();
}

class _CarRentalsSelectTimeScreenState
    extends State<CarRentalsSelectTimeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isAm = true;

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _isAm = picked.period == DayPeriod.am;
      });
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure of the selected time?',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(90, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),

                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        if (widget.returnResult) {
                          // Edit flow: pop with result
                          Navigator.of(
                            context,
                          ).pop({'date': _selectedDay, 'time': _selectedTime});
                        } else {
                          // Normal flow: push next screen
                          AppNavigator.push(
                            context,
                            const CarRentalsChooseRideScreen(),
                          );
                        }
                      },
                      child: const Text('Yes'),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.grey.shade400, width: 2),
                        minimumSize: const Size(90, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('No'),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hour = _selectedTime.hourOfPeriod.toString().padLeft(2, '0');
    final minute = _selectedTime.minute.toString().padLeft(2, '0');
    final ampm = _isAm ? 'AM' : 'PM';

    return Scaffold(
      appBar: setAppBar("Select Time", context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: AppColors.primaryColor,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: AppColors.primaryColor,
                ),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            WidgetsSpacer.verticalSpacer32,
            Row(
              children: [
                const Text('Time', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _pickTime,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '$hour:$minute',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 8),
                        ToggleButtons(
                          isSelected: [_isAm, !_isAm],
                          onPressed: (index) {
                            setState(() {
                              _isAm = index == 0;
                              _selectedTime = TimeOfDay(
                                hour:
                                    _isAm
                                        ? _selectedTime.hourOfPeriod
                                        : _selectedTime.hourOfPeriod + 12,
                                minute: _selectedTime.minute,
                              );
                            });
                          },
                          borderRadius: BorderRadius.circular(8),
                          selectedColor: AppColors.white,
                          fillColor: AppColors.primaryColor,
                          color: Colors.black,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text('AM'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text('PM'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            AppPrimaryButton(
              onPressed: _showConfirmationDialog,
              child: const Text(
                'Next',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            WidgetsSpacer.verticalSpacer32,
          ],
        ),
      ),
    );
  }
}
