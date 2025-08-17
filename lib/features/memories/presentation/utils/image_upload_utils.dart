// lib/utils/image_utils.dart
import 'package:image_picker/image_picker.dart';

bool _areImagesEqual(List<dynamic> selectedImages, List<dynamic>? existingImages) {
  if (selectedImages.length != (existingImages?.length ?? 0)) {
    return false;
  }

  for (int i = 0; i < selectedImages.length; i++) {
    final selectedImage = selectedImages[i];
    final existingImage = existingImages![i];

    if (selectedImage is XFile && existingImage is XFile) {
      if (selectedImage.path != existingImage.path) {
        return false;
      }
    } else if (selectedImage is Map<String, dynamic> &&
        existingImage is Map<String, dynamic>) {
      if (selectedImage['url'] != existingImage['url']) {
        return false;
      }
    } else {
      return false;
    }
  }

  return true;
}

// expose
bool areImagesEqual(List<dynamic> a, List<dynamic>? b) => _areImagesEqual(a, b);
