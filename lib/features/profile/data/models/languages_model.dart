import 'package:equatable/equatable.dart';

class LanguageModel extends Equatable {
  final String language;

  const LanguageModel({required this.language});

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(language: json['name'] as String);
  }

  @override
  List<Object?> get props => [language];
}

class LanguagesModel extends Equatable {
  final List<LanguageModel> languages;

  const LanguagesModel({required this.languages});

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
            .where((languageModel) => languageModel.language
                .toLowerCase()
                .contains(languageHint.toLowerCase()))
            .toList());
  }
  List<LanguageModel> toList() {
    return languages;
  }

  @override
  List<Object?> get props => [languages];
}
