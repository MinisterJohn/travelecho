import 'package:flutter/material.dart';
import 'package:travelecho/pages/homescreen.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false; // Track password visibility
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Login Text
              const Text(
                'Login',
                style: TextStyle(
                  color: Color(0xff930BFF),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Full Name Field
              TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10),

              // Email Address Field
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),

              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible, // Toggle password visibility
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible =
                            !_isPasswordVisible; // Toggle visibility
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 2),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgotpassword');
                  // Navigate to Sign-Up Page
                },
                style: TextButton.styleFrom(alignment: Alignment.centerLeft),
                child: const Text(
                  "Forgot Password?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Login Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Login Logic
                    _login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff930BFF),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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

              const SizedBox(height: 20),
              // Sign Up Prompt
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                    // Navigate to Sign-Up Page
                  },
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(color: Color(0xff930BFF)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

    void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in both fields')),
      );
    } else {
      // Implement login logic here
      print('Logging in with $email and $password');

      // Navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

}
