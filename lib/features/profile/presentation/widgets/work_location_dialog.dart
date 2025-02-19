import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/core/errors/display_error_message.dart';
import 'package:travelecho/core/hoc/bottomModalDraggable.dart';
import 'package:travelecho/features/profile/presentation/blocs/data_search_bloc.dart';
import 'package:travelecho/features/profile/presentation/blocs/data_search_event.dart';
import 'package:travelecho/features/profile/presentation/blocs/data_search_state.dart';

// ignore: unused_element
void showWhereIWorkDialog(BuildContext context) {
  TextEditingController occupationController = TextEditingController();
  List<dynamic> relatedOccupations = [];
  Timer? debounce;
  String selectedOccupation = "";

  void searchForRelatedOccupations(value, setState) {
    if (debounce?.isActive ?? false)
      debounce!.cancel(); // Cancel previous debounce

    debounce = Timer(const Duration(milliseconds: 500), () {
      // Reduce delay
      if (value.isEmpty) {
        setState(() {
          relatedOccupations = [];
        });
        return;
      }
      try {
        context
            .read<DataSearchBloc>()
            .add(OccupationsRequested(occupationHint: value));
      } catch (e) {
        DisplayMessage.errorMessage(e.toString(), context);
      }
    });
  }

  DraggableBottomModal(
    context,
    BlocProvider(
      create: (context) => DataSearchBloc(),
      child: StatefulBuilder(builder: (context, setState) {
        return BlocListener<DataSearchBloc, DataSearchState>(
            listener: (context, state) {
          if (state is OccupationsLoaded) {
            relatedOccupations = state.occupations.occupations;
            // _selectedSchool = {"name": "", "country": ""};
          }
        }, child: BlocBuilder<DataSearchBloc, DataSearchState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Current Occupation",
                      style: TextStyle(
                          fontSize: FontSize.size16,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Icon(
                        LineIcons.timesCircleAlt,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                WidgetsSpacer.verticalSpacer16,
                searchField(searchForRelatedOccupations, setState),
                WidgetsSpacer.verticalSpacer16,
                if (relatedOccupations.isNotEmpty)
                  relatedOccupationsWidget(
                      relatedOccupations, selectedOccupation, setState),
                if (selectedOccupation.isNotEmpty)
                  selectedOccupationWidget(selectedOccupation),
                WidgetsSpacer.spacer,
                GestureDetector(
                  onTap: () {
                    // Handle the selection action
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Select",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
      }),
    ),
  );
}

Widget searchField(searchForRelatedOccupations, setState) {
  return TextField(
    onChanged: (value) {
      searchForRelatedOccupations(value, setState);
    },
    decoration: InputDecoration(
      fillColor: AppColors.primaryColor100,
      filled: true,
      prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
      hintText: "Type your current occupation",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
    ),
  );
}

Widget relatedOccupationsWidget(
    relatedOccupations, selectedOccupation, setState) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: AppColors.defaultColor100,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    constraints: BoxConstraints(maxHeight: 250),
    child: Scrollbar(
      child: SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: relatedOccupations.length,
              itemBuilder: (context, index) {
                final occupation = relatedOccupations[index];
                return ListTile(
                  title: Text(occupation,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    setState(() {
                      selectedOccupation = occupation;
                    });
                    context.read<DataSearchBloc>().add(ClearOccupationList());
                  },
                );
              })),
    ),
  );
}

Widget selectedOccupationWidget(
  selectedOccupation,
) {
  return Container(
    color: AppColors.primaryColor100,
    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedOccupation["name"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
