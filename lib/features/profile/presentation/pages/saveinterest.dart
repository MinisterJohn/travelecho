import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../profile_exports.dart';

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
                    hintText: "Search for interests",
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
            final List<String> selectedInterests =
                state is InterestsLoaded
                    ? state.profile.interests
                    : <String>[];
            return BlocBuilder<DataSearchBloc, DataSearchState>(
                builder: (context, state) {
              List<String> relatedInterests = state is InterestsLoaded
                  ? state.interests
                  : <String>[];
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

  Widget _buildInterestsList(List<String> relatedInterests,
      List<String> selectedInterests, BuildContext context) {
    if (relatedInterests.isNotEmpty) {
      return _relatedInterestsWidget(
          relatedInterests, selectedInterests, context);
    }
    return _selectedInterestsWidget(selectedInterests, context);
  }

  Widget _relatedInterestsWidget(List<String> relatedInterests,
      List<String> selectedInterests, BuildContext context) {
    if (relatedInterests.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(
        color: AppColors.primaryColor,
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
      List<String> selectedInterests, BuildContext context) {
    if (selectedInterests.isEmpty) {
      return const Center(
          child: Text(
              "No interest selected. Start searching to select 3 interests"));
    }
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

  Widget _interestsListWidget(List<String> interests,
      List<String> selectedInterests, int index) {
    String interest = interests[index];
    bool isSelected = selectedInterests.any(
        (selectedInterest) => selectedInterest == interest);
    return ElevatedButton(
      onPressed: () {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdateRequested(interest, ProfileUpdateKey.interests));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        elevation: 0,
        minimumSize: const Size(0, 0),
        backgroundColor: AppColors.primaryColor100,
        side: BorderSide(
            color: isSelected ? AppColors.primaryColor : Colors.transparent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        interest,
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
