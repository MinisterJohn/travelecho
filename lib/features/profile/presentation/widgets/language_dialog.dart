import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/features/profile/data/models/languages_model.dart';
import 'package:travelecho/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:travelecho/features/profile/presentation/widgets/bottomModalDraggable.dart';
import 'package:travelecho/features/profile/presentation/blocs/data_search_bloc.dart';
import 'package:travelecho/service_locator.dart';

void showLanguageDialog(BuildContext context) {
  TextEditingController searchController = TextEditingController();
  Timer? debounce;

  void searchForLanguages(String value) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<DataSearchBloc>().add(
            value.isEmpty
                ? const ClearSearchResults(type: SearchType.language)
                : LanguagesRequested(languageHint: value),
          );
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
          _buildSearchField(searchController, searchForLanguages),
          WidgetsSpacer.verticalSpacer16,
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final List<LanguageModel> selectedLanguages =
                  state is ProfileLoaded
                      ? state.profile.languages
                      : <LanguageModel>[];

              return BlocBuilder<DataSearchBloc, DataSearchState>(
                builder: (context, state) {
                  final List<LanguageModel> relatedLanguages =
                      state is LanguagesLoaded
                          ? state.languages
                          : <LanguageModel>[];
                  return _buildLanguageList(
                      relatedLanguages, selectedLanguages, context);
                },
              );
            },
          ),
          const Spacer(),
          _buildNextButton(context),
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
        "Languages you speak",
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
      hintText: "Search for different languages",
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

Widget _buildLanguageList(List<LanguageModel> relatedLanguages,
    List<LanguageModel> selectedLanguages, BuildContext context) {
  if (relatedLanguages.isNotEmpty) {
    return _relatedLanguagesWidget(
        relatedLanguages, selectedLanguages, context);
  }
  return _selectedLanguagesWidget(selectedLanguages, context);
}

Widget _relatedLanguagesWidget(List<LanguageModel> relatedLanguages,
    List<LanguageModel> selectedLanguages, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
            color: AppColors.defaultColor100,
            blurRadius: 5,
            offset: const Offset(0, 2))
      ],
    ),
    constraints: const BoxConstraints(maxHeight: 250),
    child: Scrollbar(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: relatedLanguages.length,
        itemBuilder: (context, index) {
          final language = relatedLanguages[index];
          final isSelected = selectedLanguages
              .any((lang) => lang.language == language.language);

          return CheckboxListTile(
            title: Text(language.language),
            value: isSelected,
            onChanged: (bool? isSelected) {
              context.read<ProfileBloc>().add(
                  ProfileUpdateRequested(language, ProfileUpdateKey.languages));
            },
          );
        },
      ),
    ),
  );
}

Widget _selectedLanguagesWidget(
    List<LanguageModel> selectedLanguages, BuildContext context) {
  if (selectedLanguages.isEmpty) {
    return const Center(
        child: Text("No languages selected. Start typing to search."));
  }
  return ListView.builder(
    shrinkWrap: true,
    itemCount: selectedLanguages.length,
    itemBuilder: (context, index) {
      final language = selectedLanguages[index];
      return CheckboxListTile(
        title: Text(language.language),
        value: true,
        onChanged: (bool? isSelected) {
          context.read<ProfileBloc>().add(
              ProfileUpdateRequested(language, ProfileUpdateKey.languages));
        },
      );
    },
  );
}

Widget _buildNextButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () => Navigator.of(context).pop(),
    child: const Text("Next"),
  );
}
