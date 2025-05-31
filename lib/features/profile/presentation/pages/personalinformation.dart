import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
// For image picking
import "../../profile_exports.dart";
// For file handling
import '../widgets/profile_image_section.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
          "Profile photo updated successfully", context);
    } catch (e) {
      if (mounted) {
        print('profile image update failed: $e');
        DisplayMessage.errorMessage(
            "Failed to update profile photo: $e", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailure) {
            DisplayMessage.errorMessage(state.error, context);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failed to load profile: ${state.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<ProfileBloc>().add(ProfileLoadRequested());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: ScreenContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                  EditableFieldsSection(
                    state: state,
                    isLocationLoading: _isLocationLoading,
                    isOccupationLoading: _isOccupationLoading,
                    isSchoolLoading: _isSchoolLoading,
                    isDobLoading: _isDobLoading,
                    isLanguageLoading: _isLanguageLoading,
                    isInterestsLoading: _isInterestsLoading,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
