import 'package:travelecho/features/profile/data/models/languages_model.dart';
import 'package:travelecho/features/profile/data/sources/language_local_source.dart';
import 'package:travelecho/features/profile/domain/repository/languages_repository.dart';
import 'package:travelecho/service_locator.dart';

class LanguagesRepositoryImpl extends LanguagesRepository {
  final LanguageLocalSource occupationsLocalSource = sl<LanguageLocalSource>();
  @override
  Future<LanguagesModel> getLanguages(String languageHint) async {
    final languagesModel =
        await occupationsLocalSource.fetchLanguages(languageHint);
    return LanguagesModel(languages: languagesModel.toList());
  }
}
