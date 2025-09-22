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

  void _initializeGame() async {
    _gameBox = Hive.box('gameProgress');
    _loadGameData();
  }

  void _loadGameData() {
    _currentLevel = _gameBox.get('currentLevel', defaultValue: 1);
    _totalScore = _gameBox.get('totalScore', defaultValue: 0);
    _coins = _gameBox.get('coins', defaultValue: 0);
    _lives = _gameBox.get('lives', defaultValue: AppConstants.maxLives);

    // Load level progress
    for (int i = 1; i <= AppConstants.totalLevels; i++) {
      _levelProgress[i] = _gameBox.get('level_$i', defaultValue: {
        'completed': false,
        'stars': 0,
        'bestScore': 0,
        'bestTime': 0,
        'unlocked': i == 1,
      });
    }

    notifyListeners();
  }

  void _saveGameData() {
    _gameBox.put('currentLevel', _currentLevel);
    _gameBox.put('totalScore', _totalScore);
    _gameBox.put('coins', _coins);
    _gameBox.put('lives', _lives);

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
    return _levelProgress[level]?['unlocked'] ?? false;
  }

  int getLevelStars(int level) {
    return _levelProgress[level]?['stars'] ?? 0;
  }

  bool isLevelCompleted(int level) {
    return _levelProgress[level]?['completed'] ?? false;
  }
}
