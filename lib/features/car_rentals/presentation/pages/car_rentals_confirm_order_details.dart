import 'package:flutter/material.dart';
import '../../../features_exports.dart';
class CarRentalsConfirmOrderDetails extends StatefulWidget {
  const CarRentalsConfirmOrderDetails({super.key});

  @override
  State<CarRentalsConfirmOrderDetails> createState() =>
      _CarRentalsConfirmOrderDetailsState();
}

class _CarRentalsConfirmOrderDetailsState
    extends State<CarRentalsConfirmOrderDetails> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  Map<String, dynamic>? _selectedRide;
  String? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            // Close button
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                child: const Icon(Icons.close, size: 28),
              ),
            ),
            // Main content
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag handle
                      Center(
                        child: Container(
                          width: 60,
                          height: 5,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      const Text(
                        "Confirm order details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      WidgetsSpacer.horizontalSpacer20,
                      // From and To
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.radio_button_checked,
                                color: AppColors.primaryColor,
                                size: 20,
                              ),
                              Container(
                                width: 2,
                                height: 24,
                                color: Colors.grey[300],
                              ),
                              Icon(
                                Icons.location_on,
                                color: AppColors.primaryColor,
                                size: 20,
                              ),
                            ],
                          ),
                          WidgetsSpacer.horizontalSpacer16,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "From",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "Berkely Avenue, New York",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit, size: 18),
                                      onPressed: () {}, // Edit from
                                    ),
                                  ],
                                ),
                                WidgetsSpacer.horizontalSpacer8,
                                const Text(
                                  "To",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "Silicia, Bahamas",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    EditIconButton(
                                      onPressed: () async {
                                        final result = await Navigator.push<
                                          Map<String, dynamic>
                                        >(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    const CarRentalsScheduleRideScreen(
                                                      returnResult: true,
                                                    ),
                                          ),
                                        );
                                        if (result != null) {
                                          setState(() {
                                            _selectedLocation =
                                                result['location'];
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      WidgetsSpacer.verticalSpacer20,
                      // Ride details box
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Time of ride
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Time of ride",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "8:00 AM GMT",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                EditIconButton(
                                  onPressed: () async {
                                    final result = await Navigator.push<
                                      Map<String, dynamic>
                                    >(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                const CarRentalsSelectTimeScreen(
                                                  returnResult: true,
                                                ),
                                      ),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        _selectedDate = result['date'];
                                        _selectedTime = result['time'];
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            WidgetsSpacer.verticalSpacer8,
                            // Date of ride
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Date of ride",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "27th August, 2025",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                EditIconButton(
                                  onPressed: () async {
                                    final result = await Navigator.push<
                                      Map<String, dynamic>
                                    >(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                const CarRentalsSelectTimeScreen(
                                                  returnResult: true,
                                                ),
                                      ),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        _selectedDate = result['date'];
                                        _selectedTime = result['time'];
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            WidgetsSpacer.verticalSpacer8,
                            // Ride class
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Business Class",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                EditIconButton(
                                  onPressed: () async {
                                    final result = await Navigator.push<
                                      Map<String, dynamic>
                                    >(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                const CarRentalsChooseRideScreen(
                                                  returnResult: true,
                                                ),
                                      ),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        _selectedRide = result['rides'];
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            WidgetsSpacer.verticalSpacer8,
                            // Price
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Price",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$49.99",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      WidgetsSpacer.verticalSpacer20,
                      // Terms and conditions
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "All terms and conditions apply",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      WidgetsSpacer.verticalSpacer8,
                      // Confirm button
                      AppPrimaryButton(
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          // Handle confirm
                          AppNavigator.push(
                            context,
                            const CarRentalsCongratsScreen(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
