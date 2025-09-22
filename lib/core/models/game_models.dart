class GameLevel {
  final int levelNumber;
  final String title;
  final String theme;
  final String description;
  final String backgroundImagePath;
  final String characterImagePath;
  final List<GameChallenge> challenges;
  final int targetScore;
  final int timeLimit;
  final String learningObjective;
  final List<String> tips;
  
  GameLevel({
    required this.levelNumber,
    required this.title,
    required this.theme,
    required this.description,
    required this.backgroundImagePath,
    required this.characterImagePath,
    required this.challenges,
    required this.targetScore,
    required this.timeLimit,
    required this.learningObjective,
    required this.tips,
  });
  
  // Helper methods for syllabus integration
  int get unitNumber {
    return ((levelNumber - 1) ~/ 4) + 1;
  }
  
  int get chapterInUnit {
    return ((levelNumber - 1) % 4) + 1;
  }
  
  String get unitTitle {
    const units = [
      'My First Step into the Digital World',
      'Using Digital Tools for School and Learning', 
      'Exploring the Internet Safely',
      'Communication and Collaboration',
      'Digital Skills for Life',
    ];
    if (unitNumber >= 1 && unitNumber <= units.length) {
      return units[unitNumber - 1];
    }
    return 'Unknown Unit';
  }
  
  Map<String, dynamic> toMap() {
    return {
      'levelNumber': levelNumber,
      'title': title,
      'theme': theme,
      'description': description,
      'backgroundImagePath': backgroundImagePath,
      'characterImagePath': characterImagePath,
      'challenges': challenges.map((c) => c.toMap()).toList(),
      'targetScore': targetScore,
      'timeLimit': timeLimit,
      'learningObjective': learningObjective,
      'tips': tips,
    };
  }
  
  factory GameLevel.fromMap(Map<String, dynamic> map) {
    return GameLevel(
      levelNumber: map['levelNumber'],
      title: map['title'],
      theme: map['theme'],
      description: map['description'],
      backgroundImagePath: map['backgroundImagePath'],
      characterImagePath: map['characterImagePath'],
      challenges: (map['challenges'] as List).map((c) => GameChallenge.fromMap(c)).toList(),
      targetScore: map['targetScore'],
      timeLimit: map['timeLimit'],
      learningObjective: map['learningObjective'],
      tips: List<String>.from(map['tips']),
    );
  }
}

class GameChallenge {
  final String id;
  final ChallengeType type;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;
  final int points;
  final String? imagePath;
  final String? videoPath;
  final Map<String, dynamic>? interactiveData;
  
  GameChallenge({
    required this.id,
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
    required this.points,
    this.imagePath,
    this.videoPath,
    this.interactiveData,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.toString(),
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
      'points': points,
      'imagePath': imagePath,
      'videoPath': videoPath,
      'interactiveData': interactiveData,
    };
  }
  
  factory GameChallenge.fromMap(Map<String, dynamic> map) {
    return GameChallenge(
      id: map['id'],
      type: ChallengeType.values.firstWhere((e) => e.toString() == map['type']),
      question: map['question'],
      options: List<String>.from(map['options']),
      correctAnswerIndex: map['correctAnswerIndex'],
      explanation: map['explanation'],
      points: map['points'],
      imagePath: map['imagePath'],
      videoPath: map['videoPath'],
      interactiveData: map['interactiveData'],
    );
  }
}

enum ChallengeType {
  multipleChoice,
  trueFalse,
  dragAndDrop,
  sequencing,
  interactive,
  scenario,
  deviceBuilder,    // For device part identification games
  iconHunt,         // For tapping specific icons
  cursorMaestro,    // For mouse/touch gesture practice  
  appSorter,        // For categorizing apps
  matchUp,          // For matching pairs games
  typingChallenge,  // For typing practice games
  slideDesigner,    // For presentation creation
  fileOrganizer,    // For file management games
  browserNavigator, // For browser part identification
  searchQuest,      // For search simulation games
  safetyScenario,   // For safety decision scenarios
  emailComposer,    // For email composition practice
  chatSimulator,    // For messaging practice
  dashboardReader,  // For data interpretation
  scamSpotter,      // For identifying scams
  careerExplorer,   // For career research
}

class GameCharacter {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final String animationPath;
  final List<String> dialogues;
  final CharacterType type;
  
  GameCharacter({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.animationPath,
    required this.dialogues,
    required this.type,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'animationPath': animationPath,
      'dialogues': dialogues,
      'type': type.toString(),
    };
  }
  
  factory GameCharacter.fromMap(Map<String, dynamic> map) {
    return GameCharacter(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imagePath: map['imagePath'],
      animationPath: map['animationPath'],
      dialogues: List<String>.from(map['dialogues']),
      type: CharacterType.values.firstWhere((e) => e.toString() == map['type']),
    );
  }
}

enum CharacterType {
  hero,
  guide,
  villain,
  helper,
}

class PowerUp {
  final String id;
  final String name;
  final String description;
  final String iconPath;
  final PowerUpType type;
  final int duration; // in seconds
  final Map<String, dynamic> effects;
  
  PowerUp({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    required this.type,
    required this.duration,
    required this.effects,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconPath': iconPath,
      'type': type.toString(),
      'duration': duration,
      'effects': effects,
    };
  }
  
  factory PowerUp.fromMap(Map<String, dynamic> map) {
    return PowerUp(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      iconPath: map['iconPath'],
      type: PowerUpType.values.firstWhere((e) => e.toString() == map['type']),
      duration: map['duration'],
      effects: Map<String, dynamic>.from(map['effects']),
    );
  }
}

enum PowerUpType {
  timeBonus,
  scoreMultiplier,
  extraLife,
  hint,
  shield,
}