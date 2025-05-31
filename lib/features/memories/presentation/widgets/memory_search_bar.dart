import 'package:flutter/material.dart' hide CarouselController;
import '../../memories_exports.dart';
import 'dart:async';
import 'package:line_icons/line_icons.dart';

class MemorySearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const MemorySearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  State<MemorySearchBar> createState() => _MemorySearchBarState();
}

class _MemorySearchBarState extends State<MemorySearchBar> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: 'Search memories...',
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.defaultColor400,
          size: 20,
        ),
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(
                  LineIcons.times,
                  color: AppColors.defaultColor400,
                  size: 20,
                ),
                onPressed: () {
                  widget.controller.clear();
                  widget.onSearch('');
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.primaryColor100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      ),
      onChanged: _onSearchChanged,
    );
  }
}
