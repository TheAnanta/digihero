import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'DigiHero';
  static const String appVersion = '1.0.0';
  
  // Colors (inspired by Be Internet Awesome)
  static const Color primaryColor = Color(0xFF4285F4);
  static const Color secondaryColor = Color(0xFF34A853);
  static const Color accentColor = Color(0xFFEA4335);
  static const Color warningColor = Color(0xFFFBBC04);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textPrimaryColor = Color(0xFF202124);
  static const Color textSecondaryColor = Color(0xFF5F6368);
  
  // Game Constants
  static const int totalUnits = 5;
  static const int chaptersPerUnit = 4;
  static const int totalLevels = 20; // 5 units × 4 chapters each
  static const int starsPerLevel = 3;
  static const int coinsPerStar = 10;
  
  // Syllabus Units
  static const List<String> syllabusUnits = [
    'My First Step into the Digital World',
    'Using Digital Tools for School and Learning', 
    'Exploring the Internet Safely',
    'Communication and Collaboration',
    'Digital Skills for Life',
  ];
  
  // Level Themes (aligned with Digital Literacy Syllabus)
  static const List<String> levelThemes = [
    // Unit 1: My First Step into the Digital World
    'Meet Your Digital Device',        // Level 1
    'Understanding Your Screen',       // Level 2
    'Working with Apps',              // Level 3
    'Why Digital Skills Matter',      // Level 4
    
    // Unit 2: Using Digital Tools for School and Learning
    'Mastering Our Learning App',     // Level 5
    'Writing and Typing',            // Level 6
    'Creating Presentations',        // Level 7
    'Organizing Digital Work',       // Level 8
    
    // Unit 3: Exploring the Internet Safely
    'What is the Internet',          // Level 9
    'Searching for Information',     // Level 10
    'Staying Safe Online',          // Level 11
    'Being a Good Digital Citizen', // Level 12
    
    // Unit 4: Communication and Collaboration
    'Introduction to Email',         // Level 13
    'Messaging Apps Safety',        // Level 14
    'Understanding Progress',       // Level 15
    'Working Together Online',      // Level 16
    
    // Unit 5: Digital Skills for Life
    'Exploring Hobbies Online',     // Level 17
    'Digital Payments Safety',     // Level 18
    'Career Opportunities',        // Level 19
    'Digital Portfolio Project',   // Level 20
  ];
  
  // Character Names
  static const List<String> characterNames = [
    'DigiBuddy',
    'CyberPal',
    'SafeBot',
    'PrivacyGuard',
    'NetHero',
  ];
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 800);
  
  // Game Mechanics
  static const double gameSpeed = 1.0;
  static const int maxLives = 3;
  static const int timeLimit = 120; // seconds per level
  
  // Helper methods for syllabus navigation
  static int getUnitFromLevel(int levelNumber) {
    return ((levelNumber - 1) ~/ chaptersPerUnit) + 1;
  }
  
  static int getChapterInUnit(int levelNumber) {
    return ((levelNumber - 1) % chaptersPerUnit) + 1;
  }
  
  static String getUnitTitle(int unitNumber) {
    if (unitNumber >= 1 && unitNumber <= syllabusUnits.length) {
      return syllabusUnits[unitNumber - 1];
    }
    return 'Unknown Unit';
  }
  
  static List<int> getLevelsForUnit(int unitNumber) {
    if (unitNumber < 1 || unitNumber > totalUnits) return [];
    int startLevel = ((unitNumber - 1) * chaptersPerUnit) + 1;
    return List.generate(chaptersPerUnit, (index) => startLevel + index);
  }
}