import 'package:flutter/material.dart';
import 'package:travelecho/core/constants/appbar.dart';

void main() {
  runApp(MaterialApp(
    home: ChangePasswordPage(),
  ));
}

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Change Password", context),
      body: PasswordInputPage(
        title: "Please Enter Current Password",
        onConfirm: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPasswordPage(),
            ),
          );
        },
      ),
    );
  }
}

class NewPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Change Password'),
      ),
      body: PasswordInputPage(
        title: "Please Enter New Password",
        onConfirm: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmPasswordPage(),
            ),
          );
        },
      ),
    );
  }
}

class ConfirmPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Change Password'),
      ),
      body: PasswordInputPage(
        title: "Confirm Password",
        onConfirm: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasswordChangedPage(),
            ),
          );
        },
      ),
    );
  }
}

class PasswordChangedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Changed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.purple,
            ),
            SizedBox(height: 16),
            Text(
              'Password Changed',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Are you sure you want to exit?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: Text(
                'Go Back',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordInputPage extends StatefulWidget {
  final String title;
  final VoidCallback onConfirm;

  PasswordInputPage({required this.title, required this.onConfirm});

  @override
  _PasswordInputPageState createState() => _PasswordInputPageState();
}

class _PasswordInputPageState extends State<PasswordInputPage> {
  final List<String> password = List.filled(6, '');

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => CircleInputField(
                  onChanged: (value) {
                    setState(() {
                      password[index] = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (password.every((element) => element.isNotEmpty)) {
                    widget.onConfirm();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: Size(300, 50), // Increase width and height here
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }

}

class CircleInputField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  CircleInputField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
