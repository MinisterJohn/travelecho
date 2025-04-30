import '../../profile_exports.dart';

class LanguagesRepositoryImpl extends LanguagesRepository {
  final LanguageLocalSource languageLocalSource = sl<LanguageLocalSource>();
  @override
  Future<LanguagesModel> getLanguages(String languageHint) async {
    final languagesModel =
        await languageLocalSource.fetchLanguages(languageHint);
    return languagesModel;
  }
}
