import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/hoc/containerWidget.dart';
import 'package:travelecho/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:travelecho/features/profile/presentation/widgets/interests_dialog.dart';
import "package:travelecho/features/profile/presentation/widgets/location_dialog.dart";
import "package:travelecho/features/profile/presentation/widgets/work_location_dialog.dart";
import "package:travelecho/features/profile/presentation/widgets/school_location_dialog.dart";
import "package:travelecho/features/profile/presentation/widgets/date_dialog.dart";
import "package:travelecho/features/profile/presentation/widgets/language_dialog.dart";
import 'dart:io'; // For file handling

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _image; // Variable to hold the selected image

  // Function to pick an image from the camera
  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path); // Store the picked image
      });

      // Show notification once the profile photo is added
      _showProfilePhotoAddedNotification();
    }
  }

  // Function to show dialog for taking a picture
  void _showCameraDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Take a real-time picture",
            textAlign: TextAlign.center, // Center the text
            style: TextStyle(
              fontSize: 12, // Reduce font size to 12
            ),
          ),
          content: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _takePicture(); // Open the camera
            },
            child: const Text(
              "Open Camera",
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
        );
      },
    );
  }

  // Function to show dialog box for "Where I live"

// Function to show dialog box for "Where I work"

// Function to show dialog box for "Where I live"

  // Function to show the "Profile Photo Added" notification at the top
  void _showProfilePhotoAddedNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: AppColors.primaryColor),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Profile Photo Added",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.primaryColor,
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
            top: 16, left: 16, right: 16), // Position at the top
        duration: const Duration(seconds: 3),
      ),
    );
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
      body: SingleChildScrollView(
        child: ScreenContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centering the elements
                  children: [
                    Stack(
                      clipBehavior:
                          Clip.none, // Allow positioning outside the circle
                      children: [
                        CircleAvatar(
                          radius: 50, // Increased size of the circle
                          backgroundColor:
                              const Color.fromARGB(255, 156, 126, 126),
                          backgroundImage: _image != null
                              ? FileImage(_image!)
                              : null, // Display the selected image
                        ),
                        Positioned(
                          bottom: -15,
                          left: 15, // Align the icon and text at the left side
                          child: GestureDetector(
                            onTap: _showCameraDialog,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 3), // Padding inside the rectangle
                              decoration: BoxDecoration(
                                color: Colors
                                    .white, // Background color of the rectangle
                                borderRadius: BorderRadius.circular(
                                    30), // Smooth rounded corners
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                        0.3), // Light shadow for effect
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset:
                                        const Offset(0, 2), // Shadow position
                                  ),
                                ],
                              ),
                              child: const Row(
                                // Keep the camera icon and text together
                                children: [
                                  SizedBox(
                                    width: 20,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 25,
                                      color: Colors
                                          .black, // Set camera icon color to black
                                    ),
                                  ),
                                  WidgetsSpacer
                                      .horinzontalSpacer8, // Space between camera icon and "Add" text
                                  Text(
                                    "Add", // Add text next to the camera icon
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _buildEditableField(
                icon: LineIcons.home,
                title: "Where I live",
                onTap: () {
                  showWhereILiveDialog(context);
                }, // Show dialog for location
              ),
              Divider(color: AppColors.defaultColor100),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return _buildEditableField(
                    icon: LineIcons.briefcase,
                    title: state.profile.occupation.isEmpty
                        ? "My occupation"
                        : state.profile.occupation,
                    onTap: () {
                      showWhereIWorkDialog(context);
                    }, // Show dialog for work location
                  );
                },
              ),
              Divider(color: AppColors.defaultColor100),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return _buildEditableField(
                    icon: LineIcons.graduationCap,
                    title: state.profile.school.name.isEmpty
                        ? "Where I schooled"
                        : "${state.profile.school.name} - ${state.profile.school.country}",
                    onTap: () {
                      showWhereISchooledDialog(context);
                    }, // Show dialog for school location
                  );
                },
              ),
              Divider(color: AppColors.defaultColor100),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return _buildEditableField(
                    icon: LineIcons.birthdayCake,
                    title: "Date of Birth",
                    onTap: () {
                      showDateDialog(context);
                    },
                  );
                },
              ),
              Divider(color: AppColors.defaultColor100),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return _buildEditableField(
                    icon: LineIcons.language,
                    title: state.profile.languages.isEmpty
                        ? "Language I speak"
                        : state.profile.languages
                            .map((lang) => lang.language)
                            .join(", "),
                    onTap: () {
                      showLanguageDialog(context);
                    },
                  );
                },
              ),
              Divider(color: AppColors.defaultColor100),
              _buildEditableField(
                icon: LineIcons.shapes,
                title: "Interests",
                onTap: () {
                  // Navigate to the InterestSelectionPage when tapped
                  showInterestsDialog(context);
                },
                hasArrow: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool hasArrow = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.defaultColor),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.secondaryColor),
      ),
      trailing: hasArrow
          ? Icon(Icons.chevron_right, color: AppColors.defaultColor400)
          : null,
      onTap: onTap,
    );
  }
}
