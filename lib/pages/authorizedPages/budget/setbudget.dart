import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'addcategories.dart';
import 'savebudget.dart';

class SetBudgetScreen extends StatefulWidget {
  @override
  _SetBudgetScreenState createState() => _SetBudgetScreenState();
}

class _SetBudgetScreenState extends State<SetBudgetScreen> {
  TextEditingController _budgetController = TextEditingController();

  // State variables for dropdown visibility
  bool _isAccommodationDropdownVisible = false;
  bool _isFoodAndDrinksDropdownVisible = false;
  bool _isTransportationDropdownVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8), // Padding inside the circle
            decoration: BoxDecoration(
              color: Color.fromRGBO(248, 239, 255, 1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              LineIcons.arrowCircleLeft,
              color: Colors.black,
              size: 20, // Adjusted icon size for better fit
            ),
          ),
          onPressed: () {
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
              Text(
                'Set a budget for your trip!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _budgetController,
                decoration: InputDecoration(
                  hintText: 'Enter your budget amount',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Text(
                'Plan your expenses for the trip.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Budget Categories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
        
              // Accommodation Dropdown
              _buildCategoryDropdown(
                title: 'Accommodation',
                subtitle: 'Hotel bookings',
                iconPath: 'assets/accomadation.png',
                isVisible: _isAccommodationDropdownVisible,
                onTap: () {
                  setState(() {
                    _isAccommodationDropdownVisible =
                        !_isAccommodationDropdownVisible;
                  });
                },
              ),
        
              // Food & Drinks Dropdown
              _buildCategoryDropdown(
                title: 'Food & Drinks',
                subtitle: 'Restaurant and cafes',
                iconPath: 'assets/foodanddrinks.png',
                isVisible: _isFoodAndDrinksDropdownVisible,
                onTap: () {
                  setState(() {
                    _isFoodAndDrinksDropdownVisible =
                        !_isFoodAndDrinksDropdownVisible;
                  });
                },
              ),
        
              // Transportation Dropdown
              _buildCategoryDropdown(
                title: 'Transportation',
                subtitle: 'Flights, taxis etc.',
                iconPath: 'assets/transportation.png',
                isVisible: _isTransportationDropdownVisible,
                onTap: () {
                  setState(() {
                    _isTransportationDropdownVisible =
                        !_isTransportationDropdownVisible;
                  });
                },
              ),
              SizedBox(height: 25),
        
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to AddCategoriesScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCategoriesScreen()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Add more category',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.add, color: Colors.black),
                    ],
                  ),
                ),
              ),
        
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Implement reset functionality
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the SaveBudgetScreen when the Save button is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SaveBudgetScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF930BFF),
                      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown({
    required String title,
    required String subtitle,
    required String iconPath,
    required bool isVisible,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                width: 24,
                height: 24,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 1),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        // SizedBox(height: 5),

        if (isVisible) ...[
          SizedBox(height: 5),
          Text(
            'Set Your Budget',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your budget',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Plan your expenses for $title',
            style: TextStyle(fontSize: 10, color: Color.fromRGBO(0, 0, 0, .4)),
          ),
          SizedBox(height: 5),
        ],
        SizedBox(height: 5),

        Divider(
          height: 3,
          color: Color.fromRGBO(0, 0, 0, .2),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
