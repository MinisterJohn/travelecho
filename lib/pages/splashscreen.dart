import 'package:flutter/material.dart';
class AnimatedTextWithImageAndSpinner extends StatefulWidget {
  const AnimatedTextWithImageAndSpinner({Key? key}) : super(key: key);

  @override
  _AnimatedTextWithImageAndSpinnerState createState() =>
      _AnimatedTextWithImageAndSpinnerState();
}

class _AnimatedTextWithImageAndSpinnerState
    extends State<AnimatedTextWithImageAndSpinner> {
  late List<bool> _textVisible; // Tracks visibility of each letter
  bool _showSecondText = false; // Tracks visibility of second text and image
  bool _showSpinner = false; // Tracks visibility of the loading spinner

  @override
  void initState() {
    super.initState();
    _textVisible = List.generate("Travel echo".length, (_) => false);
    _animateFirstText();
  }

  Future<void> _animateFirstText() async {
    for (int i = 0; i < _textVisible.length; i++) {
      await Future.delayed(Duration(milliseconds: 200));
      setState(() {
        _textVisible[i] = true;
      });
    }

    // After the first text animation, show the second text with image
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _showSecondText = true;
    });

    // After the second text and image, show the spinner
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _showSpinner = true;
    });
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      Navigator.pushNamed(context, "/welcome");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // First Text Animation
            if (!_showSecondText && !_showSpinner)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate("Travel echo".length, (index) {
                  return AnimatedOpacity(
                    opacity: _textVisible[index] ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      "Travel echo"[index],
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff930BFF),
                          fontFamily: "vaio_con_dios"),
                    ),
                  );
                }),
              ),

            // Second Text and Image Animation
            if (!_showSpinner)
              AnimatedOpacity(
                opacity: _showSecondText ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/travel_echo_logo.png", // Replace with your image URL
                      height: 100,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Travel echo",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff930BFF),
                          fontFamily: "vaio_con_dios"),
                    ),
                  ],
                ),
              ),

            // Loading Spinner
            if (_showSpinner)
              AnimatedOpacity(
                opacity: _showSpinner ? 1.0 : 0.0,
                duration: Duration(milliseconds: 1000),
                child: CircularProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }
}
