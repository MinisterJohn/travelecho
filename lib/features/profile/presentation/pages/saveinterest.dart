import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/core/errors/display_error_message.dart';
import 'package:travelecho/features/profile/data/models/interests_model.dart';
import 'package:travelecho/features/profile/presentation/blocs/data_search_bloc.dart';
import 'package:travelecho/features/profile/presentation/blocs/profile_bloc.dart';

class InterestSelectionPage extends StatefulWidget {
  const InterestSelectionPage({super.key});

  @override
  _InterestSelectionPageState createState() => _InterestSelectionPageState();
}

class _InterestSelectionPageState extends State<InterestSelectionPage> {
  TextEditingController interestController = TextEditingController();
  Timer? debounce;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading and description
          const Text(
            "What are you into?",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            "Pick up to 3 interests that you will love to show on your profile.",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),

          // Custom interest input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: interestController,
                  decoration: InputDecoration(
                    hintText: "Add your interest",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 12.0,
                    ),
                  ),
                  onChanged: (value) {
                    if (debounce?.isActive ?? false) debounce!.cancel();
                    debounce = Timer(const Duration(milliseconds: 500), () {
                      if (value.isEmpty) {
                        context.read<DataSearchBloc>().add(
                            const ClearSearchResults(
                                type: SearchType.interest));
                        return;
                      }
                      try {
                        // Check if context is still valid before accessing it
                        if (!context.mounted) return;
                        context
                            .read<DataSearchBloc>()
                            .add(InterestsRequested(interestHint: value));
                      } catch (e) {
                        DisplayMessage.errorMessage(e.toString(), context);
                      }
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              //
            ],
          ),
          WidgetsSpacer.verticalSpacer16,

          // Interest buttons in a grid

          BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            final List<InterestModel> selectedInterests =
                state is InterestsLoaded
                    ? state.profile.interests
                    : <InterestModel>[];
            return BlocBuilder<DataSearchBloc, DataSearchState>(
                builder: (context, state) {
              
              List<InterestModel> relatedInterests = state is InterestsLoaded
                  ? state.interests
                  : <InterestModel>[];
              return _buildInterestsList(
                  relatedInterests, selectedInterests, context);
            });
          }),

          // const Spacer(),

          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(),
              child: const Text("Done")),
        ],
      ),
    );
  }

  Widget _buildInterestsList(List<InterestModel> relatedInterests,
      List<InterestModel> selectedInterests, BuildContext context) {
    if (relatedInterests.isNotEmpty) {
      return _relatedInterestsWidget(
          relatedInterests, selectedInterests, context);
    }
    return _selectedInterestsWidget(selectedInterests, context);
  }

  Widget _relatedInterestsWidget(List<InterestModel> relatedInterests,
      List<InterestModel> selectedInterests, BuildContext context) {
        if (relatedInterests.isEmpty)
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ));
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
      constraints: const BoxConstraints(maxHeight: 200),
      child: Scrollbar(
          child: Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Display 3 buttons in a row
                    crossAxisSpacing: 10.0, // Space between columns
                    mainAxisSpacing: 10.0, // Space between rows
                    childAspectRatio: 2, // Adjusts the size of the buttons
                  ),
                  itemCount: relatedInterests.length,
                  itemBuilder: (context, index) {
                    return _interestsListWidget(
                        relatedInterests, selectedInterests, index);
                  }))),
    );
  }

  Widget _selectedInterestsWidget(
      List<InterestModel> selectedInterests, BuildContext context) {
    if (selectedInterests.isEmpty)
      return Center(
          child: Text(
              "No interest selected. Start searching to select 3 interests"));
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        constraints: const BoxConstraints(maxHeight: 200),
        child: Scrollbar(
            child: Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Display 3 buttons in a row
                      crossAxisSpacing: 10.0, // Space between columns
                      mainAxisSpacing: 10.0, // Space between rows
                      childAspectRatio: 2, // Adjusts the size of the buttons
                    ),
                    itemCount: selectedInterests.length,
                    itemBuilder: (context, index) {
                      return _interestsListWidget(
                          selectedInterests, selectedInterests, index);
                    }))));
  }

  Widget _interestsListWidget(List<InterestModel> interests,
      List<InterestModel> selectedInterests, int index) {
    InterestModel interest = interests[index];
    bool isSelected = selectedInterests.any(
        (selectedInterest) => selectedInterest.interest == interest.interest);
    return ElevatedButton(
      onPressed: () {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdateRequested(interest, ProfileUpdateKey.interests));
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        elevation: 0,
        minimumSize: Size(0, 0),
        backgroundColor: AppColors.primaryColor100,
        side: BorderSide(
            color: isSelected ? AppColors.primaryColor : Colors.transparent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        interest.interest,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.0, // Reduced font size for smaller buttons
          fontWeight: FontWeight.bold,
          color: isSelected ? AppColors.primaryColor : AppColors.defaultColor,
        ),
      ),
    );
  }
}
