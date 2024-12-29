import 'package:flutter/material.dart';
import 'setbudget.dart';
import 'package:line_icons/line_icons.dart';

class BudgetScreen extends StatefulWidget {
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  String currentBudgetTool = "Budget Overview";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  _budgetTools(
                    LineIcons.piggyBank,
                    "Budget Overview",
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  _budgetTools(
                    LineIcons.clipboardList,
                    "Expense Tracker",
                  ),
                ],
              ),
              SizedBox(height: 60),

              // "Set your Budget here" text centered
              Text(
                'Set your Budget here',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Image centered
              Center(
                child: Image.asset(
                  'assets/NoResultFound.png',
                  height: 100, // Adjust the height as needed
                ),
              ),
              SizedBox(height: 20),

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
                    backgroundColor:
                        Color(0xFF930BFF), // Button background color
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
  Widget _budgetTools(IconData icon, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentBudgetTool = label;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: currentBudgetTool != label
                ? Border.all(color: Color.fromRGBO(0, 0, 0, 0.1))
                : null,
            color: currentBudgetTool == label
                ? Color(0xff930BFF)
                : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon,
                    color: currentBudgetTool == label
                        ? Colors.white
                        : Colors.black,
                    size: 50),
                SizedBox(height: 10),
                Text(
                  label,
                  style: TextStyle(
                      color: currentBudgetTool == label
                          ? Colors.white
                          : Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
