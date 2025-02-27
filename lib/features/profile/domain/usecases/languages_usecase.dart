import 'package:travelecho/features/profile/data/models/languages_model.dart';
import 'package:travelecho/features/profile/domain/repository/languages_repository.dart';
import 'package:travelecho/service_locator.dart';

class GetLanguages {
  Future<List<LanguageModel>> getLanguagesList(String languageHint) async {
    final languagesModel =
        await sl<LanguagesRepository>().getLanguages(languageHint);

    return languagesModel.toList();
  }
}
