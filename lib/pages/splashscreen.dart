import 'package:flutter/material.dart';
import 'package:travelecho/pages/welcomepage.dart';

class ExpandingPictureScreen extends StatefulWidget {
  @override
  _ExpandingPictureScreenState createState() => _ExpandingPictureScreenState();
}

class _ExpandingPictureScreenState extends State<ExpandingPictureScreen> {
  double _containerWidth = 0.0; // Initial width of the container
  final double _imageWidth = 300.0; // Full width of the image
  bool _showFirstImage = true; // Toggle between images
  double _secondImageOpacity = 0.0; // Initial opacity for the second image

  @override
  void initState() {
    super.initState();

    // Start the animation when the widget loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _containerWidth = _imageWidth;
      });

      // Trigger the second image fade-in after the animation duration
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _secondImageOpacity = 1.0; // Fade in the second image
          _showFirstImage = false; // Hide the first image container
        });

        // Navigate to another page after 5 seconds
        Future.delayed(Duration(seconds: 5), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WelcomePage()),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // First image with expanding container animation
            if (_showFirstImage)
              AnimatedContainer(
                width: _containerWidth, // Animate the width
                height: 200, // Fixed height for the container
                duration: Duration(seconds: 2), // Animation duration
                curve: Curves.easeInOut, // Smooth easing effect
                child: ClipRect(
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/travel_echo_lettering.png',
                      width: _imageWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            // Second image with fade-in animation
            AnimatedOpacity(
              opacity: _secondImageOpacity, // Control visibility
              duration: Duration(seconds: 2), // Fade-in duration
              child: Image.asset(
                'assets/travel_echo_logo.png',
                width: _imageWidth,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
