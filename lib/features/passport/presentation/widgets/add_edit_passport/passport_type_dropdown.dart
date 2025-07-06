import 'package:flutter/material.dart';
import "../../../passport_exports.dart";

class TravelDocumentsDropdown extends StatefulWidget {
  final String? selectedTravelDocuments;
  final ValueChanged<String> onSelected;

  const TravelDocumentsDropdown({
    super.key,
    required this.selectedTravelDocuments,
    required this.onSelected,
  });

  @override
  State<TravelDocumentsDropdown> createState() =>
      _TravelDocumentsDropdownState();
}

class _TravelDocumentsDropdownState extends State<TravelDocumentsDropdown> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.selectedTravelDocuments ?? '',
    );
  }

  @override
  void didUpdateWidget(covariant TravelDocumentsDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedTravelDocuments != oldWidget.selectedTravelDocuments) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.text = widget.selectedTravelDocuments ?? '';
      });
    }
  }

  void _showTravelDocumentsDropdown(BuildContext context) async {
    String search = '';
    final selected = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        List<Map<String, dynamic>> localFiltered = List.from(travelDocuments);
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Search TravelDocument Type",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      search = value;
                      setModalState(() {
                        localFiltered =
                            travelDocuments
                                .where(
                                  (passportType) => passportType['title']
                                      .toLowerCase()
                                      .contains(search.toLowerCase()),
                                )
                                .toList();
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: localFiltered.length,
                      itemBuilder: (context, index) {
                        final type = localFiltered[index];
                        return ListTile(
                          leading:
                              type['icon'] != null
                                  ? Icon(type['icon'] as IconData)
                                  : null,
                          title: Text(type['title']),
                          subtitle:
                              type['description'] != null
                                  ? Text(
                                    type['description'],
                                    style: const TextStyle(fontSize: 12),
                                  )
                                  : null,
                          onTap: () {
                            // widget.onSelected(type['title']);
                            Navigator.pop(context, type['title']);
                          },
                          selected:
                              widget.selectedTravelDocuments == type['title'],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    if (selected != null) {
      print(selected);
      widget.onSelected(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTravelDocumentsDropdown(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'TravelDocument Type',
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
          controller: _controller,
          validator:
              (value) =>
                  (widget.selectedTravelDocuments == null ||
                          widget.selectedTravelDocuments!.isEmpty)
                      ? 'Required'
                      : null,
        ),
      ),
    );
  }
}
