import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../../profile_exports.dart";
import 'dart:io'; // For file handling
import '../widgets/profile_image_section.dart';
import '../widgets/editable_fields_section.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _isLocationLoading = false;
  bool _isOccupationLoading = false;
  bool _isSchoolLoading = false;
  bool _isDobLoading = false;
  bool _isLanguageLoading = false;
  bool _isInterestsLoading = false;

  Future<void> _handleImageSelected(File image) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileId = prefs.getString('profileId');

      if (profileId == null) {
        throw Exception('Profile ID not found');
      }

      final result =
          await sl<ProfileApiService>().updateProfileImage(profileId, image);
      result.fold(
        (error) => DisplayMessage.errorMessage(error, context),
        (data) => DisplayMessage.successMessage(
            "Profile photo updated successfully", context),
      );
    } catch (e) {
      if (mounted) {
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
          // if (state is ProfileLoading) {
          //   return const Center(child: CircularProgressIndicator());
          // }

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
