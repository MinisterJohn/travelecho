import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get_it/get_it.dart';
import 'dart:html' as html;
import 'dart:typed_data';

class ImageHandler {
  final SharedPreferences _prefs = GetIt.instance<SharedPreferences>();

  Future<String?> _getToken() async {
    final token = _prefs.getString('token');
    return token != null && token.isNotEmpty ? 'Bearer $token' : null;
  }

  Future<http.MultipartFile> _createMultipartFile(
      dynamic imageFile, String fieldName) async {
    if (kIsWeb) {
      if (imageFile is XFile) {
        final bytes = await imageFile.readAsBytes();
        return http.MultipartFile.fromBytes(
          fieldName,
          bytes,
          filename: imageFile.name,
        );
      } else if (imageFile is String && imageFile.startsWith('blob:')) {
        // Handle blob URL
        final response = await html.HttpRequest.request(
          imageFile,
          method: 'GET',
          responseType: 'arraybuffer',
        );
        final buffer = response.response as ByteBuffer;
        final bytes = buffer.asUint8List();
        return http.MultipartFile.fromBytes(
          fieldName,
          bytes,
          filename: 'profile_image.jpg',
        );
      }
    } else {
      if (imageFile is File) {
        return http.MultipartFile.fromPath(
          fieldName,
          imageFile.path,
          filename: imageFile.path.split('/').last,
        );
      }
    }
    throw Exception('Invalid image file type');
  }

  Future<Either<String, Map<String, dynamic>>> uploadImage({
    required String url,
    required dynamic imageFile,
    required String fieldName,
    Map<String, String>? additionalFields,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) return const Left('Authentication token is missing');

      final uri = Uri.parse(url);
      final request = http.MultipartRequest('PUT', uri)
        ..headers['Authorization'] = token;

      print('Uploading image to: $url');

      try {
        final multipartFile = await _createMultipartFile(imageFile, fieldName);
        request.files.add(multipartFile);
      } catch (e) {
        return Left('Failed to process image: $e');
      }

      if (additionalFields != null) {
        request.fields.addAll(additionalFields);
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("Response status: ${response.statusCode}");
      print("Response body: $responseBody");

      if (response.statusCode == 200) {
        return Right(jsonDecode(responseBody));
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
