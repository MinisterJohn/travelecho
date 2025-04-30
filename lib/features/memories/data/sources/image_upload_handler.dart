import 'dart:typed_data';
import 'package:http/http.dart' as http;

abstract class ImageUploadHandler {
  Future<Uint8List> getImageBytes(dynamic imagePath);
  Future<http.MultipartFile> createMultipartFile(dynamic imagePath);
}
