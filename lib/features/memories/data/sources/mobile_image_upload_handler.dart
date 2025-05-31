import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'image_upload_handler.dart';

class MobileImageUploadHandler implements ImageUploadHandler {
  @override
  Future<http.MultipartFile> createMultipartFile(dynamic imagePath, String fieldName) async {
    print('Creating multipart file for image: $imagePath');
    if (imagePath.path is! String) throw Exception('Invalid path');
    return await http.MultipartFile.fromPath(
      fieldName,
      imagePath.path,
      filename: path.basename(imagePath.path),
    );
  }
}

ImageUploadHandler getImageUploadHandler() => MobileImageUploadHandler();
