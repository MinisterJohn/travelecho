import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/features/profile/data/models/schools_list_model.dart';
import 'package:travelecho/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:travelecho/features/profile/presentation/widgets/bottomModalDraggable.dart';
import 'package:travelecho/features/profile/presentation/blocs/data_search_bloc.dart';
import 'package:travelecho/service_locator.dart';

void showWhereISchooledDialog(BuildContext context) {
  final TextEditingController schoolNameController = TextEditingController();
  Timer? debounce;

  void searchForSchools(String value) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      if (!context.mounted) return;
      if (value.isEmpty || value.length <= 1) {
        context
            .read<DataSearchBloc>()
            .add(const ClearSearchResults(type: SearchType.school));
      } else {
        context
            .read<DataSearchBloc>()
            .add(SchoolListRequested(schoolHint: value));
      }
    });
  }

  DraggableBottomModal(
    context,
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<DataSearchBloc>()),
        BlocProvider.value(value: sl<ProfileBloc>()),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 20.0),
          _buildSearchField(schoolNameController, searchForSchools),
          WidgetsSpacer.verticalSpacer16,
          BlocBuilder<DataSearchBloc, DataSearchState>(
            builder: (context, state) {
              final relatedSchools =
                  state is SchoolListLoaded ? state.schools : <SchoolModel>[];
              return relatedSchools.isNotEmpty ||
                      schoolNameController.text.length >= 2
                  ? _relatedSchoolsWidget(
                      relatedSchools, context, schoolNameController)
                  : const SizedBox();
            },
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final selectedSchool = state is ProfileLoaded
                  ? state.profile.school
                  : const SchoolModel(name: "", country: "");
              return selectedSchool.name.isNotEmpty &&
                      schoolNameController.text.isEmpty
                  ? _selectedSchoolWidget(selectedSchool)
                  : const SizedBox();
            },
          ),
          WidgetsSpacer.spacer,
          _buildAddButton(context, schoolNameController),
        ],
      ),
    ),
  );
}

Widget _buildHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Where I schooled",
        style:
            TextStyle(fontSize: FontSize.size16, fontWeight: FontWeight.bold),
      ),
      GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child:
            const Icon(LineIcons.timesCircleAlt, color: AppColors.primaryColor),
      ),
    ],
  );
}

Widget _buildSearchField(
    TextEditingController controller, Function(String) onChanged) {
  return TextField(
    controller: controller,
    onChanged: onChanged,
    decoration: InputDecoration(
      fillColor: AppColors.primaryColor100,
      filled: true,
      prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
      hintText: "Type the name of your school",
      helperText: "Enter at least two characters in your school's name",
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

Widget _relatedSchoolsWidget(List<SchoolModel> schools, BuildContext context,
    TextEditingController schoolNameController) {
  if (schools.isEmpty) {
    return Center(
        child: Column(
      children: [
        const Text("Not Found"),
        WidgetsSpacer.verticalSpacer16,
        OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0,
                side: const BorderSide(color: AppColors.primaryColor)),
            child: const Text("Add Custom School"))
      ],
    ));
  }

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
            color: AppColors.defaultColor100,
            blurRadius: 5,
            offset: const Offset(0, 2)),
      ],
    ),
    constraints: const BoxConstraints(maxHeight: 200),
    child: Scrollbar(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: schools.length,
        itemBuilder: (context, index) {
          final school = schools[index];
          return ListTile(
            title: Text(school.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(school.country),
            contentPadding: EdgeInsets.zero,
            onTap: () {
              schoolNameController.clear();
              context
                  .read<ProfileBloc>()
                  .add(ProfileUpdateRequested(school, ProfileUpdateKey.school));

              context
                  .read<DataSearchBloc>()
                  .add(const ClearSearchResults(type: SearchType.school));
            },
          );
        },
      ),
    ),
  );
}

Widget _selectedSchoolWidget(SchoolModel selectedSchool) {
  return Container(
    color: AppColors.primaryColor100,
    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(selectedSchool.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        WidgetsSpacer.horinzontalSpacer8,
        Text(selectedSchool.country, style: const TextStyle(fontSize: 12)),
      ],
    ),
  );
}

Widget _buildAddButton(BuildContext context, TextEditingController controller) {
  return GestureDetector(
    onTap: () {
      final schoolName = controller.text.trim();
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
          "Done",
          style: TextStyle(
              color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
