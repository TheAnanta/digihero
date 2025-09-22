import '../../../core/models/game_models.dart';

class LevelData {
  static GameLevel getLevelData(int levelNumber) {
    switch (levelNumber) {
      // Unit 1: My First Step into the Digital World
      case 1:
        return _createMeetYourDigitalDeviceLevel();
      case 2:
        return _createUnderstandingYourScreenLevel();
      case 3:
        return _createWorkingWithAppsLevel();
      case 4:
        return _createWhyDigitalSkillsMatterLevel();

      // Unit 2: Using Digital Tools for School and Learning
      case 5:
        return _createMasteringLearningAppLevel();
      case 6:
        return _createWritingAndTypingLevel();
      case 7:
        return _createCreatingPresentationsLevel();
      case 8:
        return _createOrganizingDigitalWorkLevel();

      // Unit 3: Exploring the Internet Safely
      case 9:
        return _createWhatIsInternetLevel();
      case 10:
        return _createSearchingInformationLevel();
      case 11:
        return _createStayingSafeOnlineLevel();
      case 12:
        return _createBeingGoodDigitalCitizenLevel();

      // Unit 4: Communication and Collaboration
      case 13:
        return _createIntroductionToEmailLevel();
      case 14:
        return _createMessagingAppsSafetyLevel();
      case 15:
        return _createUnderstandingProgressLevel();
      case 16:
        return _createWorkingTogetherOnlineLevel();

      // Unit 5: Digital Skills for Life
      case 17:
        return _createExploringHobbiesOnlineLevel();
      case 18:
        return _createDigitalPaymentsSafetyLevel();
      case 19:
        return _createCareerOpportunitiesLevel();
      case 20:
        return _createDigitalPortfolioProjectLevel();

      default:
        return _createMeetYourDigitalDeviceLevel();
    }
  }

  // Unit 1: My First Step into the Digital World
  static GameLevel _createMeetYourDigitalDeviceLevel() {
    return GameLevel(
      levelNumber: 1,
      title: 'Device Explorer',
      theme: 'Meet Your Digital Device',
      description:
          'Learn about different types of devices and identify their main parts through interactive games.',
      backgroundImagePath: 'assets/images/backgrounds/device_bg.png',
      characterImagePath: 'assets/images/characters/explorer_hero.png',
      targetScore: 280,
      timeLimit: 180,
      learningObjective:
          'Students will identify different types of devices and understand their main parts.',
      tips: [
        'Look for common device parts like screen, keyboard, and mouse',
        'Different devices have different purposes',
        'Practice turning devices on and off safely',
        'Ask for help when handling new devices'
      ],
      challenges: [
        GameChallenge(
          id: 'device_builder_1',
          type: ChallengeType.deviceBuilder,
          question:
              'Device Builder: Drag and drop the labels onto the correct parts of this computer!',
          options: ['Monitor', 'CPU', 'Keyboard', 'Mouse'],
          correctAnswerIndex: 0, // All correct when properly placed
          explanation:
              'Great job! You correctly identified the main parts of a computer: Monitor (screen), CPU (main unit), Keyboard (for typing), and Mouse (for pointing).',
          points: 80,
          interactiveData: {
            'gameType': 'deviceBuilder',
            'deviceType': 'computer',
            'parts': ['Monitor', 'CPU', 'Keyboard', 'Mouse'],
            'instructions':
                'Drag each label to the matching part of the computer'
          },
        ),
        GameChallenge(
          id: 'power_up_1',
          type: ChallengeType.sequencing,
          question:
              'Power Up! Put these steps in the correct order to turn on a computer safely:',
          options: [
            'Plug in power cable',
            'Press CPU power button',
            'Press monitor power button',
            'Wait for startup'
          ],
          correctAnswerIndex: 0, // Sequence starts with plugging in power
          explanation:
              'Perfect! The correct order is: 1. Plug in power, 2. Press CPU power button, 3. Press monitor power button, 4. Wait for startup.',
          points: 70,
          interactiveData: {
            'gameType': 'sequencing',
            'correctOrder': [0, 1, 2, 3],
            'instructions': 'Arrange the steps in the right order'
          },
        ),
        GameChallenge(
          id: 'device_types_1',
          type: ChallengeType.multipleChoice,
          question:
              'Which device is best for making phone calls while traveling?',
          options: ['Desktop Computer', 'Smartphone', 'Television', 'Printer'],
          correctAnswerIndex: 1,
          explanation:
              'Smartphones are portable and designed for communication, making them perfect for calls while traveling.',
          points: 50,
        ),
        GameChallenge(
          id: 'device_shutdown_1',
          type: ChallengeType.scenario,
          question:
              'You finished your work on a tablet. What is the safest way to turn it off?',
          options: [
            'Just close the cover',
            'Use the power button to shut down properly',
            'Remove the battery',
            'Wait for it to turn off automatically'
          ],
          correctAnswerIndex: 1,
          explanation:
              'Always use the proper shutdown process to save your work and protect the device.',
          points: 60,
        ),
      ],
    );
  }

  static GameLevel _createUnderstandingYourScreenLevel() {
    return GameLevel(
      levelNumber: 2,
      title: 'Screen Navigator',
      theme: 'Understanding Your Screen',
      description:
          'Master desktop navigation through Icon Hunt and Cursor Maestro mini-games!',
      backgroundImagePath: 'assets/images/backgrounds/screen_bg.png',
      characterImagePath: 'assets/images/characters/navigator_hero.png',
      targetScore: 320,
      timeLimit: 200,
      learningObjective:
          'Students will identify common desktop icons and master basic mouse/touch navigation.',
      tips: [
        'Icons are small pictures that represent apps or files',
        'Look carefully - each icon has a unique shape and meaning',
        'Practice different mouse actions: click, double-click, drag',
        'On touch screens, tap and swipe with confidence'
      ],
      challenges: [
        GameChallenge(
          id: 'icon_hunt_1',
          type: ChallengeType.iconHunt,
          question: 'Icon Hunt: Find and tap the Folder icon on this desktop!',
          options: ['Folder found!', 'Try again', 'Need a hint?', 'Time up!'],
          correctAnswerIndex: 0,
          explanation:
              'Perfect! Folder icons usually look like manila file folders and help organize your files.',
          points: 80,
          interactiveData: {
            'gameType': 'iconHunt',
            'targetIcon': 'folder',
            'timeLimit': 30,
            'desktopIcons': [
              'folder',
              'recycle_bin',
              'computer',
              'documents',
              'pictures'
            ],
            'instructions': 'Tap the folder icon as quickly as you can!'
          },
        ),
        GameChallenge(
          id: 'icon_hunt_2',
          type: ChallengeType.iconHunt,
          question:
              'Icon Hunt: Quick! Tap the Recycle Bin before time runs out!',
          options: [
            'Recycle Bin found!',
            'Try again',
            'Need a hint?',
            'Time up!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Excellent! The Recycle Bin holds deleted files and usually looks like a trash can.',
          points: 70,
          interactiveData: {
            'gameType': 'iconHunt',
            'targetIcon': 'recycle_bin',
            'timeLimit': 25,
            'desktopIcons': [
              'folder',
              'recycle_bin',
              'computer',
              'documents',
              'pictures',
              'calculator'
            ],
            'instructions': 'Find the Recycle Bin icon!'
          },
        ),
        GameChallenge(
          id: 'cursor_maestro_1',
          type: ChallengeType.cursorMaestro,
          question: 'Cursor Maestro: Drag the file into the folder!',
          options: [
            'Successfully moved!',
            'Try again',
            'Almost there!',
            'Perfect technique!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Great dragging technique! Click and hold, then move the mouse to drag files into folders.',
          points: 90,
          interactiveData: {
            'gameType': 'cursorMaestro',
            'action': 'drag_to_folder',
            'sourceItem': 'document_file',
            'targetLocation': 'my_folder',
            'instructions': 'Click and drag the document into the folder'
          },
        ),
        GameChallenge(
          id: 'cursor_maestro_2',
          type: ChallengeType.cursorMaestro,
          question: 'Cursor Maestro: Double-click to open the picture!',
          options: [
            'Picture opened!',
            'Try again',
            'Single click detected',
            'Perfect timing!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Perfect double-click! Two quick clicks in the same spot opens files and programs.',
          points: 75,
          interactiveData: {
            'gameType': 'cursorMaestro',
            'action': 'double_click',
            'targetItem': 'picture_file',
            'instructions': 'Double-click the picture to open it'
          },
        ),
      ],
    );
  }

  static GameLevel _createWorkingWithAppsLevel() {
    return GameLevel(
      levelNumber: 3,
      title: 'App Master',
      theme: 'Working with Apps',
      description:
          'Learn about software types and become an App Sorter expert!',
      backgroundImagePath: 'assets/images/backgrounds/apps_bg.png',
      characterImagePath: 'assets/images/characters/app_hero.png',
      targetScore: 300,
      timeLimit: 180,
      learningObjective:
          'Students will distinguish between system and application software and practice safe app management.',
      tips: [
        'System software runs your device (like Android or Windows)',
        'Application software helps you do specific tasks',
        'Always close apps properly when finished',
        'Learn to recognize different types of apps'
      ],
      challenges: [
        GameChallenge(
          id: 'app_sorter_1',
          type: ChallengeType.appSorter,
          question:
              'App Sorter: Drag these apps into the correct boxes - System Software or Application Software!',
          options: [
            'Calculator',
            'Android OS',
            'Paint',
            'Windows',
            'Notes App',
            'iOS'
          ],
          correctAnswerIndex: 0, // All correctly sorted
          explanation:
              'Perfect sorting! System Software (Android, Windows, iOS) runs the device. Application Software (Calculator, Paint, Notes) does specific tasks.',
          points: 100,
          interactiveData: {
            'gameType': 'appSorter',
            'categories': ['System Software', 'Application Software'],
            'items': [
              {
                'name': 'Calculator',
                'type': 'application',
                'icon': 'calculator.png'
              },
              {'name': 'Android OS', 'type': 'system', 'icon': 'android.png'},
              {'name': 'Paint', 'type': 'application', 'icon': 'paint.png'},
              {'name': 'Windows', 'type': 'system', 'icon': 'windows.png'},
              {'name': 'Notes App', 'type': 'application', 'icon': 'notes.png'},
              {'name': 'iOS', 'type': 'system', 'icon': 'ios.png'}
            ],
            'instructions': 'Drag each app icon to the correct category box'
          },
        ),
        GameChallenge(
          id: 'app_management_1',
          type: ChallengeType.scenario,
          question:
              'You opened a drawing app and finished your artwork. What should you do next?',
          options: [
            'Leave it running in the background',
            'Save your work and close the app properly',
            'Turn off the device immediately',
            'Open more apps'
          ],
          correctAnswerIndex: 1,
          explanation:
              'Always save your work first, then close apps properly to keep your device running smoothly.',
          points: 70,
        ),
        GameChallenge(
          id: 'app_safety_1',
          type: ChallengeType.multipleChoice,
          question:
              'Which of these is the safest way to get new apps for your device?',
          options: [
            'Download from unknown websites',
            'Use official app stores like Google Play or App Store',
            'Get apps from friends via email',
            'Download from any website'
          ],
          correctAnswerIndex: 1,
          explanation:
              'Official app stores check apps for safety before making them available to download.',
          points: 80,
        ),
        GameChallenge(
          id: 'app_types_1',
          type: ChallengeType.matchUp,
          question: 'Match each app type with its purpose:',
          options: [
            'Calculator - Math tasks',
            'Music Player - Playing songs',
            'Notes - Writing reminders',
            'Camera - Taking photos'
          ],
          correctAnswerIndex: 0, // All matched correctly
          explanation:
              'Great job! Each app is designed for a specific purpose to help you with different tasks.',
          points: 60,
          interactiveData: {
            'gameType': 'matchUp',
            'pairs': [
              {'left': 'Calculator', 'right': 'Math tasks'},
              {'left': 'Music Player', 'right': 'Playing songs'},
              {'left': 'Notes', 'right': 'Writing reminders'},
              {'left': 'Camera', 'right': 'Taking photos'}
            ],
            'instructions':
                'Draw lines to connect each app with its main purpose'
          },
        ),
      ],
    );
  }

  static GameLevel _createWhyDigitalSkillsMatterLevel() {
    return GameLevel(
      levelNumber: 4,
      title: 'Future Hero',
      theme: 'Why Digital Skills Matter',
      description:
          'Discover how digital heroes in your community use technology to improve their lives!',
      backgroundImagePath: 'assets/images/backgrounds/future_bg.png',
      characterImagePath: 'assets/images/characters/future_hero.png',
      targetScore: 350,
      timeLimit: 200,
      learningObjective:
          'Students will understand how digital skills benefit real people in their community and future careers.',
      tips: [
        'Digital skills help people in every profession',
        'Technology connects rural communities to the world',
        'These skills open doors to new opportunities',
        'Start learning now to prepare for your future'
      ],
      challenges: [
        GameChallenge(
          id: 'digital_heroes_1',
          type: ChallengeType.matchUp,
          question:
              'Digital Heroes Match-Up: Connect each person with how digital skills help them!',
          options: [
            'Farmer using weather app',
            'Shopkeeper with payment QR code',
            'Student learning online',
            'Doctor using digital records'
          ],
          correctAnswerIndex: 0, // All matched correctly
          explanation:
              'Amazing! You connected each digital hero with their tools: Farmers check weather, shopkeepers accept digital payments, students learn online, and doctors keep digital records.',
          points: 100,
          interactiveData: {
            'gameType': 'matchUp',
            'pairs': [
              {
                'image': 'farmer_weather.png',
                'description':
                    'Farmer checks weather forecast to plan planting and harvesting'
              },
              {
                'image': 'shopkeeper_qr.png',
                'description':
                    'Local shopkeeper accepts digital payments for customer convenience'
              },
              {
                'image': 'student_online.png',
                'description':
                    'Student accesses online lessons and educational resources'
              },
              {
                'image': 'doctor_records.png',
                'description':
                    'Doctor maintains digital patient records for better healthcare'
              }
            ],
            'instructions':
                'Match each picture with the correct description of how they use digital skills'
          },
        ),
        GameChallenge(
          id: 'career_benefits_1',
          type: ChallengeType.multipleChoice,
          question:
              'How do digital skills help a rural teacher improve their teaching?',
          options: [
            'They make teaching harder',
            'They allow access to online resources, educational videos, and virtual classrooms',
            'They are only useful for entertainment',
            'They replace the need for students'
          ],
          correctAnswerIndex: 1,
          explanation:
              'Digital skills help teachers find better educational resources, create engaging lessons, and even teach students remotely when needed.',
          points: 80,
        ),
        GameChallenge(
          id: 'community_impact_1',
          type: ChallengeType.scenario,
          question:
              'A village needs to apply for a government program online. Who can help using digital skills?',
          options: [
            'No one - rural people cannot use technology',
            'Anyone who has learned basic computer and internet skills',
            'Only city people can do this',
            'It is impossible to do from a village'
          ],
          correctAnswerIndex: 1,
          explanation:
              'With basic digital skills, anyone can help their community access government services, apply for programs, and connect with resources online.',
          points: 90,
        ),
        GameChallenge(
          id: 'future_opportunities_1',
          type: ChallengeType.dragAndDrop,
          question:
              'Drag these digital skills to match the opportunities they create:',
          options: [
            'Online selling - Start your own business',
            'Video calling - Connect with family far away',
            'Digital banking - Save money safely',
            'Online learning - Access any course worldwide'
          ],
          correctAnswerIndex: 0, // All matched correctly
          explanation:
              'Perfect! Digital skills create countless opportunities: online businesses, staying connected with loved ones, safe banking, and learning anything you want.',
          points: 80,
        ),
      ],
    );
  }

  // Unit 2: Using Digital Tools for School and Learning
  static GameLevel _createMasteringLearningAppLevel() {
    return GameLevel(
      levelNumber: 5,
      title: 'Learning App Expert',
      theme: 'Mastering Our Learning App',
      description:
          'Join your friendly guide on a Guided Quest to master this learning app!',
      backgroundImagePath: 'assets/images/backgrounds/learning_bg.png',
      characterImagePath: 'assets/images/characters/learning_hero.png',
      targetScore: 380,
      timeLimit: 240,
      learningObjective:
          'Students will navigate educational apps confidently and use offline features effectively.',
      tips: [
        'Follow your guide step-by-step for the best experience',
        'Practice each feature until you feel comfortable',
        'Download lessons for offline study',
        'Celebrate each milestone you complete!'
      ],
      challenges: [
        GameChallenge(
          id: 'guided_quest_1',
          type: ChallengeType.interactive,
          question:
              'Guided Quest: Welcome! Let your friendly guide help you log in for the first time.',
          options: [
            'Login completed!',
            'Need help',
            'Try again',
            'Guide me through'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Excellent! You successfully logged in. Your guide is proud of you! 🎉',
          points: 80,
          interactiveData: {
            'gameType': 'guidedQuest',
            'step': 'login',
            'guide_character': 'learning_buddy',
            'instructions':
                'Follow the glowing highlights to complete your first login',
            'celebration': 'login_badge'
          },
        ),
        GameChallenge(
          id: 'guided_quest_2',
          type: ChallengeType.interactive,
          question:
              'Guided Quest: Now let your guide show you how to find and start your first lesson!',
          options: [
            'Lesson started!',
            'Show me again',
            'I found it!',
            'Guide me more'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Amazing! You found your first lesson. Your learning journey has begun! 📚',
          points: 90,
          interactiveData: {
            'gameType': 'guidedQuest',
            'step': 'find_lesson',
            'guide_character': 'learning_buddy',
            'instructions': 'Tap the lesson your guide highlights for you',
            'celebration': 'explorer_badge'
          },
        ),
        GameChallenge(
          id: 'guided_quest_3',
          type: ChallengeType.interactive,
          question:
              'Guided Quest: Time to take your first quiz! Your guide believes in you.',
          options: [
            'Quiz completed!',
            'Help me',
            'I can do this!',
            'More guidance please'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Fantastic! You completed your first quiz. You are becoming a digital learner! 🌟',
          points: 100,
          interactiveData: {
            'gameType': 'guidedQuest',
            'step': 'take_quiz',
            'guide_character': 'learning_buddy',
            'instructions':
                'Answer the quiz questions with your guide is cheering you on',
            'celebration': 'quiz_master_badge'
          },
        ),
        GameChallenge(
          id: 'offline_features_1',
          type: ChallengeType.multipleChoice,
          question:
              'Why is it important to download lessons for offline use in rural areas?',
          options: [
            'It uses more battery power',
            'Internet may not always be available',
            'It makes the app slower',
            'Downloaded lessons cost more'
          ],
          correctAnswerIndex: 1,
          explanation:
              'Downloading lessons ensures you can continue learning even when internet connection is limited or unavailable.',
          points: 70,
        ),
      ],
    );
  }

  static GameLevel _createWritingAndTypingLevel() {
    return GameLevel(
      levelNumber: 6,
      title: 'Typing Champion',
      theme: 'Writing and Typing',
      description:
          'Become a Typing Star! Practice with words falling from the sky in your language and English.',
      backgroundImagePath: 'assets/images/backgrounds/typing_bg.png',
      characterImagePath: 'assets/images/characters/typing_hero.png',
      targetScore: 350,
      timeLimit: 220,
      learningObjective:
          'Students will develop typing skills in local language and English through engaging practice.',
      tips: [
        'Start with single letters, then move to words',
        'Keep your eyes on the screen, not the keyboard',
        'Practice both your local language and English',
        'Speed comes with practice - focus on accuracy first'
      ],
      challenges: [
        GameChallenge(
          id: 'typing_star_1',
          type: ChallengeType.typingChallenge,
          question:
              'Typing Star: Type these falling letters before they reach the bottom! A, S, D, F',
          options: [
            'All letters typed!',
            'Try again',
            'Almost there!',
            'Perfect accuracy!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Great start! You caught all the falling letters. Now you understand the basic typing positions.',
          points: 70,
          interactiveData: {
            'gameType': 'typingChallenge',
            'level': 'letters',
            'content': ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
            'fallSpeed': 'slow',
            'language': 'english',
            'instructions': 'Type each letter as it falls down the screen'
          },
        ),
        GameChallenge(
          id: 'typing_star_2',
          type: ChallengeType.typingChallenge,
          question:
              'Typing Star: Now catch these English words! CAT, DOG, SUN, TREE',
          options: [
            'All words typed!',
            'Keep practicing',
            'Getting better!',
            'Word master!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Excellent! You are becoming a typing star with English words. Your accuracy is improving!',
          points: 90,
          interactiveData: {
            'gameType': 'typingChallenge',
            'level': 'words',
            'content': [
              'CAT',
              'DOG',
              'SUN',
              'TREE',
              'BOOK',
              'HOME',
              'PLAY',
              'LEARN'
            ],
            'fallSpeed': 'medium',
            'language': 'english',
            'instructions': 'Type the complete word before it disappears'
          },
        ),
        GameChallenge(
          id: 'typing_star_3',
          type: ChallengeType.typingChallenge,
          question:
              'Typing Star: Practice with your local language! (ਪੰਜਾਬੀ example: ਘਰ, ਸਕੂਲ, ਕਿਤਾਬ)',
          options: [
            'Local words typed!',
            'Keep trying',
            'Great progress!',
            'Language expert!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Wonderful! You can type in your local language too. This skill will help you communicate with family and friends.',
          points: 100,
          interactiveData: {
            'gameType': 'typingChallenge',
            'level': 'local_words',
            'content': [
              'ਘਰ',
              'ਸਕੂਲ',
              'ਕਿਤਾਬ',
              'ਦੋਸਤ',
              'ਪਾਣੀ',
              'ਭੋਜਨ'
            ], // Punjabi words
            'fallSpeed': 'slow',
            'language': 'punjabi',
            'instructions': 'Type words in your local language'
          },
        ),
        GameChallenge(
          id: 'typing_star_4',
          type: ChallengeType.typingChallenge,
          question:
              'Typing Star: Final challenge! Type this sentence: "My Village"',
          options: [
            'Sentence completed!',
            'Try again',
            'Almost perfect!',
            'Typing champion!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Amazing! You typed a complete sentence. You are now ready to write stories, emails, and homework on any device!',
          points: 80,
          interactiveData: {
            'gameType': 'typingChallenge',
            'level': 'sentence',
            'content': [
              'My Village',
              'I love learning',
              'Digital skills are fun'
            ],
            'fallSpeed': 'medium',
            'language': 'english',
            'instructions': 'Type the complete sentence accurately'
          },
        ),
      ],
    );
  }

  static GameLevel _createCreatingPresentationsLevel() {
    return GameLevel(
      levelNumber: 7,
      title: 'Presentation Pro',
      theme: 'Creating Presentations',
      description:
          'Become a Slide Designer! Create beautiful presentations step-by-step with guided tasks.',
      backgroundImagePath: 'assets/images/backgrounds/presentation_bg.png',
      characterImagePath: 'assets/images/characters/presentation_hero.png',
      targetScore: 320,
      timeLimit: 240,
      learningObjective:
          'Students will create simple but effective presentations using guided design tasks.',
      tips: [
        'Follow each task step-by-step for best results',
        'Keep slides simple and easy to read',
        'Use pictures to make your message clearer',
        'Practice presenting your work out loud'
      ],
      challenges: [
        GameChallenge(
          id: 'slide_designer_1',
          type: ChallengeType.slideDesigner,
          question:
              'Slide Designer: Task 1 - Create a title slide for "My Village"',
          options: [
            'Title slide created!',
            'Let me try again',
            'Show me how',
            'Perfect design!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Excellent! You created a beautiful title slide. A good title slide introduces your presentation topic clearly.',
          points: 80,
          interactiveData: {
            'gameType': 'slideDesigner',
            'task': 'create_title_slide',
            'requirements': {
              'title': 'My Village',
              'subtitle': 'A presentation by [Student Name]',
              'background': 'village_theme'
            },
            'tools': ['text_box', 'background_selector', 'font_options'],
            'instructions': 'Use the text tool to add your title and subtitle'
          },
        ),
        GameChallenge(
          id: 'slide_designer_2',
          type: ChallengeType.slideDesigner,
          question:
              'Slide Designer: Task 2 - Add a picture of a flower to your slide',
          options: [
            'Picture added!',
            'Help me position it',
            'Choose different picture',
            'Looks great!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Wonderful! Pictures make presentations more interesting and help explain your ideas better.',
          points: 90,
          interactiveData: {
            'gameType': 'slideDesigner',
            'task': 'add_image',
            'requirements': {
              'image_type': 'flower',
              'position': 'center_right',
              'size': 'medium'
            },
            'tools': ['image_gallery', 'resize_handles', 'position_guides'],
            'instructions': 'Select a flower image and place it on your slide'
          },
        ),
        GameChallenge(
          id: 'slide_designer_3',
          type: ChallengeType.slideDesigner,
          question:
              'Slide Designer: Task 3 - Choose a nice background color for your presentation',
          options: [
            'Background chosen!',
            'Try different color',
            'Looks beautiful!',
            'Perfect choice!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Great color choice! The right background makes your text easy to read and your presentation look professional.',
          points: 70,
          interactiveData: {
            'gameType': 'slideDesigner',
            'task': 'choose_background',
            'requirements': {
              'color_family': 'nature_colors',
              'contrast': 'good_readability'
            },
            'tools': ['color_picker', 'theme_selector', 'preview_mode'],
            'instructions':
                'Pick a background color that makes your text easy to read'
          },
        ),
        GameChallenge(
          id: 'presentation_tips_1',
          type: ChallengeType.multipleChoice,
          question: 'What makes a good presentation slide?',
          options: [
            'Lots of text and many colors',
            'Clear title, simple text, and relevant pictures',
            'Fancy animations and loud colors',
            'Only pictures with no text'
          ],
          correctAnswerIndex: 1,
          explanation:
              'Perfect! Good slides have clear titles, simple text that is easy to read, and pictures that support your message.',
          points: 60,
        ),
      ],
    );
  }

  static GameLevel _createOrganizingDigitalWorkLevel() {
    return GameLevel(
      levelNumber: 8,
      title: 'File Organizer',
      theme: 'Organizing Digital Work',
      description:
          'Clean up the messy desktop! Use the File Organizer game to sort files into proper folders.',
      backgroundImagePath: 'assets/images/backgrounds/organize_bg.png',
      characterImagePath: 'assets/images/characters/organize_hero.png',
      targetScore: 350,
      timeLimit: 200,
      learningObjective:
          'Students will organize digital files effectively using proper folder structures.',
      tips: [
        'Create folders for different types of work',
        'Use clear, descriptive names for files and folders',
        'Keep schoolwork separate from personal files',
        'Organize regularly to avoid clutter'
      ],
      challenges: [
        GameChallenge(
          id: 'file_organizer_1',
          type: ChallengeType.fileOrganizer,
          question:
              'File Organizer: This desktop is messy! Create folders for "Schoolwork" and "Personal" then organize these files.',
          options: [
            'All files organized!',
            'Let me try again',
            'Help me sort',
            'Perfect organization!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Excellent organization! You created proper folders and sorted all files correctly. Now you can find your work easily!',
          points: 120,
          interactiveData: {
            'gameType': 'fileOrganizer',
            'messyFiles': [
              {
                'name': 'Math_Homework.txt',
                'type': 'schoolwork',
                'icon': 'text_file.png'
              },
              {
                'name': 'My_Drawing.jpg',
                'type': 'personal',
                'icon': 'image_file.png'
              },
              {
                'name': 'English_Story.txt',
                'type': 'schoolwork',
                'icon': 'text_file.png'
              },
              {
                'name': 'Family_Photo.jpg',
                'type': 'personal',
                'icon': 'image_file.png'
              },
              {
                'name': 'Science_Notes.txt',
                'type': 'schoolwork',
                'icon': 'text_file.png'
              },
              {
                'name': 'Birthday_Video.mp4',
                'type': 'personal',
                'icon': 'video_file.png'
              }
            ],
            'targetFolders': ['Schoolwork', 'Personal'],
            'instructions':
                'First create the folders, then drag each file to the correct folder'
          },
        ),
        GameChallenge(
          id: 'file_naming_1',
          type: ChallengeType.multipleChoice,
          question:
              'Which is the best name for a file containing your math homework from Monday?',
          options: [
            'file1.txt',
            'Math_Homework_Monday.txt',
            'homework.txt',
            'untitled.txt'
          ],
          correctAnswerIndex: 1,
          explanation:
              'Perfect! "Math_Homework_Monday.txt" tells you exactly what the file contains and when it was from.',
          points: 70,
        ),
        GameChallenge(
          id: 'folder_structure_1',
          type: ChallengeType.scenario,
          question:
              'You have many school subjects. How should you organize your schoolwork folder?',
          options: [
            'Put everything in one big folder',
            'Create separate folders for each subject (Math, English, Science, etc.)',
            'Create folders by date only',
            'Do not use folders at all'
          ],
          correctAnswerIndex: 1,
          explanation:
              'Excellent choice! Separate folders for each subject make it easy to find specific homework or notes quickly.',
          points: 80,
        ),
        GameChallenge(
          id: 'backup_importance_1',
          type: ChallengeType.trueFalse,
          question:
              'It is important to back up your important school files to prevent losing them.',
          options: ['True', 'False'],
          correctAnswerIndex: 0,
          explanation:
              'True! Backing up files protects your hard work. Save important files in multiple places or cloud storage.',
          points: 60,
        ),
      ],
    );
  }

  // Placeholder methods for remaining levels (to be implemented)
  static GameLevel _createWhatIsInternetLevel() {
    return GameLevel(
        levelNumber: 9,
        title: 'Internet Explorer',
        theme: 'What is the Internet',
        description:
            'Discover the internet and become a Browser Navigator expert!',
        backgroundImagePath: 'assets/images/backgrounds/internet_bg.png',
        characterImagePath: 'assets/images/characters/internet_hero.png',
        targetScore: 320,
        timeLimit: 200,
        learningObjective:
            'Students will understand internet basics and navigate web browsers confidently.',
        tips: [
          'The internet connects computers all around the world',
          'Web browsers are your gateway to the internet',
          'Learn the parts of a browser to navigate better',
          'Always connect to secure, trusted networks'
        ],
        challenges: [
          GameChallenge(
            id: 'browser_navigator_1',
            type: ChallengeType.browserNavigator,
            question:
                'Browser Navigator: Click on the Address Bar in this web browser!',
            options: [
              'Address Bar found!',
              'Try again',
              'Show me where',
              'Perfect!'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Excellent! The Address Bar is where you type website addresses (URLs) like www.google.com.',
            points: 80,
            interactiveData: {
              'gameType': 'browserNavigator',
              'browserParts': [
                'address_bar',
                'back_button',
                'forward_button',
                'refresh_button',
                'tabs',
                'bookmarks'
              ],
              'targetPart': 'address_bar',
              'instructions': 'Find and click on the Address Bar'
            },
          ),
          GameChallenge(
            id: 'browser_navigator_2',
            type: ChallengeType.browserNavigator,
            question: 'Browser Navigator: Where is the Back Button located?',
            options: [
              'Back Button found!',
              'Let me look again',
              'Help me find it',
              'Got it!'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Great job! The Back Button takes you to the previous page you visited, just like going back in a book.',
            points: 70,
            interactiveData: {
              'gameType': 'browserNavigator',
              'browserParts': [
                'address_bar',
                'back_button',
                'forward_button',
                'refresh_button',
                'tabs',
                'bookmarks'
              ],
              'targetPart': 'back_button',
              'instructions': 'Locate the Back Button on the browser'
            },
          ),
          GameChallenge(
            id: 'internet_connection_1',
            type: ChallengeType.multipleChoice,
            question: 'What do you need to access the internet?',
            options: [
              'Just a computer or phone',
              'A device and an internet connection (Wi-Fi or mobile data)',
              'Only a very expensive computer',
              'Nothing special'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Correct! You need both a device (computer, phone, tablet) AND an internet connection to go online.',
            points: 60,
          ),
          GameChallenge(
            id: 'browser_navigation_1',
            type: ChallengeType.scenario,
            question:
                'You want to visit a website but typed the wrong address. What should you do?',
            options: [
              'Turn off the computer',
              'Click the Back Button or correct the address in the Address Bar',
              'Close the browser completely',
              'Wait for the page to load anyway'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Perfect! You can either go back to the previous page or fix the website address you typed.',
            points: 70,
          ),
        ]);
  }

  static GameLevel _createSearchingInformationLevel() {
    return GameLevel(
        levelNumber: 10,
        title: 'Search Master',
        theme: 'Searching for Information',
        description: 'Embark on a Search Quest to find information like a pro!',
        backgroundImagePath: 'assets/images/backgrounds/search_bg.png',
        characterImagePath: 'assets/images/characters/search_hero.png',
        targetScore: 340,
        timeLimit: 220,
        learningObjective:
            'Students will learn effective search techniques and evaluate search results.',
        tips: [
          'Use simple, clear keywords for better results',
          'Try different word combinations if you do not find what you need',
          'Check multiple sources to verify information',
          'Look for reliable websites with good information'
        ],
        challenges: [
          GameChallenge(
            id: 'search_quest_1',
            type: ChallengeType.searchQuest,
            question:
                'Search Quest: What is the capital of India? Type your search keywords in the search bar.',
            options: [
              'Delhi found!',
              'Try different keywords',
              'Search again',
              'Correct answer!'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Excellent searching! You used good keywords and found that New Delhi is the capital of India.',
            points: 90,
            interactiveData: {
              'gameType': 'searchQuest',
              'question': 'What is the capital of India?',
              'acceptableKeywords': [
                'capital India',
                'India capital',
                'capital of India',
                'Delhi India'
              ],
              'correctAnswer': 'New Delhi',
              'simulatedResults': [
                {
                  'title': 'Capital of India - Wikipedia',
                  'snippet': 'New Delhi is the capital of India...',
                  'credible': true
                },
                {
                  'title': 'India Facts and Information',
                  'snippet': 'The capital city is New Delhi...',
                  'credible': true
                },
                {
                  'title': 'Random Blog Post',
                  'snippet': 'I think the capital might be Mumbai...',
                  'credible': false
                }
              ],
              'instructions':
                  'Type keywords to search, then click on a credible result'
            },
          ),
          GameChallenge(
            id: 'search_quest_2',
            type: ChallengeType.searchQuest,
            question:
                'Search Quest: Find information about the solar system. Choose the best search result!',
            options: [
              'Good source found!',
              'Try another result',
              'Keep searching',
              'Perfect choice!'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Great job! You chose a reliable educational website with accurate information about the solar system.',
            points: 100,
            interactiveData: {
              'gameType': 'searchQuest',
              'question': 'solar system facts',
              'acceptableKeywords': [
                'solar system',
                'planets',
                'solar system facts',
                'planets information'
              ],
              'simulatedResults': [
                {
                  'title': 'Solar System - NASA Education',
                  'snippet': 'Learn about the planets, sun, and moons...',
                  'credible': true,
                  'source': 'NASA'
                },
                {
                  'title': 'My Space Blog',
                  'snippet': 'I made up some facts about space...',
                  'credible': false,
                  'source': 'Personal Blog'
                },
                {
                  'title': 'National Geographic Kids - Solar System',
                  'snippet': 'Fun facts about planets for children...',
                  'credible': true,
                  'source': 'National Geographic'
                }
              ],
              'instructions':
                  'Search for solar system information and pick the most reliable source'
            },
          ),
          GameChallenge(
            id: 'keyword_skills_1',
            type: ChallengeType.multipleChoice,
            question:
                'You want to find information about growing vegetables. What are the best search keywords?',
            options: [
              'vegetables',
              'how to grow vegetables',
              'asdfjkl',
              'grow vegetables garden tips'
            ],
            correctAnswerIndex: 3,
            explanation:
                'Perfect! Using specific keywords like "grow vegetables garden tips" gives you more detailed and useful results.',
            points: 70,
          ),
          GameChallenge(
            id: 'source_evaluation_1',
            type: ChallengeType.scenario,
            question:
                'You find two websites about healthy eating. One is from a hospital, one is from an unknown blog. Which is more reliable?',
            options: [
              'The unknown blog',
              'The hospital website',
              'Both are equally reliable',
              'Neither can be trusted'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Excellent thinking! Hospital websites are more reliable for health information because they have medical experts.',
            points: 80,
          ),
        ]);
  }

  static GameLevel _createStayingSafeOnlineLevel() {
    return GameLevel(
        levelNumber: 11,
        title: 'Safety Guardian',
        theme: 'Staying Safe Online',
        description:
            'Play "Safe or Unsafe?" scenarios to become a digital safety expert!',
        backgroundImagePath: 'assets/images/backgrounds/safety_bg.png',
        characterImagePath: 'assets/images/characters/safety_hero.png',
        targetScore: 380,
        timeLimit: 240,
        learningObjective:
            'Students will identify online safety risks and make smart decisions to protect themselves.',
        tips: [
          'Never share personal information with strangers online',
          'Tell a trusted adult if something online makes you uncomfortable',
          'Use strong passwords and keep them secret',
          'Think carefully before clicking links or downloading files'
        ],
        challenges: [
          GameChallenge(
            id: 'safe_unsafe_1',
            type: ChallengeType.safetyScenario,
            question:
                'Safe or Unsafe? A stranger in an online game asks for your phone number. What do you do?',
            options: [
              'Give them my phone number',
              'Never share personal information with strangers',
              'Ask my friends what to do first',
              'Share only my area code'
            ],
            correctAnswerIndex: 1,
            explanation:
                'SAFE choice! Never share personal information like phone numbers, addresses, or real names with strangers online. This protects you and your family.',
            points: 100,
            interactiveData: {
              'gameType': 'safetyScenario',
              'scenario': 'stranger_asking_phone',
              'riskLevel': 'high',
              'safetyTip':
                  'Personal information should only be shared with people you know and trust in real life.'
            },
          ),
          GameChallenge(
            id: 'safe_unsafe_2',
            type: ChallengeType.safetyScenario,
            question:
                'Safe or Unsafe? You receive an email saying you won ₹10,000! It asks you to click a link and enter your bank details.',
            options: [
              'Click the link immediately to claim the prize',
              'Delete the email - this is likely a scam',
              'Forward it to all my friends',
              'Call the bank to give them my details'
            ],
            correctAnswerIndex: 1,
            explanation:
                'SAFE choice! This is a common scam. Real prizes do not ask for your bank details via email. Always delete suspicious emails.',
            points: 90,
            interactiveData: {
              'gameType': 'safetyScenario',
              'scenario': 'fake_prize_email',
              'riskLevel': 'high',
              'safetyTip':
                  'Be very suspicious of unexpected prizes or offers that ask for personal information.'
            },
          ),
          GameChallenge(
            id: 'safe_unsafe_3',
            type: ChallengeType.safetyScenario,
            question:
                'Safe or Unsafe? A friend sends you a funny video link, but it is from a website you have never heard of.',
            options: [
              'Click it immediately',
              'Ask your friend if the link is safe first',
              'Download the video right away',
              'Share the link with everyone'
            ],
            correctAnswerIndex: 1,
            explanation:
                'SAFE choice! Even links from friends can be dangerous if their account was hacked. Always verify suspicious links before clicking.',
            points: 80,
            interactiveData: {
              'gameType': 'safetyScenario',
              'scenario': 'suspicious_link_from_friend',
              'riskLevel': 'medium',
              'safetyTip':
                  'When in doubt about a link, ask the sender if they really sent it before clicking.'
            },
          ),
          GameChallenge(
            id: 'password_safety_1',
            type: ChallengeType.multipleChoice,
            question: 'Which is the strongest password?',
            options: ['123456', 'password', 'MyVillage2024!', 'abcdef'],
            correctAnswerIndex: 2,
            explanation:
                'Excellent! "MyVillage2024!" is strong because it combines letters, numbers, and symbols. It is also something you can remember.',
            points: 70,
          ),
        ]);
  }

  static GameLevel _createBeingGoodDigitalCitizenLevel() {
    return GameLevel(
        levelNumber: 12,
        title: 'Digital Citizen',
        theme: 'Being a Good Digital Citizen',
        description:
            'Navigate Digital Citizen Dilemmas and learn to be kind and respectful online!',
        backgroundImagePath: 'assets/images/backgrounds/citizen_bg.png',
        characterImagePath: 'assets/images/characters/citizen_hero.png',
        targetScore: 360,
        timeLimit: 220,
        learningObjective:
            'Students will understand digital citizenship principles and practice ethical online behavior.',
        tips: [
          'Treat others online the same way you want to be treated',
          'Respect other people is creative work and ideas',
          'Think before you post - words can hurt people',
          'Help create a positive and supportive online community'
        ],
        challenges: [
          GameChallenge(
            id: 'digital_dilemma_1',
            type: ChallengeType.scenario,
            question:
                'Digital Citizen Dilemma: You need a picture for your school project. What should you do?',
            options: [
              'Take any picture from the internet without asking',
              'Use a free-to-use image website or draw it yourself',
              'Copy a picture from your friend is project',
              'Use any picture and say you made it'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Excellent choice! Using free-to-use images or creating your own shows respect for other people is work and follows copyright rules.',
            points: 90,
            interactiveData: {
              'gameType': 'ethicalDecision',
              'dilemma': 'copyright_respect',
              'lesson':
                  'Always respect the creative work of others and follow copyright rules.'
            },
          ),
          GameChallenge(
            id: 'digital_dilemma_2',
            type: ChallengeType.scenario,
            question:
                'Digital Citizen Dilemma: Someone in your class group chat is being mean to another student. What do you do?',
            options: [
              'Join in the mean comments',
              'Tell them to stop and report it to a teacher',
              'Ignore it completely',
              'Share screenshots with other friends for fun'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Perfect! Standing up against online bullying and getting adult help protects everyone and creates a safer online community.',
            points: 100,
            interactiveData: {
              'gameType': 'ethicalDecision',
              'dilemma': 'cyberbullying_response',
              'lesson':
                  'Good digital citizens stand up against online bullying and help create safe spaces for everyone.'
            },
          ),
          GameChallenge(
            id: 'digital_dilemma_3',
            type: ChallengeType.scenario,
            question:
                'Digital Citizen Dilemma: You found amazing notes online that would help with your homework. What is the right thing to do?',
            options: [
              'Copy them exactly and submit as your own work',
              'Use them to understand the topic better, then write your own answers',
              'Change a few words and submit them',
              'Share them with everyone without checking if they are correct'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Wonderful! Using resources to learn and then creating your own work shows integrity and helps you truly understand the subject.',
            points: 80,
            interactiveData: {
              'gameType': 'ethicalDecision',
              'dilemma': 'academic_integrity',
              'lesson':
                  'Learning from others is good, but your work should be your own thoughts and understanding.'
            },
          ),
          GameChallenge(
            id: 'positive_communication_1',
            type: ChallengeType.multipleChoice,
            question: 'What is the best way to disagree with someone online?',
            options: [
              'Use all capital letters to show you are serious',
              'Explain your different opinion politely and respectfully',
              'Post mean comments about the person',
              'Get all your friends to argue with them'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Perfect! Respectful disagreement shows maturity and helps create positive online discussions where everyone can learn.',
            points: 70,
          ),
        ]);
  }

  static GameLevel _createIntroductionToEmailLevel() {
    return GameLevel(
        levelNumber: 13,
        title: 'Email Expert',
        theme: 'Introduction to Email',
        description:
            'All aboard Email Express! Learn to compose, send, and manage emails like a professional.',
        backgroundImagePath: 'assets/images/backgrounds/email_bg.png',
        characterImagePath: 'assets/images/characters/email_hero.png',
        targetScore: 360,
        timeLimit: 240,
        learningObjective:
            'Students will learn email basics including composing, sending, and managing attachments safely.',
        tips: [
          'Always use clear and descriptive subject lines',
          'Write polite and respectful messages',
          'Double-check attachments before sending',
          'Proofread your email before clicking send'
        ],
        challenges: [
          GameChallenge(
            id: 'email_express_1',
            type: ChallengeType.emailComposer,
            question:
                'Email Express: Compose an email to your teacher about submitting homework.',
            options: [
              'Email sent successfully!',
              'Let me revise this',
              'Check my work',
              'Perfect email!'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Excellent email! You used a clear subject line, polite greeting, explained your purpose, and signed off properly.',
            points: 100,
            interactiveData: {
              'gameType': 'emailComposer',
              'task': 'homework_submission',
              'requiredFields': {
                'to': 'teacher@school.edu',
                'subject': 'Homework Submission - [Student Name]',
                'greeting': 'Dear Teacher',
                'body': 'explain homework submission',
                'closing': 'polite closing',
                'signature': 'student name'
              },
              'sampleEmail': {
                'to': 'teacher@school.edu',
                'subject': 'Math Homework Submission - Raj Patel',
                'body':
                    'Dear Ms. Sharma,\n\nI am submitting my math homework for today. I have attached the completed worksheets.\n\nThank you for your help in class today.\n\nBest regards,\nRaj Patel'
              },
              'instructions': 'Fill in each field of the email properly'
            },
          ),
          GameChallenge(
            id: 'email_attachment_1',
            type: ChallengeType.emailComposer,
            question:
                'Email Express: Your teacher asked you to email your completed presentation. Add the file attachment!',
            options: [
              'File attached!',
              'Try again',
              'Check file type',
              'Successfully attached!'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Perfect! You successfully attached your presentation file. Always double-check that you attached the right file before sending.',
            points: 90,
            interactiveData: {
              'gameType': 'emailComposer',
              'task': 'add_attachment',
              'fileToAttach': 'MyPresentation.pptx',
              'instructions':
                  'Click the attachment button and select your presentation file'
            },
          ),
          GameChallenge(
            id: 'email_etiquette_1',
            type: ChallengeType.multipleChoice,
            question:
                'What is the best subject line for an email asking your teacher about homework?',
            options: [
              'hey',
              'Question About Math Homework - [Your Name]',
              'URGENT!!!',
              'idk'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Perfect! A good subject line clearly states the purpose and includes your name so the teacher knows who sent it.',
            points: 70,
          ),
          GameChallenge(
            id: 'email_safety_1',
            type: ChallengeType.scenario,
            question:
                'You receive an email from an unknown sender with an attachment. What should you do?',
            options: [
              'Open the attachment immediately',
              'Delete the email without opening the attachment',
              'Forward it to all your friends',
              'Reply asking for more information'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Excellent safety choice! Never open attachments from unknown senders as they could contain viruses or malware.',
            points: 80,
          ),
        ]);
  }

  static GameLevel _createMessagingAppsSafetyLevel() {
    return GameLevel(
        levelNumber: 14,
        title: 'Message Master',
        theme: 'Messaging Apps Safety',
        description:
            'Practice Chat Smart skills! Join a simulated class group chat and learn proper messaging etiquette.',
        backgroundImagePath: 'assets/images/backgrounds/message_bg.png',
        characterImagePath: 'assets/images/characters/message_hero.png',
        targetScore: 320,
        timeLimit: 200,
        learningObjective:
            'Students will communicate safely and appropriately in digital messaging platforms.',
        tips: [
          'Only message people you know in real life',
          'Keep conversations school-appropriate and respectful',
          'Think before you send - messages can be screenshot',
          'Ask for help if someone makes you uncomfortable'
        ],
        challenges: [
          GameChallenge(
            id: 'chat_smart_1',
            type: ChallengeType.chatSimulator,
            question:
                'Chat Smart: The teacher bot just asked "What is the capital of your state?" Choose the best response.',
            options: [
              'Chandigarh is the capital of Punjab',
              'lol idk 😂😂😂',
              'why do we need to know this???',
              'CHANDIGARH!!!!!!'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Perfect! Your response was informative, respectful, and appropriate for a class discussion. Great communication skills!',
            points: 90,
            interactiveData: {
              'gameType': 'chatSimulator',
              'chatContext': 'class_group',
              'teacher_question': 'What is the capital of your state?',
              'good_responses': [
                'factual answers',
                'polite questions',
                'helpful comments'
              ],
              'bad_responses': [
                'all caps',
                'inappropriate jokes',
                'disrespectful comments'
              ],
              'instructions':
                  'Choose the most appropriate response for a class group chat'
            },
          ),
          GameChallenge(
            id: 'chat_smart_2',
            type: ChallengeType.chatSimulator,
            question:
                'Chat Smart: A classmate shared their homework answers. How should you respond?',
            options: [
              'Thanks! I will copy these exactly.',
              'Thanks for sharing! This helps me understand the topic better.',
              'Can you just do my homework for me too?',
              'Everyone copy these answers!'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Excellent! You showed appreciation while maintaining academic integrity. Using help to understand rather than copy shows good digital citizenship.',
            points: 85,
            interactiveData: {
              'gameType': 'chatSimulator',
              'chatContext': 'homework_help',
              'scenario': 'classmate_shares_homework',
              'lesson': 'academic_integrity',
              'instructions':
                  'Respond in a way that is grateful but academically honest'
            },
          ),
          GameChallenge(
            id: 'message_privacy_1',
            type: ChallengeType.scenario,
            question:
                'Your friend wants to add someone you do not know to your class group chat. What should you do?',
            options: [
              'Add them immediately',
              'Ask the teacher first since this is a class group',
              'Add them but block them later',
              'Leave the group chat'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Smart thinking! Class group chats should only include class members. Always check with the teacher before adding outsiders.',
            points: 80,
          ),
          GameChallenge(
            id: 'appropriate_language_1',
            type: ChallengeType.multipleChoice,
            question:
                'Which message is most appropriate for a school group chat?',
            options: [
              'OMG this homework is sooooo boring 😴',
              'Can someone help me understand question 3?',
              'I hate this class!!!',
              'The teacher is so annoying'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Perfect! Asking for help politely keeps the conversation positive and focused on learning.',
            points: 75,
          ),
        ]);
  }

  static GameLevel _createUnderstandingProgressLevel() {
    return GameLevel(
        levelNumber: 15,
        title: 'Progress Tracker',
        theme: 'Understanding Progress',
        description:
            'Become a Dashboard Detective! Learn to read charts and track your learning progress.',
        backgroundImagePath: 'assets/images/backgrounds/progress_bg.png',
        characterImagePath: 'assets/images/characters/progress_hero.png',
        targetScore: 300,
        timeLimit: 180,
        learningObjective:
            'Students will interpret progress data and use it to improve their learning.',
        tips: [
          'Charts and graphs show your progress visually',
          'Look for patterns in your learning data',
          'Celebrate your improvements and achievements',
          'Use progress information to set new learning goals'
        ],
        challenges: [
          GameChallenge(
            id: 'dashboard_detective_1',
            type: ChallengeType.dashboardReader,
            question:
                'Dashboard Detective: Look at this student dashboard. In which subject is the student scoring highest?',
            options: [
              'Math (85%)',
              'English (70%)',
              'Science (92%)',
              'History (75%)'
            ],
            correctAnswerIndex: 2,
            explanation:
                'Excellent detective work! Science has the highest score at 92%. This student is doing great in Science!',
            points: 80,
            interactiveData: {
              'gameType': 'dashboardReader',
              'dashboardData': {
                'subjects': [
                  {'name': 'Math', 'score': 85, 'color': 'blue'},
                  {'name': 'English', 'score': 70, 'color': 'green'},
                  {'name': 'Science', 'score': 92, 'color': 'red'},
                  {'name': 'History', 'score': 75, 'color': 'orange'}
                ],
                'chartType': 'bar_chart'
              },
              'question_focus': 'highest_score',
              'instructions': 'Look at the chart and find the tallest bar'
            },
          ),
          GameChallenge(
            id: 'dashboard_detective_2',
            type: ChallengeType.dashboardReader,
            question:
                'Dashboard Detective: Which lesson is incomplete according to this progress tracker?',
            options: [
              'Lesson 1: Complete ✓',
              'Lesson 2: Complete ✓',
              'Lesson 3: In Progress ⏳',
              'Lesson 4: Complete ✓'
            ],
            correctAnswerIndex: 2,
            explanation:
                'Great observation! Lesson 3 shows "In Progress" which means it needs to be finished. The ⏳ symbol helps you spot unfinished work.',
            points: 75,
            interactiveData: {
              'gameType': 'dashboardReader',
              'dashboardData': {
                'lessons': [
                  {'name': 'Lesson 1', 'status': 'complete', 'icon': '✓'},
                  {'name': 'Lesson 2', 'status': 'complete', 'icon': '✓'},
                  {'name': 'Lesson 3', 'status': 'in_progress', 'icon': '⏳'},
                  {'name': 'Lesson 4', 'status': 'complete', 'icon': '✓'}
                ]
              },
              'question_focus': 'incomplete_lesson',
              'instructions':
                  'Look for the lesson that is not marked as complete'
            },
          ),
          GameChallenge(
            id: 'progress_interpretation_1',
            type: ChallengeType.multipleChoice,
            question:
                'Your math scores for the last 4 weeks are: 60%, 65%, 70%, 75%. What does this show?',
            options: [
              'Your scores are getting worse',
              'Your scores are staying the same',
              'Your scores are improving steadily',
              'The data does not show any pattern'
            ],
            correctAnswerIndex: 2,
            explanation:
                'Excellent analysis! Your scores are increasing by 5% each week, showing steady improvement. Keep up the great work!',
            points: 70,
          ),
          GameChallenge(
            id: 'goal_setting_1',
            type: ChallengeType.scenario,
            question:
                'You see your English score is 70% while your goal is 80%. What is the best next step?',
            options: [
              'Give up on the goal',
              'Set an easier goal',
              'Practice more English lessons and ask for help',
              'Focus only on other subjects'
            ],
            correctAnswerIndex: 2,
            explanation:
                'Perfect mindset! Using your progress data to identify where you need more practice shows excellent learning skills.',
            points: 85,
          ),
        ]);
  }

  static GameLevel _createWorkingTogetherOnlineLevel() {
    return GameLevel(
        levelNumber: 16,
        title: 'Team Player',
        theme: 'Working Together Online',
        description:
            'Join Team Story Builders! Collaborate with an AI partner to write amazing stories together.',
        backgroundImagePath: 'assets/images/backgrounds/teamwork_bg.png',
        characterImagePath: 'assets/images/characters/team_hero.png',
        targetScore: 380,
        timeLimit: 260,
        learningObjective:
            'Students will learn digital collaboration skills through guided storytelling exercises.',
        tips: [
          'Listen to your partner is ideas and build on them',
          'Take turns contributing to keep collaboration fair',
          'Be encouraging and supportive of creativity',
          'Good collaboration makes better results than working alone'
        ],
        challenges: [
          GameChallenge(
            id: 'team_story_1',
            type: ChallengeType.interactive,
            question:
                'Team Story Builders: Your AI partner started: "Once upon a time, in a small village, there lived a young farmer named Arjun." Add the next sentence!',
            options: [
              'Added my sentence!',
              'Let me think more',
              'Great story so far!',
              'Perfect collaboration!'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Wonderful collaboration! You added a creative sentence that builds on your partner is beginning. Great teamwork makes stories come alive!',
            points: 100,
            interactiveData: {
              'gameType': 'collaborativeStory',
              'storyPrompt':
                  'Once upon a time, in a small village, there lived a young farmer named Arjun.',
              'partnerType': 'AI_writing_buddy',
              'turnStructure': 'alternating_sentences',
              'storyTheme': 'village_adventure',
              'instructions':
                  'Write the next sentence to continue the story your partner started'
            },
          ),
          GameChallenge(
            id: 'team_story_2',
            type: ChallengeType.interactive,
            question:
                'Team Story Builders: Now your AI partner continues: "Arjun discovered something magical in his field." Your turn to add excitement!',
            options: [
              'Added excitement!',
              'Great story twist!',
              'This is fun!',
              'Amazing teamwork!'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Fantastic! You kept the story exciting and built perfectly on your partner is idea. This is what great collaboration looks like!',
            points: 90,
            interactiveData: {
              'gameType': 'collaborativeStory',
              'previousSentence':
                  'Arjun discovered something magical in his field.',
              'storyContext': 'magical_discovery',
              'encourageElements': [
                'describe the discovery',
                'add character emotions',
                'create suspense'
              ],
              'instructions':
                  'Add a sentence that makes the story more exciting'
            },
          ),
          GameChallenge(
            id: 'collaboration_skills_1',
            type: ChallengeType.multipleChoice,
            question: 'What makes online collaboration work best?',
            options: [
              'One person does all the work',
              'Everyone takes turns and listens to each other',
              'The loudest person makes all decisions',
              'Working separately without talking'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Perfect! Good collaboration means everyone contributes, listens to others, and works together respectfully.',
            points: 70,
          ),
          GameChallenge(
            id: 'shared_document_1',
            type: ChallengeType.scenario,
            question:
                'You are working on a shared document with classmates. Someone accidentally deletes your work. What should you do?',
            options: [
              'Get angry and delete their work too',
              'Politely let them know and work together to fix it',
              'Quit the project immediately',
              'Complain to everyone about it'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Excellent response! Handling mistakes with kindness and problem-solving shows great digital collaboration skills.',
            points: 80,
          ),
        ]);
  }

  static GameLevel _createExploringHobbiesOnlineLevel() {
    return GameLevel(
        levelNumber: 17,
        title: 'Hobby Hunter',
        theme: 'Exploring Hobbies Online',
        description:
            'Become a Hobby Explorer! Discover and safely research your interests using online resources.',
        backgroundImagePath: 'assets/images/backgrounds/hobby_bg.png',
        characterImagePath: 'assets/images/characters/hobby_hero.png',
        targetScore: 330,
        timeLimit: 200,
        learningObjective:
            'Students will learn to safely explore personal interests and hobbies using online resources.',
        tips: [
          'Use trusted educational websites for learning new skills',
          'Watch instructional videos from reliable sources',
          'Practice new skills safely and gradually',
          'Share your discoveries with family and friends'
        ],
        challenges: [
          GameChallenge(
            id: 'hobby_explorer_1',
            type: ChallengeType.interactive,
            question:
                'Hobby Explorer: Choose a hobby you are interested in, then find a "How-To" video or article about it!',
            options: [
              'Gardening',
              'Cricket',
              'Art',
              'Cooking',
              'Music',
              'Photography'
            ],
            correctAnswerIndex: 0, // Any choice is correct
            explanation:
                'Wonderful exploration! You successfully found reliable learning resources for your hobby. The internet opens up endless learning opportunities!',
            points: 100,
            interactiveData: {
              'gameType': 'hobbyExplorer',
              'hobbies': [
                {
                  'name': 'Gardening',
                  'keywords': ['plant care', 'vegetable growing', 'garden tips']
                },
                {
                  'name': 'Cricket',
                  'keywords': [
                    'cricket rules',
                    'batting practice',
                    'bowling techniques'
                  ]
                },
                {
                  'name': 'Art',
                  'keywords': [
                    'drawing tutorials',
                    'painting basics',
                    'art supplies'
                  ]
                },
                {
                  'name': 'Cooking',
                  'keywords': [
                    'easy recipes',
                    'cooking basics',
                    'traditional dishes'
                  ]
                },
                {
                  'name': 'Music',
                  'keywords': [
                    'learn instruments',
                    'music theory',
                    'songs practice'
                  ]
                },
                {
                  'name': 'Photography',
                  'keywords': [
                    'photo tips',
                    'camera basics',
                    'composition rules'
                  ]
                }
              ],
              'trusted_sources': [
                'Khan Academy',
                'National Geographic Kids',
                'BBC Learning',
                'Government education sites'
              ],
              'instructions':
                  'Pick your hobby, then search for learning resources from trusted sites'
            },
          ),
          GameChallenge(
            id: 'reliable_sources_1',
            type: ChallengeType.multipleChoice,
            question:
                'You want to learn about growing vegetables. Which source is most reliable?',
            options: [
              'A random blog with no author name',
              'Government agricultural department website',
              'Social media post from unknown person',
              'Website selling expensive gardening products'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Excellent choice! Government agricultural websites have expert information and are not trying to sell you products.',
            points: 80,
          ),
          GameChallenge(
            id: 'skill_practice_1',
            type: ChallengeType.scenario,
            question:
                'You found a video teaching a new art technique that looks difficult. What is the best approach?',
            options: [
              'Try the hardest technique first',
              'Start with basic steps and practice slowly',
              'Skip the practice and try the final result',
              'Watch the video only without practicing'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Perfect learning strategy! Starting with basics and practicing gradually helps you build skills safely and successfully.',
            points: 75,
          ),
          GameChallenge(
            id: 'sharing_discoveries_1',
            type: ChallengeType.trueFalse,
            question:
                'It is good to share interesting and safe hobby discoveries with family and friends.',
            options: ['True', 'False'],
            correctAnswerIndex: 0,
            explanation:
                'True! Sharing positive discoveries spreads knowledge and can inspire others to explore new interests too.',
            points: 65,
          ),
        ]);
  }

  static GameLevel _createDigitalPaymentsSafetyLevel() {
    return GameLevel(
        levelNumber: 18,
        title: 'Money Guardian',
        theme: 'Digital Payments Safety',
        description:
            'Master the Scam Spotter game! Learn to identify online payment scams and protect your money.',
        backgroundImagePath: 'assets/images/backgrounds/payment_bg.png',
        characterImagePath: 'assets/images/characters/money_hero.png',
        targetScore: 380,
        timeLimit: 220,
        learningObjective:
            'Students will identify common digital payment scams and understand safe payment practices.',
        tips: [
          'Never share passwords, PINs, or OTPs with anyone',
          'Only use trusted payment apps and websites',
          'Be suspicious of unexpected prizes or urgent payment requests',
          'Always verify before making any online payments'
        ],
        challenges: [
          GameChallenge(
            id: 'scam_spotter_1',
            type: ChallengeType.scamSpotter,
            question:
                'Scam Spotter: "Congratulations! You have won ₹50,000! Click here and enter your PIN to claim!" - Swipe right for SAFE or left for SCAM.',
            options: [
              'SCAM - Swiped left!',
              'SAFE - Swiped right',
              'Not sure',
              'Need more info'
            ],
            correctAnswerIndex: 0,
            explanation:
                'CORRECT! This is a SCAM. Real prizes never ask for your PIN or password. Always delete messages like this immediately.',
            points: 100,
            interactiveData: {
              'gameType': 'scamSpotter',
              'message':
                  'Congratulations! You have won ₹50,000! Click here and enter your PIN to claim!',
              'scamType': 'fake_prize',
              'redFlags': [
                'unexpected prize',
                'asks for PIN',
                'urgent action required'
              ],
              'explanation': 'Legitimate prizes never ask for PINs or passwords'
            },
          ),
          GameChallenge(
            id: 'scam_spotter_2',
            type: ChallengeType.scamSpotter,
            question:
                'Scam Spotter: "Your account will be closed in 24 hours! Enter your bank details immediately to prevent this!" - SAFE or SCAM?',
            options: [
              'SCAM - Swiped left!',
              'SAFE - Swiped right',
              'Not sure',
              'Need more info'
            ],
            correctAnswerIndex: 0,
            explanation:
                'EXCELLENT! This is a SCAM. Banks never ask for details through messages and do not threaten to close accounts suddenly.',
            points: 90,
            interactiveData: {
              'gameType': 'scamSpotter',
              'message':
                  'Your account will be closed in 24 hours! Enter your bank details immediately to prevent this!',
              'scamType': 'urgent_threat',
              'redFlags': [
                'creates panic',
                'urgent deadline',
                'asks for bank details'
              ],
              'explanation':
                  'Real banks communicate through official channels and never threaten like this'
            },
          ),
          GameChallenge(
            id: 'scam_spotter_3',
            type: ChallengeType.scamSpotter,
            question:
                'Scam Spotter: "Thank you for your payment to XYZ Store. If this was not you, call 123-456-7890" - SAFE or SCAM?',
            options: [
              'SCAM - Swiped left!',
              'SAFE - Swiped right',
              'Not sure',
              'Need more info'
            ],
            correctAnswerIndex: 0,
            explanation:
                'SMART DETECTION! This is a SCAM. Scammers trick you into calling them by pretending someone used your account.',
            points: 95,
            interactiveData: {
              'gameType': 'scamSpotter',
              'message':
                  'Thank you for your payment to XYZ Store. If this was not you, call 123-456-7890',
              'scamType': 'fake_transaction_alert',
              'redFlags': [
                'unknown transaction',
                'asks you to call',
                'creates worry'
              ],
              'explanation':
                  'If you did not make a payment, check your bank app directly, do not call numbers from messages'
            },
          ),
          GameChallenge(
            id: 'payment_safety_1',
            type: ChallengeType.multipleChoice,
            question:
                'Your friend asks for your UPI PIN to help transfer money. What should you do?',
            options: [
              'Give them the PIN since they are your friend',
              'Never share your PIN with anyone, even friends',
              'Share it only this once',
              'Write it down for them'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Perfect! PINs are like the keys to your money - never share them with anyone, not even close friends or family.',
            points: 85,
          ),
        ]);
  }

  static GameLevel _createCareerOpportunitiesLevel() {
    return GameLevel(
        levelNumber: 19,
        title: 'Career Explorer',
        theme: 'Career Opportunities',
        description:
            'Go on a Career Quest to discover amazing careers and educational opportunities using the internet!',
        backgroundImagePath: 'assets/images/backgrounds/career_bg.png',
        characterImagePath: 'assets/images/characters/career_hero.png',
        targetScore: 360,
        timeLimit: 220,
        learningObjective:
            'Students will learn to research career opportunities and educational pathways online.',
        tips: [
          'Explore careers related to your favorite subjects',
          'Look for educational requirements and pathways',
          'Use government portals for reliable career information',
          'Dream big but plan step by step'
        ],
        challenges: [
          GameChallenge(
            id: 'career_quest_1',
            type: ChallengeType.careerExplorer,
            question:
                'Career Quest: You love Science! Research a career in healthcare and find what education you need.',
            options: [
              'Research completed!',
              'Found great information!',
              'This is interesting!',
              'Career discovered!'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Excellent research! You discovered that becoming a doctor requires studying Biology, Chemistry, and Physics, then medical college. Your science interest could lead to an amazing healthcare career!',
            points: 100,
            interactiveData: {
              'gameType': 'careerExplorer',
              'favoriteSubject': 'Science',
              'relatedCareers': [
                {
                  'name': 'Doctor',
                  'education': '12th Science + Medical College + Residency',
                  'skills': ['Biology', 'Chemistry', 'Physics']
                },
                {
                  'name': 'Nurse',
                  'education': '12th + Nursing College',
                  'skills': ['Biology', 'Health Care', 'Communication']
                },
                {
                  'name': 'Pharmacist',
                  'education': '12th Science + Pharmacy College',
                  'skills': ['Chemistry', 'Biology', 'Medicine Knowledge']
                }
              ],
              'researchPortals': [
                'Career360.com',
                'Government job portals',
                'University websites'
              ],
              'instructions':
                  'Pick a healthcare career and find its educational requirements'
            },
          ),
          GameChallenge(
            id: 'career_quest_2',
            type: ChallengeType.careerExplorer,
            question:
                'Career Quest: Research agriculture careers that use technology and find a college offering related courses.',
            options: [
              'Found great opportunities!',
              'Technology + farming = amazing!',
              'Career path mapped!',
              'Future planned!'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Wonderful discovery! Modern agriculture uses drones, GPS, and smart farming. You found that Agricultural Engineering combines technology with farming - perfect for tech-savvy farmers!',
            points: 95,
            interactiveData: {
              'gameType': 'careerExplorer',
              'careerField': 'Technology + Agriculture',
              'modernCareers': [
                {
                  'name': 'Agricultural Engineer',
                  'description':
                      'Designs farming machines and irrigation systems'
                },
                {
                  'name': 'Precision Agriculture Specialist',
                  'description': 'Uses GPS and drones for smart farming'
                },
                {
                  'name': 'Food Technology Expert',
                  'description': 'Develops new food processing methods'
                }
              ],
              'colleges': [
                'Agricultural Universities',
                'Engineering Colleges with Agri programs',
                'Technology Institutes'
              ],
              'instructions': 'Find how technology is changing farming careers'
            },
          ),
          GameChallenge(
            id: 'education_pathways_1',
            type: ChallengeType.multipleChoice,
            question:
                'You want to become a software developer. What educational path should you research?',
            options: [
              'Only expensive private colleges',
              'Computer Science degree, coding bootcamps, or online courses',
              'No education needed',
              'Only foreign universities'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Perfect! There are multiple paths to tech careers - traditional degrees, bootcamps, online courses, and self-learning. Research all options!',
            points: 75,
          ),
          GameChallenge(
            id: 'local_opportunities_1',
            type: ChallengeType.scenario,
            question:
                'You found an interesting career but think it is only available in big cities. What should you research next?',
            options: [
              'Give up on that career',
              'Research remote work opportunities and local demand',
              'Move to a big city immediately',
              'Choose a different career'
            ],
            correctAnswerIndex: 1,
            explanation:
                'Excellent thinking! Many careers now offer remote work, and rural areas often need professionals too. Always research all possibilities!',
            points: 80,
          ),
        ]);
  }

  static GameLevel _createDigitalPortfolioProjectLevel() {
    return GameLevel(
      levelNumber: 20,
      title: 'Portfolio Creator',
      theme: 'Digital Portfolio Project',
      description:
          'Digital Champion Challenge! Create your final portfolio showcasing all the amazing digital skills you have learned.',
      backgroundImagePath: 'assets/images/backgrounds/portfolio_bg.png',
      characterImagePath: 'assets/images/characters/portfolio_hero.png',
      targetScore: 500,
      timeLimit: 360,
      learningObjective:
          'Students will demonstrate mastery of all digital literacy skills through a comprehensive portfolio project.',
      tips: [
        'Include your best work from all 5 units',
        'Write about your digital learning journey',
        'Show how you will use these skills in the future',
        'Be proud of how much you have learned!'
      ],
      challenges: [
        GameChallenge(
          id: 'digital_champion_1',
          type: ChallengeType.interactive,
          question:
              'Digital Champion Challenge: Create a title page for your portfolio with your name and a photo or drawing!',
          options: [
            'Title page created!',
            'Looking great!',
            'Almost done!',
            'Digital Champion in progress!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Fantastic start! Your portfolio title page introduces you as the digital champion you have become. Each piece you complete earns part of your final Digital Champion trophy! 🏆',
          points: 100,
          interactiveData: {
            'gameType': 'portfolioBuilder',
            'section': 'title_page',
            'requirements': [
              'student_name',
              'photo_or_drawing',
              'portfolio_title',
              'date'
            ],
            'template': 'professional_student_portfolio',
            'celebrationAsset': 'trophy_piece_1'
          },
        ),
        GameChallenge(
          id: 'digital_champion_2',
          type: ChallengeType.interactive,
          question:
              'Digital Champion Challenge: Add a section showing your best work from Unit 1 (Device knowledge) through Unit 5 (Career planning)!',
          options: [
            'All units showcased!',
            'Skills demonstrated!',
            'Portfolio growing!',
            'Champion progress!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Outstanding! You showcased work from all 5 units - from learning about devices to planning your career. You earned another piece of your Digital Champion trophy! 🌟',
          points: 150,
          interactiveData: {
            'gameType': 'portfolioBuilder',
            'section': 'skills_showcase',
            'units': [
              {'unit': 1, 'achievement': 'Device Builder master'},
              {'unit': 2, 'achievement': 'Typing Star graduate'},
              {'unit': 3, 'achievement': 'Safety Guardian certified'},
              {'unit': 4, 'achievement': 'Team Story Builder expert'},
              {'unit': 5, 'achievement': 'Career Quest explorer'}
            ],
            'celebrationAsset': 'trophy_piece_2'
          },
        ),
        GameChallenge(
          id: 'digital_champion_3',
          type: ChallengeType.interactive,
          question:
              'Digital Champion Challenge: Write about your digital learning journey - what you learned and how you will use these skills!',
          options: [
            'Journey documented!',
            'Story completed!',
            'Reflection finished!',
            'Future planned!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'Incredible reflection! Writing about your learning journey shows how much you have grown. You have become a true digital literacy hero! 🦸‍♂️',
          points: 125,
          interactiveData: {
            'gameType': 'portfolioBuilder',
            'section': 'reflection_essay',
            'prompts': [
              'What was the most challenging thing you learned?',
              'Which digital skill will be most useful in your daily life?',
              'How will you help others learn digital skills?',
              'What digital goals do you have for the future?'
            ],
            'celebrationAsset': 'trophy_piece_3'
          },
        ),
        GameChallenge(
          id: 'digital_champion_4',
          type: ChallengeType.interactive,
          question:
              'Digital Champion Challenge: Complete your portfolio and claim your Digital Champion certificate!',
          options: [
            'Portfolio complete!',
            'Digital Champion achieved!',
            'Mission accomplished!',
            'Hero status unlocked!'
          ],
          correctAnswerIndex: 0,
          explanation:
              'CONGRATULATIONS! 🎉 You have completed your Digital Champion Challenge and earned your certificate! You are now officially a Digital Literacy Hero who can help others learn these important skills. Your journey in the digital world has just begun!',
          points: 125,
          interactiveData: {
            'gameType': 'portfolioBuilder',
            'section': 'final_completion',
            'celebration': 'digital_champion_certificate',
            'achievements_unlocked': [
              'Digital Champion',
              'Portfolio Creator',
              'Digital Literacy Hero'
            ],
            'final_message':
                'You have mastered all digital literacy skills and are ready to help others on their digital journey!'
          },
        ),
      ],
    );
  }
}
