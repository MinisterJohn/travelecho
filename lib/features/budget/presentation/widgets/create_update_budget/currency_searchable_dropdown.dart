import 'dart:async';

import 'package:flutter/material.dart';

class CurrencySearchableDropdown extends StatefulWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String> onChanged;
  final String hintText;

  const CurrencySearchableDropdown({
    required this.items,
    this.selectedItem,
    required this.onChanged,
    required this.hintText,
    super.key,
  });

  @override
  _CurrencySearchableDropdownState createState() => _CurrencySearchableDropdownState();
}

class _CurrencySearchableDropdownState extends State<CurrencySearchableDropdown> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late List<String> _filteredItems;
  bool _isDropdownOpen = false;
  Timer? _debounce;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _filterItems(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _isLoading = true;
        if (query.isEmpty) {
          _filteredItems = widget.items;
        } else {
          _filteredItems = widget.items
              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isDropdownOpen = !_isDropdownOpen;
            });
            if (_isDropdownOpen) {
              _searchFocusNode.requestFocus();
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.selectedItem ?? widget.hintText,
                    style: TextStyle(
                      color: widget.selectedItem != null ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
                Icon(
                  _isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),
        if (_isDropdownOpen)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _filterItems,
                  ),
                ),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator()),
                if (!_isLoading && _filteredItems.isNotEmpty)
                  Container(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            widget.onChanged(item);
                            setState(() {
                              _isDropdownOpen = false;
                            });
                          },
                        );
                      },
                    ),
                  ),
                if (!_isLoading && _filteredItems.isEmpty)
                  const Center(child: Text('No results found')),
              ],
            ),
          ),
      ],
    );
  }
}
