import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'image_upload_handler.dart';

class WebImageUploadHandler implements ImageUploadHandler {
  @override
  Future<Uint8List> getImageBytes(dynamic imagePath) async {
    print('Getting image bytes for: $imagePath');
    if (imagePath is String) {
      if (imagePath.startsWith('blob:')) {
        print('Processing blob URL');
        return await _blobUrlToBytes(imagePath);
      } else {
        print('Processing file path');
        return await _filePathToBytes(imagePath);
      }
    } else if (imagePath is Uint8List) {
      print('Processing Uint8List data');
      return imagePath;
    }
    print('Invalid image format: ${imagePath.runtimeType}');
    throw Exception('Invalid image format for web: ${imagePath.runtimeType}');
  }

  @override
  Future<http.MultipartFile> createMultipartFile(dynamic imagePath) async {
    print('Creating multipart file for: $imagePath');
    final bytes = await getImageBytes(imagePath);
    print('Image bytes length: ${bytes.length}');

    // Try to determine the content type from the image data
    String contentType = 'image/jpeg';
    String extension = 'jpg';

    if (bytes.length >= 2) {
      if (bytes[0] == 0xFF && bytes[1] == 0xD8) {
        contentType = 'image/jpeg';
        extension = 'jpg';
      } else if (bytes[0] == 0x89 && bytes[1] == 0x50) {
        contentType = 'image/png';
        extension = 'png';
      } else if (bytes[0] == 0x47 && bytes[1] == 0x49) {
        contentType = 'image/gif';
        extension = 'gif';
      }
    }

    print('Using content type: $contentType');
    print('Using file extension: $extension');

    try {
      // Create a stream from the bytes
      final stream = Stream.fromIterable([bytes]);

      // Create the multipart file with proper content type and filename
      final multipartFile = http.MultipartFile(
        'file', // This will be overridden by the MemoryImageHandler
        stream,
        bytes.length,
        filename: 'image.$extension',
        contentType: MediaType(
          contentType.split('/')[0],
          contentType.split('/')[1],
        ),
      );

      print('Successfully created multipart file');
      print('Multipart file details:');
      print('- Field name: ${multipartFile.field}');
      print('- Filename: ${multipartFile.filename}');
      print('- Content type: ${multipartFile.contentType}');
      print('- Length: ${bytes.length} bytes');

      return multipartFile;
    } catch (e) {
      print('Error creating multipart file: $e');
      print('Error stack trace: ${StackTrace.current}');
      rethrow;
    }
  }

  Future<Uint8List> _blobUrlToBytes(String blobUrl) async {
    print('Converting blob URL to bytes: $blobUrl');
    final completer = Completer<Uint8List>();
    final xhr = html.HttpRequest();

    xhr
      ..open('GET', blobUrl)
      ..responseType = 'arraybuffer'
      ..onLoad.listen((event) {
        print('Successfully loaded blob data');
        completer.complete(xhr.response as Uint8List);
      })
      ..onError.listen((e) {
        print('Error loading blob: $e');
        completer.completeError('Failed to load blob: $e');
      })
      ..send();

    return completer.future;
  }

  Future<Uint8List> _filePathToBytes(String filePath) async {
    print('Converting file path to bytes: $filePath');
    final completer = Completer<Uint8List>();

    try {
      // Create a file input element
      final input = html.FileUploadInputElement();
      input.accept = 'image/*';

      // Create a file object from the path
      final file = html.File([], filePath);

      // Read the file
      final reader = html.FileReader();
      reader.onLoad.listen((event) {
        print('Successfully read file data');
        completer.complete(reader.result as Uint8List);
      });
      reader.onError.listen((e) {
        print('Error reading file: $e');
        completer.completeError('Failed to read file: $e');
      });
      reader.readAsArrayBuffer(file);

      return completer.future;
    } catch (e) {
      print('Error processing file path: $e');
      print('Error stack trace: ${StackTrace.current}');
      rethrow;
    }
  }
}
