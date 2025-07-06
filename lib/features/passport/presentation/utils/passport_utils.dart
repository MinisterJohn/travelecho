import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<Map?> getCountryFlag(String nationality) async {
  final String data = await rootBundle.loadString('assets/json/countries.json');
  final List countries = json.decode(data);
  final country = countries.firstWhere(
    (c) => (c['name'] as String).toLowerCase() == nationality.toLowerCase(),
    orElse: () => null,
  );
  return country;
}

IconData getTypeIcon(String? type) {
  final found = travelDocuments.firstWhere(
    (e) => e['title'].toLowerCase().contains((type as String).toLowerCase()),
    orElse: () => {'icon': LineIcons.passport},
  );
  return found['icon'] as IconData;
}

// final List<Map<String, dynamic>> travelDocuments = [
//   {
//     'icon': LineIcons.passport,
//     'title': 'REGULAR',
//     'description': 'For regular citizens traveling for tourism, business, or study.',
//   },
//   {
//     'icon': LineIcons.briefcase,
//     'title': 'OFFICIAL',
//     'description': 'Issued to government officials on official duty.',
//   },
//   {
//     'icon': LineIcons.certificate,
//     'title': 'DIPLOMATIC',
//     'description': 'For diplomats and consuls with diplomatic immunity.',
//   },
//   {
//     'icon': LineIcons.cog,
//     'title': 'SERVICE',
//     'description': 'Issued for government service or official missions.',
//   },
//   {
//     'icon': LineIcons.exclamationTriangle,
//     'title': 'EMERGENCY',
//     'description': 'Temporary document for urgent or lost-passport travel.',
//   },
// ];

final List<Map<String, dynamic>> travelDocuments = [
  // 1. Passports
  {
    'icon': LineIcons.passport,
    'title': 'Ordinary Passport',
    'description':
        'For citizens traveling internationally for tourism, business, or study.',
  },
  {
    'icon': LineIcons.certificate,
    'title': 'Diplomatic Passport',
    'description': 'For diplomats and consular staff with diplomatic immunity.',
  },
  {
    'icon': LineIcons.briefcase,
    'title': 'Official/Service Passport',
    'description': 'Issued to government officials on official duty.',
  },
  {
    'icon': LineIcons.exclamationTriangle,
    'title': 'Emergency Passport',
    'description':
        'For citizens stranded abroad or with lost/stolen passports.',
  },
  {
    'icon': LineIcons.clock,
    'title': 'Temporary Passport',
    'description':
        'Short-validity passport for specific journeys or urgent needs.',
  },
  {
    'icon': LineIcons.users,
    'title': 'Collective Passport',
    'description':
        'For organized groups traveling together, such as school trips.',
  },
  {
    'icon': LineIcons.userShield,
    'title': 'Refugee Travel Document',
    'description': 'For refugees recognized under the 1951 Convention.',
  },
  {
    'icon': LineIcons.identificationBadge,
    'title': 'Travel Document for Stateless Persons',
    'description': 'For stateless individuals under the 1954 Convention.',
  },
  {
    'icon': LineIcons.userSlash,
    'title': 'Alien’s Passport',
    'description':
        'For non-citizens or residents without national passport access.',
  },
  {
    'icon': LineIcons.syncIcon,
    'title': 'Provisional/One-Time Passport',
    'description': 'Issued for single journeys or urgent repatriation.',
  },
  {
    'icon': LineIcons.star,
    'title': 'Special Passport',
    'description': 'For special government missions or authorized projects.',
  },
  {
    'icon': LineIcons.mosque,
    'title': 'Hajj Passport (historical)',
    'description': 'Previously issued for pilgrims traveling to Mecca.',
  },
  {
    'icon': LineIcons.history,
    'title': 'Nansen Passport (historical)',
    'description': 'Historic refugee document issued after World War I.',
  },

  // 2. Visas & Authorizations
  {
    'icon': LineIcons.stamp,
    'title': 'Tourist Visa',
    'description': 'Permits short-term leisure travel to a foreign country.',
  },
  {
    'icon': LineIcons.briefcase,
    'title': 'Business Visa',
    'description': 'For attending business meetings or conferences.',
  },
  {
    'icon': LineIcons.planeDeparture,
    'title': 'Transit Visa',
    'description': 'For passing through a country en route to another.',
  },
  {
    'icon': LineIcons.graduationCap,
    'title': 'Student Visa',
    'description': 'For academic study in another country.',
  },
  {
    'icon': LineIcons.hardHat,
    'title': 'Work Visa',
    'description': 'For employment in a foreign country.',
  },
  {
    'icon': LineIcons.home,
    'title': 'Resident Visa/Permit',
    'description': 'Allows long-term living in another country.',
  },
  {
    'icon': LineIcons.alternateShield,
    'title': 'Diplomatic Visa',
    'description': 'Granted to accredited diplomats and consuls.',
  },
  {
    'icon': LineIcons.handHoldingHeart,
    'title': 'Humanitarian Visa',
    'description': 'For refugees or medical evacuees.',
  },
  {
    'icon': LineIcons.alternateMobile,
    'title': 'Electronic Visa (e-Visa)',
    'description': 'Digital application for travel authorization.',
  },
  {
    'icon': LineIcons.checkCircle,
    'title': 'Visa on Arrival',
    'description': 'Granted at the border of the destination country.',
  },
  {
    'icon': LineIcons.cloud,
    'title': 'Electronic Travel Authorization (ETA/ESTA/ETIAS)',
    'description': 'Pre-approval for visa-exempt travelers.',
  },

  // 3. Health & Vaccination Certificates
  {
    'icon': LineIcons.syringe,
    'title': 'Yellow Card',
    'description':
        'International Certificate of Vaccination (e.g. Yellow Fever).',
  },
  {
    'icon': LineIcons.biohazard,
    'title': 'COVID-19 Certificate',
    'description': 'Proof of vaccination or negative test.',
  },
  {
    'icon': LineIcons.dna,
    'title': 'Other Disease Certificates',
    'description': 'For region-specific requirements (e.g. Polio, Meningitis).',
  },

  // 4. Laissez-Passer Documents
  {
    'icon': LineIcons.globe,
    'title': 'United Nations Laissez-passer (UNLP)',
    'description': 'Official travel document for UN personnel.',
  },
  {
    'icon': LineIcons.flag,
    'title': 'EU Laissez-passer',
    'description': 'Issued to EU civil servants on official duty.',
  },
  {
    'icon': LineIcons.users,
    'title': 'African Union Laissez-passer',
    'description': 'For AU officials on missions.',
  },
  {
    'icon': LineIcons.users,
    'title': 'Organization of American States Laissez-passer',
    'description': 'For OAS personnel on duty.',
  },

  // 5. Certificates of Identity & Other Alternatives
  {
    'icon': LineIcons.identificationBadge,
    'title': 'Certificate of Identity',
    'description': 'Alternative travel document for non-citizens.',
  },
  {
    'icon': LineIcons.reply,
    'title': 'Re-entry Permit',
    'description': 'Allows residents to re-enter after travel abroad.',
  },
  {
    'icon': LineIcons.alternateSignOut,
    'title': 'Exit Permit',
    'description': 'Authorizes departure from certain countries.',
  },
  {
    'icon': LineIcons.passport,
    'title': 'Temporary Travel Document',
    'description':
        'Issued for one-time travel when no other passport is available.',
  },

  // 6. Group & Pilgrimage Documents
  {
    'icon': LineIcons.users,
    'title': 'Pilgrimage Pass',
    'description': 'For religious groups traveling together.',
  },
  {
    'icon': LineIcons.school,
    'title': 'School Group Passport',
    'description': 'For organized educational trips (historical use).',
  },

  // 7. Border & Regional Travel Cards
  {
    'icon': LineIcons.mapMarker,
    'title': 'Border Pass',
    'description': 'For local cross-border communities.',
  },
  {
    'icon': LineIcons.identificationCard,
    'title': 'EU National ID Card',
    'description': 'Used for travel within the Schengen Area.',
  },
  {
    'icon': LineIcons.identificationCardAlt,
    'title': 'GCC ID Card',
    'description': 'For travel among Gulf Cooperation Council states.',
  },
  {
    'icon': LineIcons.identificationBadge,
    'title': 'CARICOM Travel Card',
    'description': 'For regional travel in the Caribbean.',
  },

  // 8. Digital/Electronic Travel Documents
  {
    'icon': LineIcons.microchip,
    'title': 'E-Passport',
    'description': 'Biometric passport with embedded chip.',
  },
  {
    'icon': LineIcons.mobilePhone,
    'title': 'Digital ID for Border Crossing',
    'description': 'App-based or electronic ID for crossing borders.',
  },
];

String? validateTravelDocumentNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your travel document number';
  }
  final pattern = RegExp(r'^[A-Z0-9]{6,9}$', caseSensitive: false);
  if (!pattern.hasMatch(value)) {
    return 'Invalid travel document number format';
  }
  return null;
}
