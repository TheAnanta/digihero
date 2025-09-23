import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  static const String _languageKey = 'selected_language';

  Locale _currentLocale = const Locale('en'); // Default to English

  Locale get currentLocale => _currentLocale;

  // Supported languages with their details
  static const Map<String, Map<String, String>> supportedLanguages = {
    'en': {
      'name': 'English',
      'nativeName': 'English',
      'flag': '🇺🇸',
      'code': 'en'
    },
    'hi': {
      'name': 'Hindi',
      'nativeName': 'हिंदी',
      'flag': '🇮🇳',
      'code': 'hi'
    },
    'pa': {
      'name': 'Punjabi',
      'nativeName': 'ਪੰਜਾਬੀ',
      'flag': '🇮🇳',
      'code': 'pa'
    },
  };

  LanguageService() {
    _loadSavedLanguage();
  }

  // Load saved language from SharedPreferences
  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey);

      if (savedLanguage != null &&
          supportedLanguages.containsKey(savedLanguage)) {
        _currentLocale = Locale(savedLanguage);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading saved language: $e');
    }
  }

  // Change language and save to preferences
  Future<void> changeLanguage(String languageCode) async {
    if (!supportedLanguages.containsKey(languageCode)) {
      debugPrint('Unsupported language code: $languageCode');
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);

      _currentLocale = Locale(languageCode);
      notifyListeners();

      debugPrint('Language changed to: $languageCode');
    } catch (e) {
      debugPrint('Error saving language preference: $e');
    }
  }

  // Get current language display name
  String get currentLanguageName {
    return supportedLanguages[_currentLocale.languageCode]?['name'] ??
        'English';
  }

  // Get current language native name
  String get currentLanguageNativeName {
    return supportedLanguages[_currentLocale.languageCode]?['nativeName'] ??
        'English';
  }

  // Get current language flag
  String get currentLanguageFlag {
    return supportedLanguages[_currentLocale.languageCode]?['flag'] ?? '🇺🇸';
  }

  // Check if current language is RTL (Right-to-Left)
  bool get isRTL {
    // None of our supported languages are RTL, but this could be extended
    return false;
  }

  // Get language-specific font family
  String get fontFamily {
    switch (_currentLocale.languageCode) {
      case 'hi':
        return 'GameFont'; // You can add specific Hindi fonts here
      case 'pa':
        return 'GameFont'; // You can add specific Punjabi fonts here
      default:
        return 'GameFont';
    }
  }

  // Special method to detect if we should show Nabha-specific content
  bool get shouldShowNabhaContent {
    return _currentLocale.languageCode == 'pa';
  }

  // Auto-detect system language and set if supported
  Future<void> autoDetectLanguage() async {
    try {
      // Get system locale
      final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
      final systemLanguageCode = systemLocale.languageCode;

      // Check if system language is supported
      if (supportedLanguages.containsKey(systemLanguageCode)) {
        await changeLanguage(systemLanguageCode);
        debugPrint('Auto-detected and set language to: $systemLanguageCode');
      } else {
        debugPrint(
            'System language $systemLanguageCode not supported, keeping current language');
      }
    } catch (e) {
      debugPrint('Error auto-detecting language: $e');
    }
  }

  // Reset to default language
  Future<void> resetToDefault() async {
    await changeLanguage('en');
  }

  // Get all available languages for language picker
  List<Map<String, String>> get availableLanguages {
    return supportedLanguages.values.toList();
  }

  // Get language-specific formatting preferences
  Map<String, dynamic> get languagePreferences {
    switch (_currentLocale.languageCode) {
      case 'hi':
        return {
          'dateFormat': 'dd/MM/yyyy',
          'numberFormat': 'hi_IN',
          'textDirection': TextDirection.ltr,
          'showLocalExamples': true,
          'localPlace': 'भारत',
        };
      case 'pa':
        return {
          'dateFormat': 'dd/MM/yyyy',
          'numberFormat': 'pa_IN',
          'textDirection': TextDirection.ltr,
          'showLocalExamples': true,
          'localPlace': 'ਨਾਭਾ, ਪੰਜਾਬ',
          'showNabhaContent': true,
        };
      default:
        return {
          'dateFormat': 'MM/dd/yyyy',
          'numberFormat': 'en_US',
          'textDirection': TextDirection.ltr,
          'showLocalExamples': false,
          'localPlace': 'India',
        };
    }
  }
}
