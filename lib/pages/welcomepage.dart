import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      "image": "assets/welcome_pic1.png",
      "text": "Travel Smart!\nStay Informed \nTravel without worries"
    },
    {
      "image": "assets/welcome_pic2.png",
      "text":
          "Book flights and hotels \neffortlessly and track your \njourney in real time"
    },
    {
      "image": "assets/welcome_pic3.png",
      "text":
          "Access immigration info \nairport schedules and more \nat your finger tips."
    },
    {
      "image": "assets/welcome_pic4.png",
      "text": "Your all in one travel buddy"
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Flexible container for image and page indicator
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  height: 400, // Constrain height to prevent overflow
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Display the image
                          Image.asset(_pages[index]["image"]!),
                          SizedBox(height: 20),
                          // Step Indicator
                          if (_currentPage !=
                              _pages.length -
                                  1) // Only show indicators if not on last page
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _pages.length - 1,
                                (index) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                                  width: 8.0,
                                  height: 8.0,
                                  decoration: BoxDecoration(
                                    color: _currentPage == index
                                        ? Color(0xff930BFF)
                                        : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              // Text content below image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _pages[_currentPage]["text"]!,
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Buttons (next and previous)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Center buttons
                  children: [
                    // Hide the Previous button when on the first page

                    // Add some space between the buttons
                    // Make the Next button larger on the last page
                    ElevatedButton(
                      onPressed: _currentPage == _pages.length - 1
                          ? () {
                              // Navigate to login page
                              Navigator.pushNamed(context, '/signup');
                            }
                          : _nextPage,
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xff930BFF), // Button background color

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Apply border radius
                        ),
                        minimumSize: _currentPage == _pages.length - 1
                            ? Size(200, 60)
                            : Size(107, 45),
                      ),
                    ),
                    SizedBox(width: 10),
                    if (_currentPage != _pages.length - 1)
                      OutlinedButton(
                        onPressed: () {
                          // Navigate to signup page
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: Color(
                                0xff930BFF), // Text color to match the border color
                            fontSize: 20,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Color(0xff930BFF), // Border color
                              width: 1, // Border width
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Apply border radius
                            ),
                            minimumSize: Size(107, 45) // Button size
                            ),
                      )
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Add some space at the bottom
              if (_currentPage == _pages.length - 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You have an account?'),
                    TextButton(
                      onPressed: () {
                        // Navigate to login page
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

              SizedBox(height: 20), // Add some space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
