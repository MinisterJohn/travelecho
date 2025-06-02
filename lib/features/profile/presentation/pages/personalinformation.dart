import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
// For image picking
import "../../profile_exports.dart";
// For file handling
import '../widgets/profile_image_section.dart';

class EditPersonalInformation extends StatefulWidget {
  const EditPersonalInformation({super.key});

  @override
  State<EditPersonalInformation> createState() =>
      _EditPersonalInformationState();
}

class _EditPersonalInformationState extends State<EditPersonalInformation> {
  final bool _isLocationLoading = false;
  final bool _isOccupationLoading = false;
  final bool _isSchoolLoading = false;
  final bool _isDobLoading = false;
  final bool _isLanguageLoading = false;
  final bool _isInterestsLoading = false;

  Future<void> _handleImageSelected(dynamic image) async {
    if (!mounted) return;
    try {
      print('profile image selected: $image');
      context.read<ProfileBloc>().add(ProfileImageUpdateRequested(image));
      DisplayMessage.successMessage(
        "Profile photo updated successfully",
        context,
      );
    } catch (e) {
      if (mounted) {
        print('profile image update failed: $e');
        DisplayMessage.errorMessage(
          "Failed to update profile photo: $e",
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("", context),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailure) {
            DisplayMessage.errorMessage(state.error, context);
          }
        },
        builder: (context, state) {
          //   if (state is ProfileFailure) {
          //     // return Center(
          //     //   child: Column(
          //     //     mainAxisAlignment: MainAxisAlignment.center,
          //     //     children: [
          //     //       Text(
          //     //         'Failed to load profile: ${state.error}',
          //     //         textAlign: TextAlign.center,
          //     //         style: const TextStyle(color: Colors.red),
          //     //       ),
          //     //       const SizedBox(height: 16),
          //     //       ElevatedButton.icon(
          //     //         onPressed: () {
          //     //           context.read<ProfileBloc>().add(ProfileLoadRequested());
          //     //         },
          //     //         icon: const Icon(Icons.refresh),
          //     //         label: const Text('Retry'),
          //     //       ),
          //     //     ],
          //     //   ),
          //     // );
          //  DisplayMessage.errorMessage(
          //       state.error,
          //       context,
          //     );
          //     // return const SizedBox.shrink();
          //   }

          return Stack(
            children: [
              SingleChildScrollView(
                child: ScreenContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ProfileImageSection(
                        state: state,
                        onImageSelected: _handleImageSelected,
                      ),
                      const SizedBox(height: 32),
                      MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: sl<ProfileBloc>()),
                          BlocProvider.value(value: sl<DataSearchBloc>()),
                        ],
                        child: EditableFieldsSection(
                          state: state,
                          isLocationLoading: _isLocationLoading,
                          isOccupationLoading: _isOccupationLoading,
                          isSchoolLoading: _isSchoolLoading,
                          isDobLoading: _isDobLoading,
                          isLanguageLoading: _isLanguageLoading,
                          isInterestsLoading: _isInterestsLoading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, profileState) {
                  if (profileState is ProfileUpdating ||
                      profileState is ProfileLoading) {
                    return Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                profileState is ProfileLoading
                                    ? 'Loading profile...'
                                    : 'Updating profile...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
