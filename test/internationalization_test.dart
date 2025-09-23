import 'package:flutter_test/flutter_test.dart';
import 'package:digihero/core/services/localization_service.dart';
import 'package:flutter/widgets.dart';

void main() {
  // Initialize Flutter binding for tests
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Internationalization Tests', () {
    test('English localization loads correctly', () async {
      final localizations = AppLocalizations(const Locale('en'));
      await localizations.load();

      expect(localizations.appName, 'DigiHero');
      expect(localizations.welcomeMessage, 'Welcome to DigiHero!');
      expect(localizations.translate('common.ok'), 'OK');
    });

    test('Hindi localization loads correctly', () async {
      final localizations = AppLocalizations(const Locale('hi'));
      await localizations.load();

      expect(localizations.appName, 'डिजीहीरो');
      expect(localizations.welcomeMessage, 'डिजीहीरो में आपका स्वागत है!');
      expect(localizations.translate('common.ok'), 'ठीक है');
    });

    test('Punjabi localization loads correctly', () async {
      final localizations = AppLocalizations(const Locale('pa'));
      await localizations.load();

      expect(localizations.appName, 'ਡਿਜੀਹੀਰੋ');
      expect(localizations.welcomeMessage, 'ਡਿਜੀਹੀਰੋ ਵਿੱਚ ਤੁਹਾਡਾ ਸੁਆਗਤ ਹੈ!');
      expect(localizations.translate('common.ok'), 'ਠੀਕ ਹੈ');
    });

    test('Nabha-specific content available in Punjabi', () async {
      final localizations = AppLocalizations(const Locale('pa'));
      await localizations.load();

      expect(localizations.nabha, 'ਨਾਭਾ');
      expect(
          localizations.getNabhaContent('localHeroes'), 'ਨਾਭਾ ਦੇ ਡਿਜੀਟਲ ਹੀਰੋ');
      expect(localizations.translate('nabhaSpecific.examples.farmer'),
          contains('ਨਾਭਾ ਦਾ ਕਿਸਾਨ'));
    });

    test('Age group descriptions work in all languages', () async {
      final enLocalizations = AppLocalizations(const Locale('en'));
      await enLocalizations.load();

      final hiLocalizations = AppLocalizations(const Locale('hi'));
      await hiLocalizations.load();

      final paLocalizations = AppLocalizations(const Locale('pa'));
      await paLocalizations.load();

      // Test easy difficulty
      expect(enLocalizations.getAgeGroupDescription('easy'),
          contains('simple concepts'));
      expect(hiLocalizations.getAgeGroupDescription('easy'),
          contains('सरल अवधारणाओं'));
      expect(paLocalizations.getAgeGroupDescription('easy'),
          contains('ਸਿੱਧੀਆਂ ਸੰਕਲਪਨਾਵਾਂ'));
    });

    test('Device parts translations work correctly', () async {
      final enLocalizations = AppLocalizations(const Locale('en'));
      await enLocalizations.load();

      final hiLocalizations = AppLocalizations(const Locale('hi'));
      await hiLocalizations.load();

      final paLocalizations = AppLocalizations(const Locale('pa'));
      await paLocalizations.load();

      expect(enLocalizations.getDevicePart('monitor'), 'Monitor');
      expect(hiLocalizations.getDevicePart('monitor'), 'मॉनिटर');
      expect(paLocalizations.getDevicePart('monitor'), 'ਮਾਨੀਟਰ');
    });

    test('Typing challenge content localized', () async {
      final paLocalizations = AppLocalizations(const Locale('pa'));
      await paLocalizations.load();

      final sampleWords = paLocalizations.getTypingSamples('sampleWords');
      expect(sampleWords, contains('ਘਰ'));
      expect(sampleWords, contains('ਸਕੂਲ'));
      expect(sampleWords, contains('ਕਿਤਾਬ'));

      final sampleSentences =
          paLocalizations.getTypingSamples('sampleSentences');
      expect(sampleSentences, contains('ਮੇਰਾ ਪਿੰਡ'));
    });

    test('Game instructions localized properly', () async {
      final enLocalizations = AppLocalizations(const Locale('en'));
      await enLocalizations.load();

      final deviceBuilderInstruction =
          enLocalizations.getGameInstruction('deviceBuilder', 'instruction');
      expect(deviceBuilderInstruction, contains('drag and drop'));

      final powerUpInstruction =
          enLocalizations.getGameInstruction('powerUp', 'instruction');
      expect(powerUpInstruction, contains('correct order'));
    });

    test('Achievement translations available', () async {
      final enLocalizations = AppLocalizations(const Locale('en'));
      await enLocalizations.load();

      expect(enLocalizations.getAchievementTitle('firstSteps'), 'First Steps');
      expect(enLocalizations.getAchievementDescription('firstSteps'),
          'Complete your first level');

      expect(
          enLocalizations.getAchievementTitle('explorer'), 'Digital Explorer');
      expect(enLocalizations.getAchievementDescription('explorer'),
          'Complete 5 levels');
    });

    test('Tips available in all languages', () async {
      final enLocalizations = AppLocalizations(const Locale('en'));
      await enLocalizations.load();

      final tips = enLocalizations.getTips('deviceExplorer');
      expect(tips.length, greaterThan(0));
      expect(tips.first, contains('device parts'));

      final hiLocalizations = AppLocalizations(const Locale('hi'));
      await hiLocalizations.load();

      final hiTips = hiLocalizations.getTips('deviceExplorer');
      expect(hiTips.length, greaterThan(0));
      expect(hiTips.first, contains('डिवाइस'));
    });
  });
}
