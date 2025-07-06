import 'package:flutter/material.dart';
import '../../../budget_exports.dart';

class EmptyScreen extends StatelessWidget {
  final String description;
  const EmptyScreen({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'Set your Budget here',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 40),
            Center(child: Image.asset('assets/NoResultFound.png', height: 150)),
            WidgetsSpacer.verticalSpacer20,
            const Center(
              child: Text(
                'Nothing to see here!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            WidgetsSpacer.verticalSpacer20,
            Center(
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
