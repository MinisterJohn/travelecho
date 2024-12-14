import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Login Text
            Text(
              'Login',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // Phone Number Field
            TextField(
              decoration: InputDecoration(
                hintText: 'Input Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),

            // Email Address Field
            TextField(
              decoration: InputDecoration(
                hintText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),

            // Password Field
            TextField(
              decoration: InputDecoration(
                hintText: 'Input your password',
                border: OutlineInputBorder(),
                suffixIcon: TextButton(
                  onPressed: () {
                    // Handle Forgot Password Logic
                  },
                  child: Text(
                    'Forget Password',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            // Login Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle Login Logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Line Separator
            Row(
              children: [
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('OR'),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),

            SizedBox(height: 20),

            // Login with Google
            GestureDetector(
              onTap: () {
                // Handle Google Login Logic
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('travelecho\\lib\\assets\\google_logo.png', height: 20), 
                    SizedBox(width: 10),
                    Text('Sign in with Google'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            // Login with Apple ID
            GestureDetector(
              onTap: () {
                // Handle Apple ID Login Logic
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('travelecho\\lib\\assets\\apple_logo.png', height: 20),
                    SizedBox(width: 10),
                    Text('Sign in with Apple ID'),
                  ],
                ),
              ),
            ),

            Spacer(),

            // Sign Up Prompt
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to Sign-Up Page
                },
                child: Text("Don't have an account? Sign Up"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
