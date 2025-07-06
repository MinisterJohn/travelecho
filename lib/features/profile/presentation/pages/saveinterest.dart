import 'dart:async';

import 'package:flutter/material.dart' hide CarouselController;
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
  List<String> selectedInterests = [];
  List<String> tempSelectedInterests = [];

  @override
  void initState() {
    super.initState();
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoaded) {
      tempSelectedInterests = List.from(profileState.profile.interests);
    }
  }

  void updateTempSelectedInterests(String interest) {
    setState(() {
      if (!tempSelectedInterests.contains(interest)) {
        tempSelectedInterests.add(interest);
      } else {
        tempSelectedInterests.remove(interest);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Heading and description
        const Text(
          "What are you into?",
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        const Text(
          "Pick up to 3 interests that you will love to show on your profile.",
          style: TextStyle(fontSize: 14.0, color: Colors.grey),
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
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.primaryColor,
                  ),
                  suffixIcon: IconButton(
                    icon:
                        interestController.text.trim().isNotEmpty
                            ? const Icon(
                              Icons.clear,
                              color: AppColors.primaryColor,
                            )
                            : const SizedBox.shrink(),
                    onPressed: () {
                      interestController.clear();
                      if (debounce?.isActive ?? false) debounce!.cancel();
                      context.read<DataSearchBloc>().add(
                        const ClearSearchResults(type: SearchType.interest),
                      );
                    },
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
                        const ClearSearchResults(type: SearchType.interest),
                      );
                      return;
                    }
                    try {
                      // Check if context is still valid before accessing it
                      if (!context.mounted) return;
                      context.read<DataSearchBloc>().add(
                        InterestsRequested(interestHint: value),
                      );
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
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final List<String> selectedInterests =
                state is ProfileLoaded ? state.profile.interests : <String>[];

            return BlocBuilder<DataSearchBloc, DataSearchState>(
              builder: (context, dataState) {
                final List<String> relatedInterests =
                    dataState is InterestsLoaded
                        ? dataState.interests
                        : <String>[];

                return _buildInterestsList(
                  relatedInterests,
                  selectedInterests,
                  context,
                );
              },
            );
          },
        ),

        const Spacer(),
        ElevatedButton(
          onPressed: () {
            context.read<DataSearchBloc>().add(
              const ClearSearchResults(type: SearchType.interest),
            );
            context.read<ProfileBloc>().add(
              ProfileUpdateRequested(
                tempSelectedInterests,
                ProfileUpdateKey.interests,
              ),
            );
            AppNavigator.pop(context);
          },
          style: mergeWithThemeButtonStyle(
            context,
            ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
          ),

          child: Text(
            "Done",
            style: TextStyle(
              fontSize: FontSize.size16,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInterestsList(
    List<String> relatedInterests,
    List<String> selectedInterests,
    BuildContext context,
  ) {
    if (relatedInterests.isNotEmpty) {
      return _relatedInterestsWidget(relatedInterests, context);
    }
    return _selectedInterestsWidget(context);
  }

  Widget _relatedInterestsWidget(
    List<String> relatedInterests,
    BuildContext context,
  ) {
    if (relatedInterests.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    }
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
      constraints: const BoxConstraints(maxHeight: 200),
      child: Scrollbar(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Display 3 buttons in a row
            crossAxisSpacing: 10.0, // Space between columns
            mainAxisSpacing: 10.0, // Space between rows
            childAspectRatio: 2, // Adjusts the size of the buttons
          ),
          itemCount: relatedInterests.length,
          itemBuilder: (context, index) {
            return _interestsListWidget(relatedInterests, index);
          },
        ),
      ),
    );
  }

  Widget _selectedInterestsWidget(BuildContext context) {
    if (tempSelectedInterests.isEmpty) {
      return const Center(
        child: Text(
          "No interest selected. Start searching to select 3 interests",
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      constraints: const BoxConstraints(maxHeight: 200),
      child: Scrollbar(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Display 3 buttons in a row
            crossAxisSpacing: 10.0, // Space between columns
            mainAxisSpacing: 10.0, // Space between rows
            childAspectRatio: 2, // Adjusts the size of the buttons
          ),
          itemCount: tempSelectedInterests.length,
          itemBuilder: (context, index) {
            return _interestsListWidget(tempSelectedInterests, index);
          },
        ),
      ),
    );
  }

  Widget _interestsListWidget(List<String> interests, int index) {
    String interest = interests[index];
    bool isSelected = tempSelectedInterests.contains(interest);
    return ElevatedButton(
      onPressed: () {
        updateTempSelectedInterests(interest);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        elevation: 0,
        minimumSize: const Size(0, 0),
        backgroundColor: AppColors.primaryColor100,
        side: BorderSide(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Text(
        interest,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: FontSize.size14, // Reduced font size for smaller buttons
          fontWeight: FontWeight.bold,
          color: isSelected ? AppColors.primaryColor : AppColors.defaultColor,
        ),
      ),
    );
  }
}
