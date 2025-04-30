import 'dart:io' as io;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'image_upload_handler.dart';

class MobileImageUploadHandler implements ImageUploadHandler {
  @override
  Future<Uint8List> getImageBytes(dynamic imagePath) async {
    print('Getting image bytes for: $imagePath');
    if (imagePath is! String) {
      print('Invalid image path format: ${imagePath.runtimeType}');
      throw Exception(
          'Invalid image path format for mobile: ${imagePath.runtimeType}');
    }
    print('Reading file from path: $imagePath');
    final file = io.File(imagePath);
    if (!await file.exists()) {
      print('File does not exist at path: $imagePath');
      throw Exception('File does not exist at path: $imagePath');
    }
    final fileSize = await file.length();
    print('File size: $fileSize bytes');
    final bytes = await file.readAsBytes();
    print('Successfully read ${bytes.length} bytes from file');
    return bytes;
  }

  @override
  Future<http.MultipartFile> createMultipartFile(dynamic imagePath) async {
    print('Creating multipart file for: $imagePath');
    if (imagePath is! String) {
      print('Invalid image path format: ${imagePath.runtimeType}');
      throw Exception(
          'Invalid image path format for mobile: ${imagePath.runtimeType}');
    }
    final file = io.File(imagePath);
    if (!await file.exists()) {
      print('File does not exist at path: $imagePath');
      throw Exception('File does not exist at path: $imagePath');
    }
    final fileSize = await file.length();
    print('File size: $fileSize bytes');

    final mimeType = _getMimeType(file.path);
    print('Using mime type: $mimeType for file: ${file.path}');

    try {
      final multipartFile = await http.MultipartFile.fromPath(
        'files',
        file.path,
        contentType: MediaType(
          mimeType.split('/')[0],
          mimeType.split('/')[1],
        ),
      );
      print('Successfully created multipart file');
      print('Multipart file field name: ${multipartFile.field}');
      print('Multipart file filename: ${multipartFile.filename}');
      print('Multipart file content type: ${multipartFile.contentType}');
      return multipartFile;
    } catch (e) {
      print('Error creating multipart file: $e');
      print('Error stack trace: ${StackTrace.current}');
      rethrow;
    }
  }

  String _getMimeType(String path) {
    print('Determining mime type for path: $path');
    final extension = path.split('.').last.toLowerCase();
    print('File extension: $extension');

    switch (extension) {
      case 'png':
        print('Detected PNG image');
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        print('Detected JPEG image');
        return 'image/jpeg';
      case 'gif':
        print('Detected GIF image');
        return 'image/gif';
      default:
        print('Unknown file type, using default mime type');
        return 'application/octet-stream';
    }
  }
}
