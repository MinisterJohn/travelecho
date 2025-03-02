import 'package:flutter/material.dart';
import 'package:travelecho/core/constants/appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AddCardDetailsPage(),
    );
  }
}

class AddCardDetailsPage extends StatefulWidget {
  const AddCardDetailsPage({super.key});

  @override
  _AddCardDetailsPageState createState() => _AddCardDetailsPageState();
}

class _AddCardDetailsPageState extends State<AddCardDetailsPage> {
  final _cardNumberController = TextEditingController();
  final _monthYearController = TextEditingController();
  final _ccvController = TextEditingController();
  final _zipCodeController = TextEditingController();

  String? _selectedLogo; // To hold the path of the selected logo
  bool _isCardAdded = false; // Track if card details are added successfully

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Add Card Details", context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display success message if card details are added
            if (_isCardAdded)
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align text to the left, icon to the right
                  children: [
                    const Expanded(
                      child: Text(
                        "Card details successfully added",
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 18),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // Visa and MasterCard logos side by side
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLogo = 'assets/images/profile/visa.png';
                    });
                  },
                  child: Image.asset('assets/images/profile/visa.png', height: 20),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLogo = 'assets/images/profile/master.png';
                    });
                  },
                  child: Image.asset('assets/images/profile/master.png', height: 20),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Card Number field with logo display
            const Text("Card Number", style: TextStyle(fontSize: 16)),
            TextField(
              controller: _cardNumberController,
              decoration: InputDecoration(
                hintText: "Card Number",
                border: const OutlineInputBorder(),
                suffixIcon: _selectedLogo != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          _selectedLogo!,
                          height: 20,
                        ),
                      )
                    : null,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Month & Year, and CCV fields
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _monthYearController,
                    decoration: const InputDecoration(
                      hintText: "MM/YYYY",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _ccvController,
                    decoration: const InputDecoration(
                      hintText: "CCV",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Zip Code field
            const Text("Zip Code", style: TextStyle(fontSize: 16)),
            TextField(
              controller: _zipCodeController,
              decoration: const InputDecoration(
                hintText: "Zip Code",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Update state to show success message
                    _isCardAdded = true;
                  });
                  // Add your save functionality here
                  print("Card details saved");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
