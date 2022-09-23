import 'dart:ui';

import 'package:choobietalker/shared/model/google_language.dart';
import 'package:google_fonts/google_fonts.dart';

class Constant {
  List<String> get languageCodes => [
        'arb',
        'cmn-CN',
        'cy-GB',
        'da-DK',
        'de-DE',
        'en-AU',
        'en-GB',
        'en-GB-WLS',
        'en-IN',
        'en-US',
        'es-ES',
        'es-MX',
        'es-US',
        'fr-CA',
        'fr-FR',
        'is-IS',
        'it-IT',
        'ja-JP',
        'hi-IN',
        'ko-KR',
        'nb-NO',
        'nl-NL',
        'pl-PL',
        'pt-BR',
        'pt-PT',
        'ro-RO',
        'ru-RU',
        'sv-SE',
        'tr-TR',
        'en-NZ',
        'en-ZA'
      ];

  List<String> get fonts =>
      ['Roboto', 'Open Sans', 'Montserrat', 'Lato', 'Anton'];

  List<FontWeight> get fontWeights => FontWeight.values;

  List<GoogleLanguage> get googleLanguages => [
        GoogleLanguage(name: 'English', code: 'en'),
        GoogleLanguage(name: 'Japanese', code: 'ja'),
        GoogleLanguage(name: 'Korean', code: 'ko'),
        GoogleLanguage(name: 'Tagalog', code: 'tl'),
      ];
}
