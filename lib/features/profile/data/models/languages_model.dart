class LanguageModel {
  final String language;

  LanguageModel({required this.language});

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(language: json['name'] as String);
  }
}

class LanguagesModel {
  final List<LanguageModel> languages;

  LanguagesModel({required this.languages});

  factory LanguagesModel.fromJson(Map<String, dynamic> json) {
    return LanguagesModel(
        languages: json.values
            .map((language) => LanguageModel.fromJson(language))
            .toList());
  }

  factory LanguagesModel.sort(
      LanguagesModel allLanguages, String languageHint) {
    return LanguagesModel(
        languages: allLanguages.languages
            .where((languageModel) => languageModel.language.contains(languageHint))
            .toList());
  }
  List<LanguageModel> toList() {
    return languages;
  }
}
