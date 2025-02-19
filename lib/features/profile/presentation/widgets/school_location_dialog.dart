import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/core/errors/display_error_message.dart';
import 'package:travelecho/core/hoc/bottomModalDraggable.dart';
import 'package:travelecho/features/profile/domain/usecases/school_list_usecase.dart';
import 'package:travelecho/features/profile/presentation/blocs/data_search_bloc.dart';
import 'package:travelecho/features/profile/presentation/blocs/data_search_event.dart';
import 'package:travelecho/features/profile/presentation/blocs/data_search_state.dart';
import 'package:travelecho/service_locator.dart';

void showWhereISchooledDialog(BuildContext context) {
  TextEditingController schoolNameController = TextEditingController();
  List relatedSchools = [];
  Map selectedSchool = {"name": "", "country": ""};
  Timer? debounce;

  void searchForSchools(value, setState) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isEmpty) {
        setState(() {
          relatedSchools = [];
        });
        return;
      }
      try {
        context
            .read<DataSearchBloc>()
            .add(SchoolListRequested(schoolHint: value));
      } catch (e) {
        DisplayMessage.errorMessage(e.toString(), context);
      }
    });
  }

  DraggableBottomModal(
    context,
    BlocProvider(
      create: (context) => sl<DataSearchBloc>(),
      child: StatefulBuilder(
        builder: (context, setState) {
          return BlocListener<DataSearchBloc, DataSearchState>(
            listener: (context, state) {
              if (state is SchoolListLoaded) {
                relatedSchools = state.schools;
              }
            },
            child: BlocBuilder<DataSearchBloc, DataSearchState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Where I schooled",
                          style: TextStyle(
                            fontSize: FontSize.size16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            LineIcons.timesCircleAlt,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: schoolNameController,
                      onChanged: (value) async {
                        searchForSchools(value, setState);
                      },
                      decoration: InputDecoration(
                        fillColor: AppColors.primaryColor100,
                        filled: true,
                        prefixIcon: const Icon(Icons.search,
                            color: AppColors.primaryColor),
                        hintText: "Type the name of your school",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              const BorderSide(color: AppColors.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              const BorderSide(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                    WidgetsSpacer.verticalSpacer16,
                    if (relatedSchools.isNotEmpty)
                      relatedSchoolsWidget(
                          relatedSchools, selectedSchool, setState),
                    if (selectedSchool["name"] != "")
                      selectedSchoolWidget(selectedSchool),
                    WidgetsSpacer.spacer,
                    GestureDetector(
                      onTap: () {
                        String schoolName = schoolNameController.text.trim();
                        if (schoolName.isNotEmpty) {
                          print("School Name Added: $schoolName");
                        }
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
                            "Add",
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
            ),
          );
        },
      ),
    ),
  );
}

Widget relatedSchoolsWidget(List relatedSchools, selectedSchool, setState) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: AppColors.defaultColor100,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    constraints: const BoxConstraints(maxHeight: 250),
    child: Scrollbar(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: relatedSchools.length,
            itemBuilder: (context, index) {
              final school = relatedSchools[index];
              return ListTile(
                title: Text(school.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(school.country),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  setState(() {
                    selectedSchool["name"] = school.name;
                    selectedSchool["country"] = school.country;
                    // Hide list
                  });
                  context.read<DataSearchBloc>().add(ClearSchoolList());
                },
              );
            })),
  );
}

Widget selectedSchoolWidget(
  selectedSchool,
) {
  return Container(
    color: AppColors.primaryColor100,
    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedSchool["name"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        WidgetsSpacer.horinzontalSpacer8,
        Text(
          selectedSchool["country"],
          style: const TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}
