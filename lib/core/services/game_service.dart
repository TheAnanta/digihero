import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../constants/app_constants.dart';

class GameService extends ChangeNotifier {
  late Box _gameBox;

  // Game State
  int _currentLevel = 1;
  int _totalScore = 0;
  int _coins = 0;
  int _lives = AppConstants.maxLives;
  bool _isGameActive = false;
  bool _isPaused = false;

  // Level Progress
  final Map<int, Map<String, dynamic>> _levelProgress = {};

  // Player profile and difficulty
  int _playerAge = 10;
  String _difficultyLevel = 'medium'; // easy, medium, hard, expert

  GameService() {
    _initializeGame();
  }

  // Getters
  int get currentLevel => _currentLevel;
  int get totalScore => _totalScore;
  int get coins => _coins;
  int get lives => _lives;
  bool get isGameActive => _isGameActive;
  bool get isPaused => _isPaused;
  Map<int, Map<String, dynamic>> get levelProgress => _levelProgress;
  int get playerAge => _playerAge;
  String get difficultyLevel => _difficultyLevel;

  void _initializeGame() {
    _gameBox = Hive.box('gameProgress');
    _loadGameData();

    // Ensure level 1 is always unlocked
    if (_levelProgress[1] != null) {
      _levelProgress[1]!['unlocked'] = true;
      _saveGameData();
    }
  }

  void _loadGameData() {
    _currentLevel = _gameBox.get('currentLevel', defaultValue: 1);
    _totalScore = _gameBox.get('totalScore', defaultValue: 0);
    _coins = _gameBox.get('coins', defaultValue: 0);
    _lives = _gameBox.get('lives', defaultValue: AppConstants.maxLives);

    // Don't set default values for age - we need to know if it's been set
    final storedAge = _gameBox.get('playerAge');
    if (storedAge != null) {
      _playerAge = storedAge;
      _difficultyLevel =
          _gameBox.get('difficultyLevel', defaultValue: 'medium');
    }

    // Load level progress
    for (int i = 1; i <= AppConstants.totalLevels; i++) {
      final levelData = _gameBox.get('level_$i');
      if (levelData != null) {
        // Safely convert Map<dynamic, dynamic> to Map<String, dynamic>
        _levelProgress[i] = Map<String, dynamic>.from(levelData);
      } else {
        _levelProgress[i] = {
          'completed': false,
          'stars': 0,
          'bestScore': 0,
          'bestTime': 0,
          'unlocked': i == 1,
        };
      }
    }

    notifyListeners();
  }

  void _saveGameData() {
    _gameBox.put('currentLevel', _currentLevel);
    _gameBox.put('totalScore', _totalScore);
    _gameBox.put('coins', _coins);
    _gameBox.put('lives', _lives);

    // Only save age and difficulty if they have been set
    if (_gameBox.get('playerAge') != null) {
      _gameBox.put('playerAge', _playerAge);
      _gameBox.put('difficultyLevel', _difficultyLevel);
    }

    // Save level progress
    for (int i = 1; i <= AppConstants.totalLevels; i++) {
      _gameBox.put('level_$i', _levelProgress[i]);
    }
  }

  void startGame() {
    _isGameActive = true;
    _isPaused = false;
    notifyListeners();
  }

  void pauseGame() {
    _isPaused = true;
    notifyListeners();
  }

  void resumeGame() {
    _isPaused = false;
    notifyListeners();
  }

  void endGame() {
    _isGameActive = false;
    _isPaused = false;
    notifyListeners();
  }

  void completeLevel(int level, int score, int stars, int timeSeconds) {
    if (_levelProgress[level] != null) {
      _levelProgress[level]!['completed'] = true;

      // Update best score and time
      if (score > _levelProgress[level]!['bestScore']) {
        _levelProgress[level]!['bestScore'] = score;
      }

      if (_levelProgress[level]!['bestTime'] == 0 ||
          timeSeconds < _levelProgress[level]!['bestTime']) {
        _levelProgress[level]!['bestTime'] = timeSeconds.toInt();
      }

      // Update stars (take the best)
      if (stars > _levelProgress[level]!['stars']) {
        // Award coins for new stars
        int previousStars = _levelProgress[level]!['stars'] as int;
        int newStars = stars - previousStars;
        _coins += newStars * AppConstants.coinsPerStar;

        _levelProgress[level]!['stars'] = stars;
      }

      _totalScore += score;

      // Unlock next level
      if (level < AppConstants.totalLevels &&
          _levelProgress[level + 1] != null) {
        _levelProgress[level + 1]!['unlocked'] = true;
      }

      _saveGameData();
      notifyListeners();
    }
  }

  void loseLife() {
    if (_lives > 0) {
      _lives--;
      _saveGameData();
      notifyListeners();
    }
  }

  void addLife() {
    _lives++;
    _saveGameData();
    notifyListeners();
  }

  void resetGame() {
    _currentLevel = 1;
    _totalScore = 0;
    _coins = 0;
    _lives = AppConstants.maxLives;

    // Reset all level progress
    for (int i = 1; i <= AppConstants.totalLevels; i++) {
      _levelProgress[i] = {
        'completed': false,
        'stars': 0,
        'bestScore': 0,
        'bestTime': 0,
        'unlocked': i == 1,
      };
    }

    _saveGameData();
    notifyListeners();
  }

  bool isLevelUnlocked(int level) {
    // Level 1 should always be unlocked
    if (level == 1) return true;

    return _levelProgress[level]?['unlocked'] ?? false;
  }

  int getLevelStars(int level) {
    return _levelProgress[level]?['stars'] ?? 0;
  }

  bool isLevelCompleted(int level) {
    return _levelProgress[level]?['completed'] ?? false;
  }

  // Debug method to unlock all levels (useful for testing)
  void unlockAllLevels() {
    for (int i = 1; i <= AppConstants.totalLevels; i++) {
      if (_levelProgress[i] != null) {
        _levelProgress[i]!['unlocked'] = true;
      }
    }
    _saveGameData();
    notifyListeners();
  }

  // Debug method to reset all data and force age input screen
  void resetGameData() {
    _gameBox.clear();
    _currentLevel = 1;
    _totalScore = 0;
    _coins = 0;
    _lives = AppConstants.maxLives;
    _levelProgress.clear();

    // Initialize levels without age data
    for (int i = 1; i <= AppConstants.totalLevels; i++) {
      _levelProgress[i] = {
        'completed': false,
        'stars': 0,
        'bestScore': 0,
        'bestTime': 0,
        'unlocked': i == 1,
      };
    }

    notifyListeners();
  }

  // Player profile management
  void setPlayerAge(int age, String difficulty) {
    _playerAge = age;
    _difficultyLevel = difficulty;
    _gameBox.put('playerAge', age);
    _gameBox.put('difficultyLevel', difficulty);
    _saveGameData();
    notifyListeners();
  }

  // Check if user has set their age
  bool get hasSetAge => _gameBox.get('playerAge') != null;

  // Get difficulty-adjusted values
  int getDifficultyAdjustedLives() {
    switch (_difficultyLevel) {
      case 'easy':
        return 5; // More lives for younger players
      case 'medium':
        return 3; // Default
      case 'hard':
        return 2; // Fewer lives for advanced players
      case 'expert':
        return 1; // Challenge mode
      default:
        return 3;
    }
  }

  int getDifficultyAdjustedTimeLimit(int baseTime) {
    switch (_difficultyLevel) {
      case 'easy':
        return (baseTime * 1.5).round(); // 50% more time
      case 'medium':
        return baseTime; // Default time
      case 'hard':
        return (baseTime * 0.8).round(); // 20% less time
      case 'expert':
        return (baseTime * 0.6).round(); // 40% less time
      default:
        return baseTime;
    }
  }

  int getDifficultyAdjustedPoints(int basePoints) {
    switch (_difficultyLevel) {
      case 'easy':
        return basePoints; // Normal points
      case 'medium':
        return (basePoints * 1.2).round(); // 20% bonus
      case 'hard':
        return (basePoints * 1.5).round(); // 50% bonus
      case 'expert':
        return (basePoints * 2).round(); // Double points
      default:
        return basePoints;
    }
  }
}
