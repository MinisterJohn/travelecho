import 'package:travelecho/features/profile/domain/repository/languages_repository.dart';
import 'package:travelecho/service_locator.dart';

class GetLanguages {
  Future getLanguagesList(String languageHint) {
    final languageslist =
        sl<LanguagesRepository>().getLanguages(languageHint);

    return languageslist;
  }
}
