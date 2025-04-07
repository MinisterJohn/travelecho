import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/country_model.dart';
import '../../trip_exports.dart';

class CountryService {
  static Future<List<Country>> loadCountries() async {
    try {
      // Try to load from assets first
      final String jsonString =
          await rootBundle.loadString('assets/data/countries.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Country.fromJson(json)).toList();
    } catch (e) {
      print('Error loading countries from assets: $e');
      // If loading from assets fails, try to load from the embedded JSON
      try {
        final String jsonString = await rootBundle
            .loadString('lib/features/trip/data/models/countries.json');
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((json) => Country.fromJson(json)).toList();
      } catch (e) {
        print('Error loading countries from embedded JSON: $e');
        // If both methods fail, return default countries
        return _getDefaultCountries();
      }
    }
  }

  static List<Country> _getDefaultCountries() {
    return [
      Country(
        name: 'United States',
        code: 'US',
        phoneCode: '1',
        flag: '🇺🇸',
      ),
      Country(
        name: 'United Kingdom',
        code: 'GB',
        phoneCode: '44',
        flag: '🇬🇧',
      ),
      Country(
        name: 'Canada',
        code: 'CA',
        phoneCode: '1',
        flag: '🇨🇦',
      ),
      Country(
        name: 'Australia',
        code: 'AU',
        phoneCode: '61',
        flag: '🇦🇺',
      ),
      Country(
        name: 'India',
        code: 'IN',
        phoneCode: '91',
        flag: '🇮🇳',
      ),
      Country(
        name: 'China',
        code: 'CN',
        phoneCode: '86',
        flag: '🇨🇳',
      ),
      Country(
        name: 'Japan',
        code: 'JP',
        phoneCode: '81',
        flag: '🇯🇵',
      ),
      Country(
        name: 'Germany',
        code: 'DE',
        phoneCode: '49',
        flag: '🇩🇪',
      ),
      Country(
        name: 'France',
        code: 'FR',
        phoneCode: '33',
        flag: '🇫🇷',
      ),
      Country(
        name: 'Italy',
        code: 'IT',
        phoneCode: '39',
        flag: '🇮🇹',
      ),
      Country(
        name: 'Spain',
        code: 'ES',
        phoneCode: '34',
        flag: '🇪🇸',
      ),
      Country(
        name: 'Brazil',
        code: 'BR',
        phoneCode: '55',
        flag: '🇧🇷',
      ),
      Country(
        name: 'Mexico',
        code: 'MX',
        phoneCode: '52',
        flag: '🇲🇽',
      ),
      Country(
        name: 'South Korea',
        code: 'KR',
        phoneCode: '82',
        flag: '🇰🇷',
      ),
      Country(
        name: 'Russia',
        code: 'RU',
        phoneCode: '7',
        flag: '🇷🇺',
      ),
    ];
  }
}
