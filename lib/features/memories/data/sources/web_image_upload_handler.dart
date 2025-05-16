import 'dart:async';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'image_upload_handler.dart';

class WebImageUploadHandler implements ImageUploadHandler {
  @override
  Future<http.MultipartFile> createMultipartFile(
      dynamic imageFile, String fieldName) async {
    if (imageFile is XFile) {
      final completer = Completer<http.MultipartFile>();
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        if (reader.result != null) {
          final bytes = reader.result as List<int>;
          final multipartFile = http.MultipartFile.fromBytes(
            fieldName,
            bytes,
            filename: imageFile.name,
          );
          completer.complete(multipartFile);
        } else {
          completer.completeError('Failed to read file data');
        }
      });

      reader.onError.listen((event) {
        completer.completeError('Error reading file: ${reader.error}');
      });

      final bytes = await imageFile.readAsBytes();
      reader.readAsArrayBuffer(html.Blob([bytes]));
      return completer.future;
    } else {
      throw Exception('Invalid image file for web');
    }
  }
}
