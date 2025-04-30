import 'package:equatable/equatable.dart';

class LanguageModel extends Equatable {
  final String language;
  final String code;

  const LanguageModel({required this.language, required this.code});

  factory LanguageModel.fromJson(String code, Map<String, dynamic> json) {
    return LanguageModel(
      language: json['name'] as String,
      code: code,
    );
  }

  @override
  List<Object?> get props => [language, code];
}

class LanguagesModel extends Equatable {
  final List<LanguageModel> languages;

  const LanguagesModel({required this.languages});

  factory LanguagesModel.fromJson(Map<String, dynamic> json) {
    final List<LanguageModel> languageList = json.entries
        .map((entry) => LanguageModel.fromJson(
            entry.key, entry.value as Map<String, dynamic>))
        .toList();
    return LanguagesModel(languages: languageList);
  }

  factory LanguagesModel.sort(
      LanguagesModel allLanguages, String languageHint) {
    return LanguagesModel(
      languages: allLanguages.languages
          .where((language) => language.language
              .toLowerCase()
              .contains(languageHint.toLowerCase()))
          .toList(),
    );
  }

  List<String> toList() {
    return languages.map((lang) => lang.language).toList();
  }

  @override
  List<Object?> get props => [languages];
}
