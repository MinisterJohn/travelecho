import 'package:flutter/material.dart';

class PasswordSavingPreferencePage extends StatefulWidget {
  const PasswordSavingPreferencePage({super.key});

  @override
  _PasswordSavingPreferencePageState createState() =>
      _PasswordSavingPreferencePageState();
}

class _PasswordSavingPreferencePageState
    extends State<PasswordSavingPreferencePage> {
  // Track the switch state for each option
  bool passwordFreeLogin = false;
  bool passwordFreeLogin60Min = false;
  bool passwordAlwaysNeeded = true; // Default option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Password Saving Preference',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Password Free Login Section
            _buildOptionCard(
              title: 'Password Free Login',
              description:
                  'You can login to TravelEcho without \n entering your password.',
              option: 'Password Free Login',
              value: passwordFreeLogin,
              onChanged: (bool value) {
                setState(() {
                  passwordFreeLogin = value;
                });
              },
            ),

            const SizedBox(height: 16),

            // 60-Minute Password Free Login Section
            _buildOptionCard(
              title: '60-Minute Password Free Login',
              description:
                  'You can login to TravelEcho without \n entering your password \n  in the next 60 mins.',
              option: '60-Minute Password Free Login',
              value: passwordFreeLogin60Min,
              onChanged: (bool value) {
                setState(() {
                  passwordFreeLogin60Min = value;
                });
              },
            ),

            const SizedBox(height: 16),

            // Password Always Needed Section
            _buildOptionCard(
              title: 'Password Always Needed',
              description: 'You need to enter password \n everytime you login.',
              option: 'Password Always Needed',
              value: passwordAlwaysNeeded,
              onChanged: (bool value) {
                setState(() {
                  passwordAlwaysNeeded = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String description,
    required String option,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () {
        // Toggle switch when tapping on the card
        onChanged(!value);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.purple,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Title and Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            // Right side: Switch Button
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.purple,
              activeTrackColor: Colors.purple[200],
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
