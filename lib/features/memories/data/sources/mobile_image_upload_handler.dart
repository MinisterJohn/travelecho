import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'image_upload_handler.dart';

class MobileImageUploadHandler implements ImageUploadHandler {
  @override
  Future<http.MultipartFile> createMultipartFile(dynamic imageSource, String fieldName) async {
    if (imageSource is! String || !File(imageSource).existsSync()) {
      throw Exception('Invalid image path');
    }

    return await http.MultipartFile.fromPath(
      fieldName,
      imageSource,
      filename: path.basename(imageSource),
    );
  }
}
