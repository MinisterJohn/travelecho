import 'package:flutter/material.dart';

class VisaImmigrationApp extends StatelessWidget {
  const VisaImmigrationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visa & Immigration Search'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const VisaImmigrationSearchPage(),
    );
  }
}

class VisaImmigrationSearchPage extends StatefulWidget {
  const VisaImmigrationSearchPage({Key? key}) : super(key: key);

  @override
  _VisaImmigrationSearchPageState createState() => _VisaImmigrationSearchPageState();
}

class _VisaImmigrationSearchPageState extends State<VisaImmigrationSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<VisaImmigrationDetail> _allDetails = [
    VisaImmigrationDetail(country: 'USA', details: 'Visa info for USA: Tourist, Student, Work visas available.'),
    VisaImmigrationDetail(country: 'Canada', details: 'Visa info for Canada: Express Entry, Study, Work visas available.'),
    VisaImmigrationDetail(country: 'UK', details: 'Visa info for UK: Visitor, Work, Student visas available.'),
    VisaImmigrationDetail(country: 'Australia', details: 'Visa info for Australia: Working Holiday, Student, Skilled visas available.'),
    VisaImmigrationDetail(country: 'India', details: 'Visa info for India: Tourist and Business visas available.'),
  ];

  List<VisaImmigrationDetail> _filteredDetails = [];

  @override
  void initState() {
    super.initState();
    _filteredDetails = _allDetails;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDetails = _allDetails.where((detail) {
        return detail.country.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search field
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search by country',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Display search results
          Expanded(
            child: _filteredDetails.isNotEmpty
                ? ListView.builder(
                    itemCount: _filteredDetails.length,
                    itemBuilder: (context, index) {
                      final detail = _filteredDetails[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(detail.country),
                          subtitle: Text(detail.details),
                          onTap: () {
                            // You can navigate to a detailed page if needed
                          },
                        ),
                      );
                    },
                  )
                : const Center(child: Text('No results found')),
          ),
        ],
      ),
    );
  }
}

class VisaImmigrationDetail {
  final String country;
  final String details;

  VisaImmigrationDetail({required this.country, required this.details});
}
