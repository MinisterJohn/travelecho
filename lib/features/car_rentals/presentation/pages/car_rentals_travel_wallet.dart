import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class CarRentalsTravelWalletScreen extends StatefulWidget {
  const CarRentalsTravelWalletScreen({super.key});

  @override
  State<CarRentalsTravelWalletScreen> createState() =>
      _CarRentalsTravelWalletScreenState();
}

class _CarRentalsTravelWalletScreenState
    extends State<CarRentalsTravelWalletScreen> {
  bool _isBalanceHidden = true;

  void _showAddMoneyOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Use your Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/profile/master.png", // Replace with your card image asset
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                  ),
                  title: const Text("****456749"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Handle add money with card
                  },
                ),
              ),
              WidgetsSpacer.verticalSpacer20,
              // Make Transfers
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Make Transfers",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              WidgetsSpacer.verticalSpacer8,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "To make Transfers, use the account details",
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ),
              WidgetsSpacer.verticalSpacer8,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "214059847822\nUBA\nTravelEchoInc",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
              WidgetsSpacer.verticalSpacer16,
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: appBarIconButton(context, null),
        title: const Text(
          "Travel Wallet",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: WidgetsSpacer.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WidgetsSpacer.verticalSpacer16,
            // Wallet Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [Color(0xFF9F5CFF), Color(0xFF6E56FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Travel Wallet",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      WidgetsSpacer.horizontalSpacer8,
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isBalanceHidden = !_isBalanceHidden;
                          });
                        },
                        child: Icon(
                          _isBalanceHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  WidgetsSpacer.verticalSpacer16,
                  Text(
                    _isBalanceHidden
                        ? "******"
                        : "₦50,000.00", // Example balance
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            WidgetsSpacer.verticalSpacer32,
            // Add Money Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: const Icon(Icons.add, color: Colors.black87),
                label: const Text(
                  "Add Money",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                onPressed: _showAddMoneyOptions,
              ),
            ),
            WidgetsSpacer.verticalSpacer32,
          ],
        ),
      ),
    );
  }
}
