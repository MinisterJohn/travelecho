import 'dart:convert';

import 'package:flutter/services.dart';
import '../../profile_exports.dart';

abstract class LanguageLocalSource {
  Future<LanguagesModel> fetchLanguages(String languageHint);
}

class LanguageLocalSourceImpl extends LanguageLocalSource {
  LanguagesModel allLanguages = const LanguagesModel(languages: []);
  LanguagesModel sortedLanguages = const LanguagesModel(languages: []);
  @override
  Future<LanguagesModel> fetchLanguages(String languageHint) async {
    if (allLanguages.languages.isEmpty) {
      final String response =
          await rootBundle.loadString('assets/json/language-list-json.json');
      final Map<String, dynamic> languagesJsonData = json.decode(response);
      allLanguages = LanguagesModel.fromJson(languagesJsonData);
    }
    sortedLanguages = LanguagesModel.sort(allLanguages, languageHint);
    return sortedLanguages;
  }
}
