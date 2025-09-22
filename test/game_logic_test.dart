import 'package:flutter_test/flutter_test.dart';
import 'package:digihero/core/constants/app_constants.dart';
import 'package:digihero/core/models/game_models.dart';
import 'package:digihero/features/levels/data/level_data.dart';

void main() {
  group('Game Logic Tests', () {
    test('App constants are properly defined', () {
      expect(AppConstants.appName, 'DigiHero');
      expect(AppConstants.totalLevels, 10);
      expect(AppConstants.starsPerLevel, 3);
      expect(AppConstants.levelThemes.length, 10);
    });

    test('Level data can be loaded for all levels', () {
      for (int i = 1; i <= AppConstants.totalLevels; i++) {
        final level = LevelData.getLevelData(i);
        expect(level.levelNumber, i);
        expect(level.title, isNotEmpty);
        expect(level.theme, isNotEmpty);
        expect(level.challenges, isNotEmpty);
        expect(level.challenges.length, greaterThan(0));
      }
    });

    test('Game challenges have required properties', () {
      final level = LevelData.getLevelData(1);
      for (final challenge in level.challenges) {
        expect(challenge.id, isNotEmpty);
        expect(challenge.question, isNotEmpty);
        expect(challenge.explanation, isNotEmpty);
        expect(challenge.points, greaterThan(0));
        expect(challenge.options, isNotEmpty);
        expect(challenge.correctAnswerIndex, greaterThanOrEqualTo(0));
      }
    });

    test('Level themes match expected digital literacy topics', () {
      final expectedThemes = [
        'Smart Passwords',
        'Phishing Awareness',
        'Privacy Settings',
        'Cyberbullying',
        'Safe Downloads',
        'Social Media Safety',
        'Digital Footprint',
        'Secure Networks',
        'Information Literacy',
        'Digital Citizenship',
      ];
      
      expect(AppConstants.levelThemes, expectedThemes);
    });

    test('Game models can be serialized and deserialized', () {
      final originalLevel = LevelData.getLevelData(1);
      final serialized = originalLevel.toMap();
      final deserialized = GameLevel.fromMap(serialized);
      
      expect(deserialized.levelNumber, originalLevel.levelNumber);
      expect(deserialized.title, originalLevel.title);
      expect(deserialized.theme, originalLevel.theme);
      expect(deserialized.challenges.length, originalLevel.challenges.length);
    });
  });
}