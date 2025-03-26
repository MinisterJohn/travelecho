import '../../profile_exports.dart';


class GetLanguages {
  Future<List<LanguageModel>> getLanguagesList(String languageHint) async {
    final languagesModel =
        await sl<LanguagesRepository>().getLanguages(languageHint);

    return languagesModel.toList();
  }
}
