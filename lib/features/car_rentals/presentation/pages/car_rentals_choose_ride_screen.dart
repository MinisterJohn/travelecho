import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class CarRentalsChooseRideScreen extends StatefulWidget {
  final bool returnResult;
  const CarRentalsChooseRideScreen({super.key, this.returnResult = false});

  @override
  State<CarRentalsChooseRideScreen> createState() => _CarRentalsChooseRideScreenState();
}

class _CarRentalsChooseRideScreenState extends State<CarRentalsChooseRideScreen> {
  int _selectedRide = 0;
  String _selectedLocation = '';

  final List<Map<String, dynamic>> _rides = [
    {
      "name": "Standard",
      "price": "\$15",
      "image": "assets/images/car_rentals/car_rentals.png",
      "color": AppColors.primaryColor,
    },
    {
      "name": "Comfort",
      "price": "\$20.3",
      "image": "assets/images/car_rentals/car_rentals.png",
      "color": Colors.grey[200],
    },
    {
      "name": "Business",
      "price": "\$49.99",
      "image": "assets/images/car_rentals/car_retals.png",
      "color": Colors.grey[200],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map background (replace with your map widget)
          Container(
            color: Colors.grey[300],
            child: const Center(child: Text('Map Placeholder')),
          ),
          // Back button
          Positioned(top: 16, left: 8, child: appBarIconButton(context, null)),
          // Bottom sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Choose a Ride",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  WidgetsSpacer.verticalSpacer16,
                  // From and To
                  Row(
                    children: [
                      Column(
                        children: [
                          Icon(Icons.radio_button_checked, color: AppColors.primaryColor, size: 20),
                          Container(
                            width: 2,
                            height: 24,
                            color: Colors.grey[300],
                          ),
                          Icon(Icons.location_on, color: Colors.black, size: 20),
                        ],
                      ),
                      WidgetsSpacer.verticalSpacer16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "From",
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              "Berkely Avenue, New York",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "To",
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              "Silicia, Bahamas",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, size: 18),
                            onPressed: () {}, // Edit from
                          ),
                          const SizedBox(height: 32),
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
                  WidgetsSpacer.verticalSpacer20,
                  // Ride options
                  SizedBox(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _rides.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final ride = _rides[index];
                        final isSelected = _selectedRide == index;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedRide = index),
                          child: Container(
                            width: 120,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primaryColor : Colors.grey[100],
                              borderRadius: BorderRadius.circular(16),
                              border: isSelected
                                  ? Border.all(color: AppColors.primaryColor, width: 2)
                                  : null,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ride["name"],
                                  style: TextStyle(
                                    color: isSelected ? AppColors.white : AppColors.defaultColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                WidgetsSpacer.verticalSpacer8,
                                Expanded(
                                  child: Image.asset(
                                    ride["image"],
                                    fit: BoxFit.contain,
                                    height: 40,
                                  ),
                                ),
                                WidgetsSpacer.verticalSpacer8,
                                Text(
                                  ride["price"],
                                  style: TextStyle(
                                    color: isSelected ? AppColors.white : AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer20,
                  // Payment and Wallet
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.credit_card, color: AppColors.defaultColor),
                      title: const Text("****456749"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {}, // Change payment
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer8,
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.account_balance_wallet_outlined, color: AppColors.defaultColor),
                      title: const Text("Travel Wallet"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {}, // Open wallet
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer20,
                  // Next button
                  AppPrimaryButton(
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      // Handle next
                      if (widget.returnResult) {
                    // Edit flow: pop with result
                    Navigator.of(context).pop({
                      'rides': _rides[_selectedRide],
                    });
                  } else {
                    AppNavigator.push(
                      context,
                      const CarRentalsConfirmOrderDetails(),
                    );
                  }
                    },
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