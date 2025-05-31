import 'package:dartz/dartz.dart';


abstract class ImageHandler {
  Future<Either<String, Map<String, dynamic>>> uploadImage({
    required String url,
    required dynamic imageFile,
    required String fieldName,
    Map<String, String>? additionalFields,
  });
}
