import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
            const Text(
              'Login',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Phone Number Field
            const TextField(
              decoration: InputDecoration(
                hintText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),

            // Email Address Field
            const TextField(
              decoration: InputDecoration(
                hintText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),

            // Password Field
            TextField(
              decoration: InputDecoration(
                hintText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: TextButton(
                  onPressed: () {
                    // Handle Forgot Password Logic
                  },
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            // Login Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle Login Logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Line Separator
            const Row(
              children: [
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('OR'),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),

            const SizedBox(height: 20),

            // Login with Google
            GestureDetector(
              onTap: () {
                // Handle Google Login Logic
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/google_logo.png', height: 20), 
                    const SizedBox(width: 10),
                    const Text('Sign in with Google'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Login with Apple ID
            GestureDetector(
              onTap: () {
                // Handle Apple ID Login Logic
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/apple_logo.png', height: 20),
                    const SizedBox(width: 10),
                    const Text('Sign in with Apple ID'),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Sign Up Prompt
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                  // Navigate to Sign-Up Page
                },
                child: const Text("Don't have an account? Sign Up"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
