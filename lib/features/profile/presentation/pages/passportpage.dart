import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'dart:io';

import 'package:travelecho/core/constants/appbar.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';

class PassportDetailsPage extends StatefulWidget {
  @override
  _PassportDetailsPageState createState() => _PassportDetailsPageState();
}

class _PassportDetailsPageState extends State<PassportDetailsPage> {
  File? _passportImage; // Store the selected passport image

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery, // Use ImageSource.camera for camera
      imageQuality: 85, // Optional: quality of the image
    );

    if (image != null) {
      setState(() {
        _passportImage =
            File(image.path); // Set the picked image to _passportImage
      });
    }
  }

  // Function to upload the image (you can integrate this with your backend)
  Future<void> _uploadImage() async {
    if (_passportImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first!')),
      );
      return;
    }

    // Here, you would send the image to your server or perform the necessary upload logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Uploading passport image...')),
    );

    // Simulate a delay for the upload process
    await Future.delayed(const Duration(seconds: 2));

    // Show a success message once the upload is complete
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Passport image uploaded successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Passport Details", context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Centered "Upload Passport Details" text
            WidgetsSpacer.verticalSpacer60,

            Center(
              child: Text(
                'Upload Passport Details',
                style: TextStyle(
                    fontSize: FontSize.size16, fontWeight: FontWeight.bold),
              ),
            ),
            WidgetsSpacer.verticalSpacer60,

            // Rectangle box containing the options with white background and grey shadow
            Container(
              width: double.infinity - 20.w,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.defaultColor100, // Grey shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 6, // Blur radius
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Scan or Upload Document',
                    style: TextStyle(
                      fontSize: FontSize.size16,
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Scan icon with text
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.document_scanner_outlined),
                            iconSize: 30.0, // Increase the size of the icon
                            onPressed: _pickImage,
                          ),
                          const Text(
                            'Scan',
                            style: TextStyle(
                                color: AppColors
                                    .primaryColor), // Set text color to purple
                          ),
                        ],
                      ),
                      // Upload icon with text
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.file_upload_outlined,
                                color: Colors.black),
                            iconSize: 30.0, // Increase the size of the icon
                            onPressed: _pickImage,
                          ),
                          const Text(
                            'Upload',
                            style: TextStyle(
                                color: AppColors
                                    .primaryColor), // Set text color to purple
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
