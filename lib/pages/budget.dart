import 'package:flutter/material.dart';
import 'setbudget.dart';

class BudgetScreen extends StatefulWidget {
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _selectedIndex = 2; // Initial index set to Budget screen

  // Function to handle navigation item tap
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation based on selected index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/explore');
        break;
      case 1:
        Navigator.pushNamed(context, '/trip');
        break;
      case 2:
        // Stay on current screen
        break;
      case 3:
        Navigator.pushNamed(context, '/memories');
        break;

      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  // Function for customizing bottom navigation items
  Widget _bottomNavItem(String imagePath, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              imagePath, // Use the image asset path
              color: isSelected
                  ? Colors.white
                  : Colors.black, // Change image color based on selection
              width: 24, // Adjust width and height as needed
              height: 24,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: isSelected ? Colors.white : Colors.black,
              backgroundColor: Colors
                  .transparent, // Keep text visible even when icon color changes
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            width: 24, // Circle width
            height: 24, // Circle height
            padding:
                EdgeInsets.all(4), // Padding inside the circle for the icon
            decoration: BoxDecoration(
              color: Colors.white, // Background color of the circle (white)
              shape: BoxShape.circle, // Make the container circular
              border: Border.all(
                color: Color(0xFF8C8C8C), // Border color (#8C8C8C)
                width: 1, // Border width
              ),
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black, // Icon color inside the circle (black)
              size: 8.06, // Set the size of the arrow icon
            ),
          ),
          onPressed: () {
            // Navigate back to the home page
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Travel Budget',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Segoe UI',
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row with Budget Overview and Expense Tracker images
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _budgetImage("assets/BudgetOverview.png"),
                  _budgetImage("assets/ExpenseTracker.png"),
                ],
              ),
              SizedBox(height: 20),

              // "Set your Budget here" text centered
              Center(
                child: Text(
                  'Set your Budget here',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),

              // Image centered
              Center(
                child: Image.asset(
                  'assets/NoResultFound.png',
                  height: 100, // Adjust the height as needed
                ),
              ),
              SizedBox(height: 10),

              // "Nothing to see here!" text centered and bold
              Center(
                child: Text(
                  'Nothing to see here!',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),

              // Informational text about setting budget
              Center(
                child: Text(
                  'You can set your budget for your next trip\nand manage your finances.',
                  textAlign: TextAlign
                      .center, // Ensures text is centered within its container
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),

              // "Set your budget" button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the SetBudgetScreen when the button is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SetBudgetScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    // primary: Color(0xFF930BFF), // Button background color
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Set the corner radius to 10
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Set your budget',
                        style: TextStyle(
                            color: Colors.white), // Text color set to white
                      ),
                      SizedBox(width: 8), // Space between text and icon
                      Icon(Icons.add,
                          color: Colors.white), // Icon color set to white
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      //  bottomNavigationBar: BottomNavigationBar(
      //       currentIndex: _selectedIndex, // Set the current selected index
      //       onTap: _onNavItemTapped, // Handle item tap
      //       items: [
      //         BottomNavigationBarItem(
      //           icon: _bottomNavItem('assets/home.png', 'Explore', 0), // Home image
      //           label: '', // Label can be empty if you don't want to display it
      //         ),
      //         BottomNavigationBarItem(
      //           icon: _bottomNavItem('assets/travelicon.png', 'Trip', 1), // Trip image
      //           label: '', // Empty label
      //         ),
      //         BottomNavigationBarItem(
      //           icon: _bottomNavItem('assets/budget.png', 'Budget', 2), // Budget image
      //           label: '', // Empty label
      //         ),
      //         BottomNavigationBarItem(
      //           icon: _bottomNavItem('assets/memories.png', 'Memories', 3), // Memories image
      //           label: '', // Empty label
      //         ),
      //         BottomNavigationBarItem(
      //           icon: _bottomNavItem('assets/profile.png', 'Profile', 4), // Profile image
      //           label: '', // Empty label
      //         ),
      //       ],
      //     ),
    );
  }

  // Widget for Budget Overview and Expense Tracker images
  Widget _budgetImage(String imagePath) {
    return Container(
      width: 150,
      child: Center(child: Column(children: [Icon(Icons.home)])
          // Image.asset(
          //   imagePath,
          //   height: 150, // Adjust height as needed
          //   width: 150, // Adjust width as needed
          // ),
          ),
    );
  }
}
