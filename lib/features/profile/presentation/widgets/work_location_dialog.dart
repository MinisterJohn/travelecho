import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/core/errors/display_error_message.dart';
import 'package:travelecho/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:travelecho/features/profile/presentation/widgets/bottomModalDraggable.dart';
import 'package:travelecho/features/profile/presentation/blocs/data_search_bloc.dart';
import 'package:travelecho/service_locator.dart';

void showWhereIWorkDialog(BuildContext context) {
  final TextEditingController occupationController = TextEditingController();
  List relatedOccupations = [];
  Timer? debounce;

  final profileState = context.read<ProfileBloc>().state;
  String? selectedOccupation;

  if (profileState is ProfileLoaded) {
    selectedOccupation = profileState.profile.occupation.toUpperCase();
  } else {
    selectedOccupation = "";
  }

  void searchForRelatedOccupations(String value) {
    // isTyping = value.isNotEmpty;
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isEmpty) {
        context
            .read<DataSearchBloc>()
            .add(const ClearSearchResults(type: SearchType.occupation));
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
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<DataSearchBloc>()),
        BlocProvider.value(value: sl<ProfileBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<DataSearchBloc, DataSearchState>(
            listener: (context, state) {
              if (state is OccupationsLoaded) {
                relatedOccupations.clear();
                relatedOccupations.addAll(
                  state.occupations.occupations
                      .map((e) => e.toString().toUpperCase()),
                );
              }
            },
          ),
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoaded) {
                selectedOccupation = state.profile.occupation.toUpperCase();
              }
            },
          ),
        ],
        child: BlocBuilder<DataSearchBloc, DataSearchState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                WidgetsSpacer.verticalSpacer16,
                _buildSearchField(
                    occupationController, searchForRelatedOccupations),
                WidgetsSpacer.verticalSpacer16,
                if (relatedOccupations.isNotEmpty)
                  _buildRelatedOccupations(
                      relatedOccupations, context, occupationController),
                if (selectedOccupation!.isNotEmpty &&
                    occupationController.text.isEmpty)
                  _buildSelectedOccupation(context),
                WidgetsSpacer.spacer,
                _buildSelectButton(context),
              ],
            );
          },
        ),
      ),
    ),
  );
}

Widget _buildHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Current Occupation",
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
      hintText: "Start typing to search for your occupation",
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

Widget _buildRelatedOccupations(List occupations, BuildContext context,
    TextEditingController occupationController) {
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
        itemCount: occupations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              occupations[index],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            contentPadding: EdgeInsets.zero,
            onTap: () {
              context.read<ProfileBloc>().add(ProfileUpdateRequested(
                    occupations[index],
                    ProfileUpdateKey.occupation,
                  ));
              occupationController.clear();
              context
                  .read<DataSearchBloc>()
                  .add(const ClearSearchResults(type: SearchType.occupation));
            },
          );
        },
      ),
    ),
  );
}

Widget _buildSelectedOccupation(BuildContext context) {
  return BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      return Container(
        color: AppColors.primaryColor100,
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        child: Text(
          state.profile.occupation.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    },
  );
}

Widget _buildSelectButton(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).pop(),
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
