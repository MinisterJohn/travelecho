import 'package:flutter/material.dart';

class SaveBudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            width: 40, // Increased the size for better visibility
            height: 40, // Same as width for a perfect circle
            padding: EdgeInsets.all(8), // Padding inside the circle
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white, // Outline color set to white
                width: 3, // Increased outline thickness
              ),
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20, // Adjusted icon size for better fit
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Circular background for the image
                  CircleAvatar(
                    radius: 46, // Size of the circle (half of 92)
                    backgroundColor: Colors.white, // Set background to white
                    child: ClipOval(
                      child: Image.asset(
                        'assets/markicon.png', // Replace with your image path
                        width: 92, // Adjust width and height to fit inside the circle
                        height: 92,
                        fit: BoxFit.cover, // Ensures the image fits well inside the circle
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            Text(
              'You just created your first budget!!!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Enjoy every trip when you set a budget for your trip.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the budget screen
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF930BFF),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                'Go back',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
