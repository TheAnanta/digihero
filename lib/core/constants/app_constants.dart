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
  static const int totalLevels = 10;
  static const int starsPerLevel = 3;
  static const int coinsPerStar = 10;
  
  // Level Themes (based on Be Internet Awesome curriculum)
  static const List<String> levelThemes = [
    'Smart Passwords',      // Level 1
    'Phishing Awareness',   // Level 2
    'Privacy Settings',     // Level 3
    'Cyberbullying',       // Level 4
    'Safe Downloads',      // Level 5
    'Social Media Safety', // Level 6
    'Digital Footprint',   // Level 7
    'Secure Networks',     // Level 8
    'Information Literacy', // Level 9
    'Digital Citizenship', // Level 10
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
}