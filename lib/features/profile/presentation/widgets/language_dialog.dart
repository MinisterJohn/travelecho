import 'dart:async';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../profile_exports.dart';

void showLanguageDialog(BuildContext context) {
  showDraggableBottomModal(
    context,
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<DataSearchBloc>()),
        BlocProvider.value(value: sl<ProfileBloc>()),
      ],
      child: LanguageDialog(context: context),
    ),
  );
}

class LanguageDialog extends StatefulWidget {
  final BuildContext context;

  const LanguageDialog({super.key, required this.context});

  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  late TextEditingController searchController;
  Timer? debounce;
  List<String> tempSelectedLanguages = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoaded) {
      tempSelectedLanguages = List.from(profileState.profile.languages);
    }
  }

  @override
  void dispose() {
    debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  void searchForLanguages(String value) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<DataSearchBloc>().add(
          value.isEmpty
              ? const ClearSearchResults(type: SearchType.language)
              : LanguagesRequested(languageHint: value),
        );
      }
    });
  }

  void updateTempSelectedLangauges(isSelected, language) {
    setState(() {
      if (isSelected == true) {
        if (!tempSelectedLanguages.contains(language)) {
          tempSelectedLanguages.add(language);
        }
      } else {
        tempSelectedLanguages.remove(language);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
              final List<String> selectedLanguages =
                  state is ProfileLoaded ? state.profile.languages : <String>[];
              return BlocBuilder<DataSearchBloc, DataSearchState>(
                builder: (context, dataState) {
                  final List<String> relatedLanguages =
                      dataState is LanguagesLoaded
                          ? dataState.languages
                          : <String>[];
                  return _buildLanguageList(
                    relatedLanguages,
                    selectedLanguages,
                    tempSelectedLanguages,
                    updateTempSelectedLangauges,
                    context,
                  );
                },
              );
            },
          ),
          const Spacer(),
          _buildNextButton(context, tempSelectedLanguages),
        ],
      ),
    );
  }
}

Widget _buildHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Languages you speak",
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
  );
}

Widget _buildSearchField(
  TextEditingController controller,
  Function(String) onChanged,
) {
  return BlocBuilder<DataSearchBloc, DataSearchState>(
    builder: (context, state) {
      return TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: AppColors.primaryColor100,
          filled: true,
          prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
          suffixIcon:
              state is DataSearchLoading
                  ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryColor,
                        ),
                      ),
                    ),
                  )
                  : controller.text.trim().isNotEmpty
                  ? InkWell(
                    onTap: () {
                      controller.clear();
                      context.read<DataSearchBloc>().add(
                        const ClearSearchResults(type: SearchType.language),
                      );
                    },
                    child: const Icon(
                      Icons.clear,
                      color: AppColors.primaryColor,
                    ),
                  )
                  : null,
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
    },
  );
}

Widget _buildLanguageList(
  List<String> relatedLanguages,
  List<String> selectedLanguages,
  List<String> tempSelectedLanguages,
  Function updateTempSelectedLanguages,
  BuildContext context,
) {
  if (relatedLanguages.isNotEmpty) {
    return _relatedLanguagesWidget(
      relatedLanguages,
      selectedLanguages,
      tempSelectedLanguages,
      updateTempSelectedLanguages,
      context,
    );
  }
  return _selectedLanguagesWidget(
    selectedLanguages,
    tempSelectedLanguages,
    updateTempSelectedLanguages,
    context,
  );
}

Widget _relatedLanguagesWidget(
  List<String> relatedLanguages,
  List<String> selectedLanguages,
  List<String> tempSelectedLanguages,
  Function updateTempSelectedLanguages,
  BuildContext context,
) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: AppColors.defaultColor100,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    constraints: const BoxConstraints(maxHeight: 250),
    child: Scrollbar(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: relatedLanguages.length,
        itemBuilder: (context, index) {
          final language = relatedLanguages[index];
          bool isnewSelected = tempSelectedLanguages.contains(language);

          return CheckboxListTile(
            title: Text(language),
            value: isnewSelected,
            onChanged: (bool? isSelected) {
              isnewSelected = isSelected ?? false;
              updateTempSelectedLanguages(isSelected, language);
            },
          );
        },
      ),
    ),
  );
}

Widget _selectedLanguagesWidget(
  List<String> selectedLanguages,
  List<String> tempSelectedLanguages,
  Function updateTempSelectedLanguages,
  BuildContext context,
) {
  if (tempSelectedLanguages.isEmpty) {
    return const Center(
      child: Text("No languages selected. Start typing to search."),
    );
  }

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      // borderRadius: BorderRadius.circular(20),
      // boxShadow: const [
      //   BoxShadow(
      //     color: AppColors.defaultColor100,
      //     blurRadius: 5,
      //     offset: Offset(0, 2),
      //   ),
      // ],
    ),
    constraints: const BoxConstraints(maxHeight: 250),
    child: Scrollbar(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tempSelectedLanguages.length,
        itemBuilder: (context, index) {
          final language = tempSelectedLanguages[index];
          final isSelected = tempSelectedLanguages.contains(language);

          return CheckboxListTile(
            title: Text(language),
            value: isSelected,
            onChanged: (bool? isSelected) {
              updateTempSelectedLanguages(isSelected, language);
            },
          );
        },
      ),
    ),
  );
}

Widget _buildNextButton(
  BuildContext context,
  List<String> tempSelectedLanguages,
) {
  return BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      return ElevatedButton(
        onPressed: () {
          context.read<ProfileBloc>().add(
            ProfileUpdateRequested(
              tempSelectedLanguages,
              ProfileUpdateKey.languages,
            ),
          );
          context.read<DataSearchBloc>().add(
            const ClearSearchResults(type: SearchType.language),
          );
          AppNavigator.pop(context);
        },
        style: mergeWithThemeButtonStyle(
          context,
          ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
        ),
        child:
            state is ProfileUpdating
                ? CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: AppColors.white,
                )
                : Text(
                  "Done",
                  style: TextStyle(
                    fontSize: FontSize.size16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
      );
    },
  );
}
