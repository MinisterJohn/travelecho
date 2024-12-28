import 'package:flutter/material.dart';

class AddCategoriesScreen extends StatefulWidget {
  @override
  _AddCategoriesScreenState createState() => _AddCategoriesScreenState();
}

class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  // Checkbox states
  bool _isCruiseSelected = false;
  bool _isRoadTripsSelected = false;
  bool _isWildlifeWatchingSelected = false;
  bool _isOutdoorAdventuresSelected = false;
  bool _isSightseeingSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            width: 24, // Circle width
            height: 24, // Circle height
            padding: EdgeInsets.all(4), // Padding inside the circle for the icon
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
            // Navigate back to the previous screen
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
              // Highlight your experience text
              Text(
                'Highlight what best fits your travel experience',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
        
              // Search field
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Find what interests you most',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
              SizedBox(height: 20),
        
              // Cruise category
              _buildCategoryItem(
                imagePath: 'assets/cruise.png',
                title: 'Cruise',
                subtitle: 'Travels on ship, and boat cruise',
                isSelected: _isCruiseSelected,
                onChanged: (value) {
                  setState(() {
                    _isCruiseSelected = value!;
                  });
                },
              ),
        
              // Road Trips category
              _buildCategoryItem(
                imagePath: 'assets/carbon_road.png',
                title: 'Road Trips',
                subtitle: 'Multiple destinations by car or RV',
                isSelected: _isRoadTripsSelected,
                onChanged: (value) {
                  setState(() {
                    _isRoadTripsSelected = value!;
                  });
                },
              ),
        
              // Wildlife Watching category
              _buildCategoryItem(
                imagePath: 'assets/travelicon.png',
                title: 'Wildlife Watching',
                subtitle: 'Visiting zoos, aquariums, etc.',
                isSelected: _isWildlifeWatchingSelected,
                onChanged: (value) {
                  setState(() {
                    _isWildlifeWatchingSelected = value!;
                  });
                },
              ),
        
              // Outdoor Adventures category
              _buildCategoryItem(
                imagePath: 'assets/outdooradventures.png',
                title: 'Outdoor Adventures',
                subtitle: 'Hiking, biking, kayaking, etc.',
                isSelected: _isOutdoorAdventuresSelected,
                onChanged: (value) {
                  setState(() {
                    _isOutdoorAdventuresSelected = value!;
                  });
                },
              ),
        
              // Sightseeing category
              _buildCategoryItem(
                imagePath: 'assets/sightseeing.png',
                title: 'Sightseeing',
                subtitle: 'Visiting landmarks, historical sites, etc.',
                isSelected: _isSightseeingSelected,
                onChanged: (value) {
                  setState(() {
                    _isSightseeingSelected = value!;
                  });
                },
              ),
        
              Spacer(),
        
              // Reset and Save buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isCruiseSelected = false;
                        _isRoadTripsSelected = false;
                        _isWildlifeWatchingSelected = false;
                        _isOutdoorAdventuresSelected = false;
                        _isSightseeingSelected = false;
                      });
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
                      // Implement save functionality
                    },
                    style: ElevatedButton.styleFrom(
                      // primary: Color(0xFF930BFF), // Button background color
                      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Set the corner radius to 5
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white), // Text color set to white
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

  Widget _buildCategoryItem({
    required String imagePath,
    required String title,
    required String subtitle,
    required bool isSelected,
    required ValueChanged<bool?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 40,
            height: 40,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Checkbox(
            value: isSelected,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
