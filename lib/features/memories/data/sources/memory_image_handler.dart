import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'image_upload_handler.dart';
import 'web_image_upload_handler.dart';
import 'mobile_image_upload_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import "../../memories_exports.dart";
import 'dart:io' as io;

class MemoryImageHandler {
  final SharedPreferences _prefs = sl<SharedPreferences>();
  final ImageUploadHandler _imageUploadHandler;

  MemoryImageHandler()
      : _imageUploadHandler =
            kIsWeb ? WebImageUploadHandler() : MobileImageUploadHandler();

  Future<String?> _getToken() async {
    final token = await _prefs.getString('token');
    return token != null && token.isNotEmpty ? 'Bearer $token' : null;
  }

  Future<Either<String, void>> uploadMemoryImage({
    required String memoryId,
    required String imagePath,
  }) async {
    try {
      if (memoryId.isEmpty) {
        return const Left('Memory ID is required');
      }

      final token = await _getToken();
      if (token == null) {
        return const Left('Authentication token is missing');
      }

      print("Uploading image for memory ID: $memoryId");
      final uri = Uri.parse(
          'https://travel-echo-backend.onrender.com/api/memories/$memoryId/images');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = token;

      final multipartFile =
          await _imageUploadHandler.createMultipartFile(imagePath);
      request.files.add(multipartFile);

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print("Upload response status: ${response.statusCode}");
      print("Upload response body: $responseBody");

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(responseBody);
      }
    } catch (e) {
      print("Upload error: $e");
      return Left('An unexpected error occurred: $e');
    }
  }

  Future<Either<String, void>> uploadMultipleMemoryImages({
    required String memoryId,
    required List<dynamic> imagePaths,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) {
        return const Left('Authentication token is missing');
      }

      final uri = Uri.parse(
          'https://travel-echo-backend.onrender.com/api/memories/$memoryId/images');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = token;

      print('Starting upload for memory ID: $memoryId');
      print('Number of images to upload: ${imagePaths.length}');
      print('Image paths: $imagePaths');

      for (var i = 0; i < imagePaths.length; i++) {
        try {
          print('Processing image ${i + 1}/${imagePaths.length}');
          print('Image path type: ${imagePaths[i].runtimeType}');
          print('Image path value: ${imagePaths[i]}');

          final multipartFile =
              await _imageUploadHandler.createMultipartFile(imagePaths[i]);
          print('Created multipart file for image ${i + 1}');
          print('Multipart file field name: ${multipartFile.field}');
          print('Multipart file filename: ${multipartFile.filename}');
          print('Multipart file content type: ${multipartFile.contentType}');

          // For web, we need to handle the file differently
          if (kIsWeb) {
            // Create a new multipart file with the correct field name
            final webMultipartFile = http.MultipartFile(
              'file${i + 1}',
              multipartFile.finalize(),
              multipartFile.length,
              filename: multipartFile.filename,
              contentType: multipartFile.contentType,
            );
            request.files.add(webMultipartFile);
          } else {
            // For mobile, use the original multipart file
            request.files.add(multipartFile);
          }

          print('Successfully added image ${i + 1} to request');
        } catch (e) {
          print('Error processing image ${i + 1}: $e');
          print('Error stack trace: ${StackTrace.current}');
          return Left('Failed to process image ${i + 1}: $e');
        }
      }

      // Add memoryId as a form field
      request.fields['memoryId'] = memoryId;

      print("Sending request with ${request.files.length} files");
      print("Request fields: ${request.fields}");
      print("Request headers: ${request.headers}");

      // Log the complete request for debugging
      print("Complete request details:");
      print("URL: ${request.url}");
      print("Method: ${request.method}");
      print("Headers: ${request.headers}");
      print("Fields: ${request.fields}");
      print(
          "Files: ${request.files.map((f) => '${f.field}: ${f.filename}').join(', ')}");

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print("Upload response status: ${response.statusCode}");
      print("Upload response body: ${response.body}");

      if (response.statusCode == 200) {
        print('Successfully uploaded all images');
        return const Right(null);
      } else {
        try {
          final errorData = jsonDecode(response.body);
          final errorMessage =
              errorData['message'] ?? 'Failed to upload images';
          print('Upload failed with error: $errorMessage');
          return Left(errorMessage);
        } catch (e) {
          print('Failed to parse error response: $e');
          return Left('Failed to upload images: ${response.body}');
        }
      }
    } catch (e) {
      print("Upload error: $e");
      print("Error stack trace: ${StackTrace.current}");
      return Left('An unexpected error occurred: $e');
    }
  }
}
