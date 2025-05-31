import 'package:http/http.dart' as http;

abstract class ImageUploadHandler {
  Future<http.MultipartFile> createMultipartFile(dynamic imageSource, String fieldName);
}

// ImageUploadHandler getImageUploadHandler(); // implemented in platform-specific files
