import 'package:flutter_test/flutter_test.dart';
import 'package:digihero/core/constants/app_constants.dart';
import 'package:digihero/features/levels/data/level_data.dart';

void main() {
  group('Syllabus Integration Tests', () {
    test('should have correct total number of levels and units', () {
      expect(AppConstants.totalLevels, 20);
      expect(AppConstants.totalUnits, 5);
      expect(AppConstants.chaptersPerUnit, 4);
      expect(AppConstants.levelThemes.length, 20);
      expect(AppConstants.syllabusUnits.length, 5);
    });

    test('should correctly calculate unit numbers for all levels', () {
      // Test first level of each unit
      expect(AppConstants.getUnitFromLevel(1), 1);  // Unit 1
      expect(AppConstants.getUnitFromLevel(5), 2);  // Unit 2
      expect(AppConstants.getUnitFromLevel(9), 3);  // Unit 3
      expect(AppConstants.getUnitFromLevel(13), 4); // Unit 4
      expect(AppConstants.getUnitFromLevel(17), 5); // Unit 5
      
      // Test last level of each unit
      expect(AppConstants.getUnitFromLevel(4), 1);  // Unit 1
      expect(AppConstants.getUnitFromLevel(8), 2);  // Unit 2
      expect(AppConstants.getUnitFromLevel(12), 3); // Unit 3
      expect(AppConstants.getUnitFromLevel(16), 4); // Unit 4
      expect(AppConstants.getUnitFromLevel(20), 5); // Unit 5
    });

    test('should correctly calculate chapter numbers within units', () {
      // Test all chapters in Unit 1
      expect(AppConstants.getChapterInUnit(1), 1);
      expect(AppConstants.getChapterInUnit(2), 2);
      expect(AppConstants.getChapterInUnit(3), 3);
      expect(AppConstants.getChapterInUnit(4), 4);
      
      // Test all chapters in Unit 5
      expect(AppConstants.getChapterInUnit(17), 1);
      expect(AppConstants.getChapterInUnit(18), 2);
      expect(AppConstants.getChapterInUnit(19), 3);
      expect(AppConstants.getChapterInUnit(20), 4);
    });

    test('should return correct unit titles', () {
      expect(AppConstants.getUnitTitle(1), 'My First Step into the Digital World');
      expect(AppConstants.getUnitTitle(2), 'Using Digital Tools for School and Learning');
      expect(AppConstants.getUnitTitle(3), 'Exploring the Internet Safely');
      expect(AppConstants.getUnitTitle(4), 'Communication and Collaboration');
      expect(AppConstants.getUnitTitle(5), 'Digital Skills for Life');
      expect(AppConstants.getUnitTitle(6), 'Unknown Unit');
    });

    test('should return correct levels for each unit', () {
      expect(AppConstants.getLevelsForUnit(1), [1, 2, 3, 4]);
      expect(AppConstants.getLevelsForUnit(2), [5, 6, 7, 8]);
      expect(AppConstants.getLevelsForUnit(3), [9, 10, 11, 12]);
      expect(AppConstants.getLevelsForUnit(4), [13, 14, 15, 16]);
      expect(AppConstants.getLevelsForUnit(5), [17, 18, 19, 20]);
      expect(AppConstants.getLevelsForUnit(6), []);
    });

    test('should create valid level data for all levels', () {
      for (int i = 1; i <= AppConstants.totalLevels; i++) {
        final level = LevelData.getLevelData(i);
        
        expect(level.levelNumber, i);
        expect(level.title.isNotEmpty, true);
        expect(level.theme.isNotEmpty, true);
        expect(level.description.isNotEmpty, true);
        expect(level.learningObjective.isNotEmpty, true);
        expect(level.tips.isNotEmpty, true);
        expect(level.challenges.isNotEmpty, true);
        expect(level.targetScore, greaterThan(0));
        expect(level.timeLimit, greaterThan(0));
        
        // Test unit helper methods in GameLevel
        expect(level.unitNumber, greaterThan(0));
        expect(level.unitNumber, lessThanOrEqualTo(5));
        expect(level.chapterInUnit, greaterThan(0));
        expect(level.chapterInUnit, lessThanOrEqualTo(4));
        expect(level.unitTitle.isNotEmpty, true);
      }
    });

    test('should have correct syllabus theme progression', () {
      // Unit 1 themes
      expect(AppConstants.levelThemes[0], 'Meet Your Digital Device');
      expect(AppConstants.levelThemes[1], 'Understanding Your Screen');
      expect(AppConstants.levelThemes[2], 'Working with Apps');
      expect(AppConstants.levelThemes[3], 'Why Digital Skills Matter');
      
      // Unit 5 themes (final unit)
      expect(AppConstants.levelThemes[16], 'Exploring Hobbies Online');
      expect(AppConstants.levelThemes[17], 'Digital Payments Safety');
      expect(AppConstants.levelThemes[18], 'Career Opportunities');
      expect(AppConstants.levelThemes[19], 'Digital Portfolio Project');
    });

    test('should validate GameLevel helper methods work correctly', () {
      final level1 = LevelData.getLevelData(1);
      final level10 = LevelData.getLevelData(10);
      final level20 = LevelData.getLevelData(20);
      
      // Test Level 1 (Unit 1, Chapter 1)
      expect(level1.unitNumber, 1);
      expect(level1.chapterInUnit, 1);
      expect(level1.unitTitle, 'My First Step into the Digital World');
      
      // Test Level 10 (Unit 3, Chapter 2)
      expect(level10.unitNumber, 3);
      expect(level10.chapterInUnit, 2);
      expect(level10.unitTitle, 'Exploring the Internet Safely');
      
      // Test Level 20 (Unit 5, Chapter 4)
      expect(level20.unitNumber, 5);
      expect(level20.chapterInUnit, 4);
      expect(level20.unitTitle, 'Digital Skills for Life');
    });
  });
}