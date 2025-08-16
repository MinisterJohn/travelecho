import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class CarRentalsScheduleRideScreen extends StatefulWidget {
  final bool returnResult;
  const CarRentalsScheduleRideScreen({super.key, this.returnResult = false});

  @override
  _CarRentalsScheduleRideScreenState createState() =>
      _CarRentalsScheduleRideScreenState();
}

class _CarRentalsScheduleRideScreenState
    extends State<CarRentalsScheduleRideScreen> {
  final TextEditingController _whereToController = TextEditingController();

  // Simulate a selected location (you'll want to update this when returning from the location screen)
  String _selectedLocation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map background (replace with your map widget if needed)
          // const SizedBox.expand(child: CarRentalsMapWidget()),
          // Back button
          Positioned(top: 16, left: 8, child: appBarIconButton(context, null)),
          // Bottom sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 400,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.defaultColor100,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Where to?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  WidgetsSpacer.verticalSpacer16,
                  // Non-editable Search field
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push<String>(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const CarRentalsLocationSelectionScreen(
                                    focusAddressField: true,
                                  ),
                          transitionsBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                          ) {
                            const begin = Offset(0.0, 1.0); // Start from bottom
                            const end = Offset.zero;
                            final tween = Tween(
                              begin: begin,
                              end: end,
                            ).chain(CurveTween(curve: Curves.ease));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          _selectedLocation = result;
                          _whereToController.text = result;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: _whereToController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                          ),
                          hintText: 'Where to?',
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        enabled: false, // Prevents keyboard popup
                      ),
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer32,

                  // Next button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: AppPrimaryButton(
                      onPressed:
                          _selectedLocation.isNotEmpty
                              ? () {
                                // Your logic here
                                if (widget.returnResult) {
                                  
                                  // Edit flow: pop with result
                                  Navigator.of(
                                    context,
                                  ).pop({'location': _selectedLocation});
                                } else {
                                  AppNavigator.push(
                                    context,
                                    const CarRentalsSelectTimeScreen(),
                                  );
                                }
                              }
                              : null,
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ), // Disabled if no location selected
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
