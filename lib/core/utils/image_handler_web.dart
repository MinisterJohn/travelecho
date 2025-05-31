// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:html' as html;
// import 'package:dartz/dartz.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get_it/get_it.dart';
// import 'image_handler.dart';

// class ImageHandlerWeb extends ImageHandler {
//   final SharedPreferences _prefs = GetIt.instance<SharedPreferences>();

//   Future<String?> _getToken() async {
//     final token = _prefs.getString('token');
//     return token != null && token.isNotEmpty ? 'Bearer $token' : null;
//   }

//   Future<http.MultipartFile> _createMultipartFile(
//       dynamic imageFile, String fieldName) async {
//     if (imageFile is XFile) {
//       final bytes = await imageFile.readAsBytes();
//       return http.MultipartFile.fromBytes(
//         fieldName,
//         bytes,
//         filename: imageFile.name,
//       );
//     } else if (imageFile is String && imageFile.startsWith('blob:')) {
//       final response = await html.HttpRequest.request(
//         imageFile,
//         method: 'GET',
//         responseType: 'arraybuffer',
//       );
//       final buffer = response.response as ByteBuffer;
//       final bytes = buffer.asUint8List();
//       return http.MultipartFile.fromBytes(
//         fieldName,
//         bytes,
//         filename: 'profile_image.jpg',
//       );
//     }

//     throw Exception('Invalid image file type for web.');
//   }

//   @override
//   Future<Either<String, Map<String, dynamic>>> uploadImage({
//     required String url,
//     required dynamic imageFile,
//     required String fieldName,
//     Map<String, String>? additionalFields,
//   }) async {
//     try {
//       final token = await _getToken();
//       if (token == null) return const Left('Authentication token is missing');

//       final uri = Uri.parse(url);
//       final request = http.MultipartRequest('PUT', uri)
//         ..headers['Authorization'] = token;

//       final multipartFile = await _createMultipartFile(imageFile, fieldName);
//       request.files.add(multipartFile);

//       if (additionalFields != null) {
//         request.fields.addAll(additionalFields);
//       }

//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();

//       if (response.statusCode == 200) {
//         return Right(jsonDecode(responseBody));
//       } else {
//         try {
//           final errorData = jsonDecode(responseBody);
//           return Left(errorData['message'] ?? 'Upload failed');
//         } catch (_) {
//           return Left('Upload failed with status: ${response.statusCode}');
//         }
//       }
//     } catch (e) {
//       return Left('Unexpected error: $e');
//     }
//   }
// }
