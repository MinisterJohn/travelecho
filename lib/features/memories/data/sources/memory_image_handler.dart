import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'image_upload_handler.dart'
    if (dart.library.html) 'web_image_upload_handler.dart';
import '../../memories_exports.dart';

ImageUploadHandler getImageUploadHandler() {
  // if (kIsWeb) {
  //   return WebImageUploadHandler();
  // } else {
    return MobileImageUploadHandler();
  // }
}

class MemoryImageHandler {
  final SharedPreferences _prefs = sl<SharedPreferences>();
  final ImageUploadHandler _imageUploadHandler;

  MemoryImageHandler() : _imageUploadHandler = getImageUploadHandler();

  Future<String?> _getToken() async {
    final token = _prefs.getString('token');
    return token != null && token.isNotEmpty ? 'Bearer $token' : null;
  }

  Future<Either<String, void>> uploadMultipleMemoryImages({
    required String memoryId,
    required List<dynamic> imagePaths,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) return const Left('Authentication token is missing');

      final uri = Uri.parse(ApiUrl.fullUrl(ApiUrl.memoryImageURL(memoryId)));
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = token;

      print('Uploading images for memory ID: $memoryId');

      for (var i = 0; i < imagePaths.length; i++) {
        try {
          final multipartFile = await _imageUploadHandler.createMultipartFile(
              imagePaths[i], 'image[]');
          request.files.add(multipartFile);
        } catch (e) {
          return Left('Failed to process image ${i + 1}: $e');
        }
      }

      request.fields['memoryId'] = memoryId;
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("Response status: ${response.statusCode}");
      print("Response body: $responseBody");

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        try {
          final errorData = jsonDecode(responseBody);
          return Left(errorData['message'] ?? 'Upload failed');
        } catch (_) {
          return Left('Upload failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }
}
