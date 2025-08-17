import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class CarRentalsMessagingScreen extends StatefulWidget {
  const CarRentalsMessagingScreen({super.key});

  @override
  State<CarRentalsMessagingScreen> createState() =>
      _CarRentalsMessagingScreenState();
}

class _CarRentalsMessagingScreenState extends State<CarRentalsMessagingScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      "sender": "other",
      "text": "Hey Charlie, will be there in 3 minutes",
      "time": "Friday 2:20pm",
    },
    {"sender": "me", "text": "Alright. See ya!", "time": "Friday 2:30pm"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: appBarIconButton(context, null),
        title: Column(
          children: [
            GestureDetector(
              onTap: () {
                AppNavigator.push(
                  context,
                  const CarRentalsDriverDetailsScreen(),
                );
              },
              child: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage("assets/images/driver_avatar.png"),
              ),
            ),
            WidgetsSpacer.verticalSpacer8,
            const Text(
              "Charlie Davison",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: AppColors.defaultColor),
            onPressed: () {
              // Call logic
              AppNavigator.push(context, const CarRentalsCallScreen());
            },
          ),
        ],
        toolbarHeight: 90,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                // First message (other)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _messages[0]["time"],
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      WidgetsSpacer.verticalSpacer8,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _messages[0]["text"],
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                WidgetsSpacer.verticalSpacer16,
                // Second message (me)
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Charlie Davison",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        _messages[1]["time"],
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      WidgetsSpacer.verticalSpacer8,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _messages[1]["text"],
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          WidgetsSpacer.verticalSpacer8,
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Message...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.black54),
                  onPressed: () {
                    // Send message logic
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
