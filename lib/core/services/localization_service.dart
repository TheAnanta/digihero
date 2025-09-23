import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  final Locale locale;
  late Map<String, dynamic> _localizedStrings;

  AppLocalizations(this.locale);

  // Helper method for accessing localized strings
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // List of supported locales
  static const List<Locale> supportedLocales = [
    Locale('en', ''), // English
    Locale('hi', ''), // Hindi
    Locale('pa', ''), // Punjabi
  ];

  // Load the language JSON file
  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap;
    return true;
  }

  // Helper method to get nested translations using dot notation
  String translate(String key) {
    List<String> keys = key.split('.');
    dynamic value = _localizedStrings;

    for (String k in keys) {
      if (value is Map<String, dynamic> && value.containsKey(k)) {
        value = value[k];
      } else {
        return key; // Return the key if translation not found
      }
    }

    return value.toString();
  }

  // Convenience methods for common translations
  String get appName => translate('app.name');
  String get appTagline => translate('app.tagline');
  String get appSubtitle => translate('app.subtitle');

  // Onboarding translations
  String get welcomeMessage => translate('onboarding.ageInput.welcome');
  String get welcomeDescription => translate('onboarding.ageInput.description');
  String get ageQuestion => translate('onboarding.ageInput.questionTitle');
  String get ageDescription =>
      translate('onboarding.ageInput.questionDescription');
  String get startLearning => translate('onboarding.ageInput.startButton');

  // Game home translations
  String get chooseLevel => translate('gameHome.chooseLevel');
  String get selectChallenge => translate('gameHome.selectChallenge');
  String get levelLocked => translate('gameHome.levelLocked');
  String get levelLockedMessage => translate('gameHome.levelLockedMessage');

  // Common translations
  String get ok => translate('common.ok');
  String get cancel => translate('common.cancel');
  String get yes => translate('common.yes');
  String get no => translate('common.no');
  String get excellent => translate('common.excellent');
  String get perfect => translate('common.perfect');
  String get great => translate('common.great');
  String get tryAgain => translate('common.tryAgain');
  String get loading => translate('common.loading');
  String get congratulations => translate('common.congratulations');

  // Level theme translations
  String getLevelTheme(String themeKey) => translate('levels.themes.$themeKey');
  String getLevelDescription(String themeKey) =>
      translate('levels.descriptions.$themeKey');

  // Unit translations
  String getUnit(int unitNumber) => translate('units.unit$unitNumber');

  // Character name translations
  String getCharacterName(String characterKey) =>
      translate('characters.names.$characterKey');

  // Device parts translations
  String getDevicePart(String partKey) =>
      translate('gameElements.deviceParts.$partKey');

  // Game instruction translations
  String getGameInstruction(String gameKey, String instructionKey) =>
      translate('games.$gameKey.$instructionKey');

  // Achievement translations
  String getAchievementTitle(String achievementKey) =>
      translate('achievements.$achievementKey.title');
  String getAchievementDescription(String achievementKey) =>
      translate('achievements.$achievementKey.description');

  // Place names - special handling for Nabha and local places
  String get nabha => translate('places.nabha');
  String get punjab => translate('places.punjab');
  String get chandigarh => translate('places.chandigarh');
  String get village => translate('places.village');
  String get city => translate('places.city');

  // Nabha-specific content (unique to Punjabi locale)
  String getNabhaContent(String contentKey) {
    if (locale.languageCode == 'pa') {
      return translate('nabhaSpecific.$contentKey');
    }
    // Fallback to general content for other languages
    return translate('places.$contentKey');
  }

  // Tip translations
  List<String> getTips(String tipCategory) {
    final tipsData = _localizedStrings['tips'][tipCategory];
    if (tipsData is List) {
      return tipsData.cast<String>();
    }
    return [];
  }

  // Sample word translations for typing games
  List<String> getTypingSamples(String sampleType) {
    final samplesData =
        _localizedStrings['games']['typingChallenge'][sampleType];
    if (samplesData is List) {
      return samplesData.cast<String>();
    }
    return [];
  }

  // Method to check if current locale is Punjabi (for Nabha-specific content)
  bool get isPunjabi => locale.languageCode == 'pa';
  bool get isHindi => locale.languageCode == 'hi';
  bool get isEnglish => locale.languageCode == 'en';

  // Age group translations
  String getAgeGroup(String difficultyLevel) =>
      translate('onboarding.ageInput.ageGroups.$difficultyLevel');

  String getAgeGroupDescription(String difficultyLevel) =>
      translate('onboarding.ageInput.ageGroupDescriptions.$difficultyLevel');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'hi', 'pa'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

// Extension method for easy access to translations
extension LocalizationExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}
