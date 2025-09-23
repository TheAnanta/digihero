import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../constants/app_constants.dart';

class ProgressService extends ChangeNotifier {
  late Box _progressBox;

  // Player Progress
  String _playerName = '';
  int _totalPlayTime = 0; // in seconds
  DateTime? _lastPlayed;
  List<Achievement> _achievements = [];
  Map<String, dynamic> _statistics = {};

  ProgressService() {
    _initializeProgress();
  }

  // Getters
  String get playerName => _playerName;
  int get totalPlayTime => _totalPlayTime;
  DateTime? get lastPlayed => _lastPlayed;
  List<Achievement> get achievements => _achievements;
  Map<String, dynamic> get statistics => _statistics;

  void _initializeProgress() async {
    _progressBox = Hive.box('gameProgress');
    _loadProgressData();
  }

  void _loadProgressData() {
    _playerName = _progressBox.get('playerName', defaultValue: '');
    _totalPlayTime = _progressBox.get('totalPlayTime', defaultValue: 0);

    final lastPlayedMs = _progressBox.get('lastPlayed');
    if (lastPlayedMs != null) {
      _lastPlayed = DateTime.fromMillisecondsSinceEpoch(lastPlayedMs);
    }

    // Load achievements
    final achievementsData = _progressBox
        .get('achievements', defaultValue: <Map<String, dynamic>>[]);
    _achievements =
        (achievementsData as List<dynamic>).map<Achievement>((data) {
      if (data is Map<String, dynamic>) {
        return Achievement.fromMap(data);
      } else if (data is Map) {
        // Convert Map<dynamic, dynamic> to Map<String, dynamic>
        return Achievement.fromMap(Map<String, dynamic>.from(data));
      } else {
        throw Exception('Invalid achievement data format: $data');
      }
    }).toList();

    // Load statistics
    _statistics = _progressBox.get('statistics', defaultValue: {
      'levelsPlayed': 0,
      'questionsAnswered': 0,
      'correctAnswers': 0,
      'coinsCollected': 0,
      'timeSpentLearning': 0,
      'streakDays': 0,
      'bestStreak': 0,
    });

    notifyListeners();
  }

  void _saveProgressData() {
    _progressBox.put('playerName', _playerName);
    _progressBox.put('totalPlayTime', _totalPlayTime);
    _progressBox.put('lastPlayed', _lastPlayed?.millisecondsSinceEpoch);
    _progressBox.put(
        'achievements', _achievements.map((a) => a.toMap()).toList());
    _progressBox.put('statistics', _statistics);
  }

  void setPlayerName(String name) {
    _playerName = name;
    _saveProgressData();
    notifyListeners();
  }

  void addPlayTime(int seconds) {
    _totalPlayTime += seconds;
    _statistics['timeSpentLearning'] =
        (_statistics['timeSpentLearning'] ?? 0) + seconds;
    _updateLastPlayed();
    _saveProgressData();
    notifyListeners();
  }

  void _updateLastPlayed() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (_lastPlayed != null) {
      final lastPlayedDay =
          DateTime(_lastPlayed!.year, _lastPlayed!.month, _lastPlayed!.day);
      final daysDifference = today.difference(lastPlayedDay).inDays;

      if (daysDifference == 1) {
        // Consecutive day
        _statistics['streakDays'] = (_statistics['streakDays'] ?? 0) + 1;
        if (_statistics['streakDays'] > (_statistics['bestStreak'] ?? 0)) {
          _statistics['bestStreak'] = _statistics['streakDays'];
        }
      } else if (daysDifference > 1) {
        // Streak broken
        _statistics['streakDays'] = 1;
      }
    } else {
      _statistics['streakDays'] = 1;
    }

    _lastPlayed = now;
  }

  void recordLevelPlayed() {
    _statistics['levelsPlayed'] = (_statistics['levelsPlayed'] ?? 0) + 1;
    _checkAchievements();
    _saveProgressData();
    notifyListeners();
  }

  void recordQuestionAnswered(bool correct) {
    _statistics['questionsAnswered'] =
        (_statistics['questionsAnswered'] ?? 0) + 1;
    if (correct) {
      _statistics['correctAnswers'] = (_statistics['correctAnswers'] ?? 0) + 1;
    }
    _checkAchievements();
    _saveProgressData();
    notifyListeners();
  }

  void recordCoinsCollected(int coins) {
    _statistics['coinsCollected'] =
        (_statistics['coinsCollected'] ?? 0) + coins;
    _checkAchievements();
    _saveProgressData();
    notifyListeners();
  }

  void _checkAchievements() {
    final newAchievements = <Achievement>[];

    // Check various achievement conditions
    if (_statistics['levelsPlayed'] >= 1 && !hasAchievement('first_level')) {
      newAchievements.add(Achievement(
        id: 'first_level',
        title: 'First Steps',
        description: 'Complete your first level',
        iconPath: 'assets/images/ui/achievement_first_level.png',
        unlockedAt: DateTime.now(),
      ));
    }

    if (_statistics['levelsPlayed'] >= 5 && !hasAchievement('explorer')) {
      newAchievements.add(Achievement(
        id: 'explorer',
        title: 'Digital Explorer',
        description: 'Complete 5 levels',
        iconPath: 'assets/images/ui/achievement_explorer.png',
        unlockedAt: DateTime.now(),
      ));
    }

    if (_statistics['correctAnswers'] >= 50 &&
        !hasAchievement('smart_learner')) {
      newAchievements.add(Achievement(
        id: 'smart_learner',
        title: 'Smart Learner',
        description: 'Answer 50 questions correctly',
        iconPath: 'assets/images/ui/achievement_smart.png',
        unlockedAt: DateTime.now(),
      ));
    }

    if (_statistics['streakDays'] >= 7 && !hasAchievement('week_streak')) {
      newAchievements.add(Achievement(
        id: 'week_streak',
        title: 'Week Warrior',
        description: 'Play for 7 consecutive days',
        iconPath: 'assets/images/ui/achievement_streak.png',
        unlockedAt: DateTime.now(),
      ));
    }

    if (_statistics['coinsCollected'] >= 100 &&
        !hasAchievement('coin_collector')) {
      newAchievements.add(Achievement(
        id: 'coin_collector',
        title: 'Coin Collector',
        description: 'Collect 100 coins',
        iconPath: 'assets/images/ui/achievement_coins.png',
        unlockedAt: DateTime.now(),
      ));
    }

    _achievements.addAll(newAchievements);
  }

  bool hasAchievement(String achievementId) {
    return _achievements.any((achievement) => achievement.id == achievementId);
  }

  double getOverallProgress() {
    // Calculate progress based on completed levels
    int completedLevels = _statistics['levelsPlayed'] ?? 0;
    return (completedLevels / AppConstants.totalLevels).clamp(0.0, 1.0);
  }

  Map<String, dynamic> getProgressSummary() {
    return {
      'playerName': _playerName,
      'totalPlayTime': _totalPlayTime,
      'completedLevels': _statistics['levelsPlayed'] ?? 0,
      'totalAchievements': _achievements.length,
      'overallProgress': getOverallProgress(),
      'currentStreak': _statistics['streakDays'] ?? 0,
    };
  }
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconPath;
  final DateTime unlockedAt;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.unlockedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iconPath': iconPath,
      'unlockedAt': unlockedAt.millisecondsSinceEpoch,
    };
  }

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      iconPath: map['iconPath'],
      unlockedAt: DateTime.fromMillisecondsSinceEpoch(map['unlockedAt']),
    );
  }
}
