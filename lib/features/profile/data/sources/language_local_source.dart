import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:travelecho/features/profile/data/models/languages_model.dart';

abstract class LanguageLocalSource {
  Future<LanguagesModel> fetchLanguages(String languageHint);
}

class LanguageLocalSourceImpl extends LanguageLocalSource {
  LanguagesModel allLanguages = LanguagesModel(languages: []);
  LanguagesModel sortedLanguages = LanguagesModel(languages: []);
  @override
  Future<LanguagesModel> fetchLanguages(String languageHint) async {
    if (allLanguages.languages.isEmpty) {
      final String response =
          await rootBundle.loadString('assets/json/occupations.json');
      final Map<String, dynamic> occupationsJsonData = json.decode(response);
      allLanguages = LanguagesModel.fromJson(occupationsJsonData);
    }
    sortedLanguages = LanguagesModel.sort(allLanguages, languageHint);
    return sortedLanguages;
  }
}
