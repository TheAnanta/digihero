import '../../../core/models/game_models.dart';
import '../../../core/constants/app_constants.dart';

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
          question: 'Device Builder: Drag and drop the labels onto the correct parts of this computer!',
          options: ['Monitor', 'CPU', 'Keyboard', 'Mouse'],
          correctAnswerIndex: 0, // All correct when properly placed
          explanation:
              'Great job! You correctly identified the main parts of a computer: Monitor (screen), CPU (main unit), Keyboard (for typing), and Mouse (for pointing).',
          points: 80,
          interactiveData: {
            'gameType': 'deviceBuilder',
            'deviceType': 'computer',
            'parts': ['Monitor', 'CPU', 'Keyboard', 'Mouse'],
            'instructions': 'Drag each label to the matching part of the computer'
          },
        ),
        GameChallenge(
          id: 'power_up_1',
          type: ChallengeType.sequencing,
          question: 'Power Up! Put these steps in the correct order to turn on a computer safely:',
          options: ['Plug in power cable', 'Press CPU power button', 'Press monitor power button', 'Wait for startup'],
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
          question: 'Which device is best for making phone calls while traveling?',
          options: ['Desktop Computer', 'Smartphone', 'Television', 'Printer'],
          correctAnswerIndex: 1,
          explanation:
              'Smartphones are portable and designed for communication, making them perfect for calls while traveling.',
          points: 50,
        ),
        GameChallenge(
          id: 'device_shutdown_1',
          type: ChallengeType.scenario,
          question: 'You finished your work on a tablet. What is the safest way to turn it off?',
          options: ['Just close the cover', 'Use the power button to shut down properly', 'Remove the battery', 'Wait for it to turn off automatically'],
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
            'desktopIcons': ['folder', 'recycle_bin', 'computer', 'documents', 'pictures'],
            'instructions': 'Tap the folder icon as quickly as you can!'
          },
        ),
        GameChallenge(
          id: 'icon_hunt_2',
          type: ChallengeType.iconHunt,
          question: 'Icon Hunt: Quick! Tap the Recycle Bin before time runs out!',
          options: ['Recycle Bin found!', 'Try again', 'Need a hint?', 'Time up!'],
          correctAnswerIndex: 0,
          explanation:
              'Excellent! The Recycle Bin holds deleted files and usually looks like a trash can.',
          points: 70,
          interactiveData: {
            'gameType': 'iconHunt',
            'targetIcon': 'recycle_bin',
            'timeLimit': 25,
            'desktopIcons': ['folder', 'recycle_bin', 'computer', 'documents', 'pictures', 'calculator'],
            'instructions': 'Find the Recycle Bin icon!'
          },
        ),
        GameChallenge(
          id: 'cursor_maestro_1',
          type: ChallengeType.cursorMaestro,
          question: 'Cursor Maestro: Drag the file into the folder!',
          options: ['Successfully moved!', 'Try again', 'Almost there!', 'Perfect technique!'],
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
          options: ['Picture opened!', 'Try again', 'Single click detected', 'Perfect timing!'],
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
          question: 'App Sorter: Drag these apps into the correct boxes - System Software or Application Software!',
          options: ['Calculator', 'Android OS', 'Paint', 'Windows', 'Notes App', 'iOS'],
          correctAnswerIndex: 0, // All correctly sorted
          explanation:
              'Perfect sorting! System Software (Android, Windows, iOS) runs the device. Application Software (Calculator, Paint, Notes) does specific tasks.',
          points: 100,
          interactiveData: {
            'gameType': 'appSorter',
            'categories': ['System Software', 'Application Software'],
            'items': [
              {'name': 'Calculator', 'type': 'application', 'icon': 'calculator.png'},
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
          question: 'You opened a drawing app and finished your artwork. What should you do next?',
          options: ['Leave it running in the background', 'Save your work and close the app properly', 'Turn off the device immediately', 'Open more apps'],
          correctAnswerIndex: 1,
          explanation:
              'Always save your work first, then close apps properly to keep your device running smoothly.',
          points: 70,
        ),
        GameChallenge(
          id: 'app_safety_1',
          type: ChallengeType.multipleChoice,
          question: 'Which of these is the safest way to get new apps for your device?',
          options: ['Download from unknown websites', 'Use official app stores like Google Play or App Store', 'Get apps from friends via email', 'Download from any website'],
          correctAnswerIndex: 1,
          explanation:
              'Official app stores check apps for safety before making them available to download.',
          points: 80,
        ),
        GameChallenge(
          id: 'app_types_1',
          type: ChallengeType.matchUp,
          question: 'Match each app type with its purpose:',
          options: ['Calculator - Math tasks', 'Music Player - Playing songs', 'Notes - Writing reminders', 'Camera - Taking photos'],
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
            'instructions': 'Draw lines to connect each app with its main purpose'
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
          question: 'Digital Heroes Match-Up: Connect each person with how digital skills help them!',
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
                'description': 'Farmer checks weather forecast to plan planting and harvesting'
              },
              {
                'image': 'shopkeeper_qr.png', 
                'description': 'Local shopkeeper accepts digital payments for customer convenience'
              },
              {
                'image': 'student_online.png',
                'description': 'Student accesses online lessons and educational resources'
              },
              {
                'image': 'doctor_records.png',
                'description': 'Doctor maintains digital patient records for better healthcare'
              }
            ],
            'instructions': 'Match each picture with the correct description of how they use digital skills'
          },
        ),
        GameChallenge(
          id: 'career_benefits_1',
          type: ChallengeType.multipleChoice,
          question: 'How do digital skills help a rural teacher improve their teaching?',
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
          question: 'A village needs to apply for a government program online. Who can help using digital skills?',
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
          question: 'Drag these digital skills to match the opportunities they create:',
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
      description: 'Join your friendly guide on a Guided Quest to master this learning app!',
      backgroundImagePath: 'assets/images/backgrounds/learning_bg.png',
      characterImagePath: 'assets/images/characters/learning_hero.png',
      targetScore: 380,
      timeLimit: 240,
      learningObjective: 'Students will navigate educational apps confidently and use offline features effectively.',
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
          question: 'Guided Quest: Welcome! Let your friendly guide help you log in for the first time.',
          options: ['Login completed!', 'Need help', 'Try again', 'Guide me through'],
          correctAnswerIndex: 0,
          explanation: 'Excellent! You successfully logged in. Your guide is proud of you! 🎉',
          points: 80,
          interactiveData: {
            'gameType': 'guidedQuest',
            'step': 'login',
            'guide_character': 'learning_buddy',
            'instructions': 'Follow the glowing highlights to complete your first login',
            'celebration': 'login_badge'
          },
        ),
        GameChallenge(
          id: 'guided_quest_2',
          type: ChallengeType.interactive,
          question: 'Guided Quest: Now let your guide show you how to find and start your first lesson!',
          options: ['Lesson started!', 'Show me again', 'I found it!', 'Guide me more'],
          correctAnswerIndex: 0,
          explanation: 'Amazing! You found your first lesson. Your learning journey has begun! 📚',
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
          question: 'Guided Quest: Time to take your first quiz! Your guide believes in you.',
          options: ['Quiz completed!', 'Help me', 'I can do this!', 'More guidance please'],
          correctAnswerIndex: 0,
          explanation: 'Fantastic! You completed your first quiz. You are becoming a digital learner! 🌟',
          points: 100,
          interactiveData: {
            'gameType': 'guidedQuest',
            'step': 'take_quiz',
            'guide_character': 'learning_buddy',
            'instructions': 'Answer the quiz questions with your guide is cheering you on',
            'celebration': 'quiz_master_badge'
          },
        ),
        GameChallenge(
          id: 'offline_features_1',
          type: ChallengeType.multipleChoice,
          question: 'Why is it important to download lessons for offline use in rural areas?',
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
      description: 'Become a Typing Star! Practice with words falling from the sky in your language and English.',
      backgroundImagePath: 'assets/images/backgrounds/typing_bg.png',
      characterImagePath: 'assets/images/characters/typing_hero.png',
      targetScore: 350,
      timeLimit: 220,
      learningObjective: 'Students will develop typing skills in local language and English through engaging practice.',
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
          question: 'Typing Star: Type these falling letters before they reach the bottom! A, S, D, F',
          options: ['All letters typed!', 'Try again', 'Almost there!', 'Perfect accuracy!'],
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
          question: 'Typing Star: Now catch these English words! CAT, DOG, SUN, TREE',
          options: ['All words typed!', 'Keep practicing', 'Getting better!', 'Word master!'],
          correctAnswerIndex: 0,
          explanation:
              'Excellent! You are becoming a typing star with English words. Your accuracy is improving!',
          points: 90,
          interactiveData: {
            'gameType': 'typingChallenge',
            'level': 'words',
            'content': ['CAT', 'DOG', 'SUN', 'TREE', 'BOOK', 'HOME', 'PLAY', 'LEARN'],
            'fallSpeed': 'medium',
            'language': 'english',
            'instructions': 'Type the complete word before it disappears'
          },
        ),
        GameChallenge(
          id: 'typing_star_3',
          type: ChallengeType.typingChallenge,
          question: 'Typing Star: Practice with your local language! (ਪੰਜਾਬੀ example: ਘਰ, ਸਕੂਲ, ਕਿਤਾਬ)',
          options: ['Local words typed!', 'Keep trying', 'Great progress!', 'Language expert!'],
          correctAnswerIndex: 0,
          explanation:
              'Wonderful! You can type in your local language too. This skill will help you communicate with family and friends.',
          points: 100,
          interactiveData: {
            'gameType': 'typingChallenge',
            'level': 'local_words',
            'content': ['ਘਰ', 'ਸਕੂਲ', 'ਕਿਤਾਬ', 'ਦੋਸਤ', 'ਪਾਣੀ', 'ਭੋਜਨ'], // Punjabi words
            'fallSpeed': 'slow',
            'language': 'punjabi',
            'instructions': 'Type words in your local language'
          },
        ),
        GameChallenge(
          id: 'typing_star_4',
          type: ChallengeType.typingChallenge,
          question: 'Typing Star: Final challenge! Type this sentence: "My Village"',
          options: ['Sentence completed!', 'Try again', 'Almost perfect!', 'Typing champion!'],
          correctAnswerIndex: 0,
          explanation:
              'Amazing! You typed a complete sentence. You are now ready to write stories, emails, and homework on any device!',
          points: 80,
          interactiveData: {
            'gameType': 'typingChallenge',
            'level': 'sentence',
            'content': ['My Village', 'I love learning', 'Digital skills are fun'],
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
      description: 'Become a Slide Designer! Create beautiful presentations step-by-step with guided tasks.',
      backgroundImagePath: 'assets/images/backgrounds/presentation_bg.png',
      characterImagePath: 'assets/images/characters/presentation_hero.png',
      targetScore: 320,
      timeLimit: 240,
      learningObjective: 'Students will create simple but effective presentations using guided design tasks.',
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
          question: 'Slide Designer: Task 1 - Create a title slide for "My Village"',
          options: ['Title slide created!', 'Let me try again', 'Show me how', 'Perfect design!'],
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
          question: 'Slide Designer: Task 2 - Add a picture of a flower to your slide',
          options: ['Picture added!', 'Help me position it', 'Choose different picture', 'Looks great!'],
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
          question: 'Slide Designer: Task 3 - Choose a nice background color for your presentation',
          options: ['Background chosen!', 'Try different color', 'Looks beautiful!', 'Perfect choice!'],
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
            'instructions': 'Pick a background color that makes your text easy to read'
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
      description: 'Clean up the messy desktop! Use the File Organizer game to sort files into proper folders.',
      backgroundImagePath: 'assets/images/backgrounds/organize_bg.png',
      characterImagePath: 'assets/images/characters/organize_hero.png',
      targetScore: 350,
      timeLimit: 200,
      learningObjective: 'Students will organize digital files effectively using proper folder structures.',
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
          question: 'File Organizer: This desktop is messy! Create folders for "Schoolwork" and "Personal" then organize these files.',
          options: ['All files organized!', 'Let me try again', 'Help me sort', 'Perfect organization!'],
          correctAnswerIndex: 0,
          explanation:
              'Excellent organization! You created proper folders and sorted all files correctly. Now you can find your work easily!',
          points: 120,
          interactiveData: {
            'gameType': 'fileOrganizer',
            'messyFiles': [
              {'name': 'Math_Homework.txt', 'type': 'schoolwork', 'icon': 'text_file.png'},
              {'name': 'My_Drawing.jpg', 'type': 'personal', 'icon': 'image_file.png'},
              {'name': 'English_Story.txt', 'type': 'schoolwork', 'icon': 'text_file.png'},
              {'name': 'Family_Photo.jpg', 'type': 'personal', 'icon': 'image_file.png'},
              {'name': 'Science_Notes.txt', 'type': 'schoolwork', 'icon': 'text_file.png'},
              {'name': 'Birthday_Video.mp4', 'type': 'personal', 'icon': 'video_file.png'}
            ],
            'targetFolders': ['Schoolwork', 'Personal'],
            'instructions': 'First create the folders, then drag each file to the correct folder'
          },
        ),
        GameChallenge(
          id: 'file_naming_1',
          type: ChallengeType.multipleChoice,
          question: 'Which is the best name for a file containing your math homework from Monday?',
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
          question: 'You have many school subjects. How should you organize your schoolwork folder?',
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
          question: 'It is important to back up your important school files to prevent losing them.',
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
    return GameLevel(levelNumber: 9, title: 'Internet Explorer', theme: 'What is the Internet', description: 'Understand the internet and how to connect safely.', backgroundImagePath: 'assets/images/backgrounds/internet_bg.png', characterImagePath: 'assets/images/characters/internet_hero.png', targetScore: 300, timeLimit: 180, learningObjective: 'Students will understand internet basics and connection methods.', tips: ['Internet connects computers worldwide', 'Wi-Fi and mobile data are connection methods', 'Browsers help you navigate the web', 'Always connect to secure networks'], challenges: [GameChallenge(id: 'internet_1', type: ChallengeType.multipleChoice, question: 'What is the internet?', options: ['A single computer', 'A global network of connected computers', 'A mobile app', 'A type of software'], correctAnswerIndex: 1, explanation: 'The internet is a global network connecting millions of computers worldwide.', points: 80)]);
  }

  static GameLevel _createSearchingInformationLevel() {
    return GameLevel(levelNumber: 10, title: 'Search Master', theme: 'Searching for Information', description: 'Learn to search effectively using search engines.', backgroundImagePath: 'assets/images/backgrounds/search_bg.png', characterImagePath: 'assets/images/characters/search_hero.png', targetScore: 300, timeLimit: 180, learningObjective: 'Students will learn effective search techniques.', tips: ['Use simple, clear keywords', 'Check multiple sources', 'Look for reliable websites', 'Practice makes perfect'], challenges: [GameChallenge(id: 'search_1', type: ChallengeType.interactive, question: 'Search for facts about the solar system!', options: ['Search Complete'], correctAnswerIndex: 0, explanation: 'Great searching skills!', points: 100)]);
  }

  static GameLevel _createStayingSafeOnlineLevel() {
    return GameLevel(levelNumber: 11, title: 'Safety Guardian', theme: 'Staying Safe Online', description: 'Learn to protect personal information and stay safe online.', backgroundImagePath: 'assets/images/backgrounds/safety_bg.png', characterImagePath: 'assets/images/characters/safety_hero.png', targetScore: 350, timeLimit: 200, learningObjective: 'Students will understand online safety principles.', tips: ['Never share personal information', 'Use strong passwords', 'Tell adults about uncomfortable content', 'Be careful with strangers online'], challenges: [GameChallenge(id: 'safety_1', type: ChallengeType.scenario, question: 'A stranger asks for your address online. What do you do?', options: ['Give them your address', 'Never share personal information', 'Ask friends first', 'Share only your city'], correctAnswerIndex: 1, explanation: 'Never share personal information with strangers online.', points: 100)]);
  }

  static GameLevel _createBeingGoodDigitalCitizenLevel() {
    return GameLevel(levelNumber: 12, title: 'Digital Citizen', theme: 'Being a Good Digital Citizen', description: 'Learn to be kind and respectful online.', backgroundImagePath: 'assets/images/backgrounds/citizen_bg.png', characterImagePath: 'assets/images/characters/citizen_hero.png', targetScore: 300, timeLimit: 180, learningObjective: 'Students will understand digital citizenship principles.', tips: ['Be kind to others online', 'Respect others work and ideas', 'Help create a positive online community', 'Think before you post'], challenges: [GameChallenge(id: 'citizen_1', type: ChallengeType.multipleChoice, question: 'What is good digital citizenship?', options: ['Posting anything you want', 'Being kind and respectful online', 'Copying others work', 'Sharing personal information'], correctAnswerIndex: 1, explanation: 'Good digital citizenship means being kind, respectful, and responsible online.', points: 80)]);
  }

  static GameLevel _createIntroductionToEmailLevel() {
    return GameLevel(levelNumber: 13, title: 'Email Expert', theme: 'Introduction to Email', description: 'Learn email basics: composing, sending, and attachments.', backgroundImagePath: 'assets/images/backgrounds/email_bg.png', characterImagePath: 'assets/images/characters/email_hero.png', targetScore: 320, timeLimit: 200, learningObjective: 'Students will learn basic email functionality.', tips: ['Use clear subject lines', 'Write polite messages', 'Check attachments before sending', 'Proofread before sending'], challenges: [GameChallenge(id: 'email_1', type: ChallengeType.interactive, question: 'Compose and send an email to your teacher!', options: ['Email Sent'], correctAnswerIndex: 0, explanation: 'Excellent email skills!', points: 100)]);
  }

  static GameLevel _createMessagingAppsSafetyLevel() {
    return GameLevel(levelNumber: 14, title: 'Message Master', theme: 'Messaging Apps Safety', description: 'Use messaging apps safely and responsibly for school.', backgroundImagePath: 'assets/images/backgrounds/message_bg.png', characterImagePath: 'assets/images/characters/message_hero.png', targetScore: 280, timeLimit: 160, learningObjective: 'Students will use messaging apps safely.', tips: ['Only message people you know', 'Keep conversations school-appropriate', 'Ask permission before sharing photos', 'Report inappropriate behavior'], challenges: [GameChallenge(id: 'message_1', type: ChallengeType.scenario, question: 'How should you participate in a class group chat?', options: ['Send lots of jokes', 'Stay focused on the topic', 'Share personal photos', 'Ignore the rules'], correctAnswerIndex: 1, explanation: 'Group chats work best when everyone stays focused on the topic.', points: 90)]);
  }

  static GameLevel _createUnderstandingProgressLevel() {
    return GameLevel(levelNumber: 15, title: 'Progress Tracker', theme: 'Understanding Progress', description: 'Learn to track your learning progress and improvement.', backgroundImagePath: 'assets/images/backgrounds/progress_bg.png', characterImagePath: 'assets/images/characters/progress_hero.png', targetScore: 250, timeLimit: 140, learningObjective: 'Students will understand how to track their learning progress.', tips: ['Check your dashboard regularly', 'Celebrate improvements', 'Identify areas for growth', 'Set learning goals'], challenges: [GameChallenge(id: 'progress_1', type: ChallengeType.interactive, question: 'Review your learning dashboard and identify one improvement area!', options: ['Review Complete'], correctAnswerIndex: 0, explanation: 'Self-reflection helps you learn better!', points: 80)]);
  }

  static GameLevel _createWorkingTogetherOnlineLevel() {
    return GameLevel(levelNumber: 16, title: 'Team Player', theme: 'Working Together Online', description: 'Learn to collaborate on digital projects with others.', backgroundImagePath: 'assets/images/backgrounds/teamwork_bg.png', characterImagePath: 'assets/images/characters/team_hero.png', targetScore: 340, timeLimit: 220, learningObjective: 'Students will learn digital collaboration skills.', tips: ['Communicate clearly with team members', 'Share ideas respectfully', 'Take turns contributing', 'Support your teammates'], challenges: [GameChallenge(id: 'teamwork_1', type: ChallengeType.interactive, question: 'Collaborate on creating a class story!', options: ['Story Created'], correctAnswerIndex: 0, explanation: 'Teamwork makes the dream work!', points: 120)]);
  }

  static GameLevel _createExploringHobbiesOnlineLevel() {
    return GameLevel(levelNumber: 17, title: 'Hobby Hunter', theme: 'Exploring Hobbies Online', description: 'Discover and learn about your interests using online resources.', backgroundImagePath: 'assets/images/backgrounds/hobby_bg.png', characterImagePath: 'assets/images/characters/hobby_hero.png', targetScore: 290, timeLimit: 180, learningObjective: 'Students will learn to explore hobbies safely online.', tips: ['Use trusted websites for learning', 'Watch educational videos', 'Practice new skills safely', 'Share discoveries with family'], challenges: [GameChallenge(id: 'hobby_1', type: ChallengeType.interactive, question: 'Research a hobby you are interested in and share one interesting fact!', options: ['Research Complete'], correctAnswerIndex: 0, explanation: 'Learning never stops!', points: 100)]);
  }

  static GameLevel _createDigitalPaymentsSafetyLevel() {
    return GameLevel(levelNumber: 18, title: 'Money Guardian', theme: 'Digital Payments Safety', description: 'Learn about digital payments and how to stay safe with online money.', backgroundImagePath: 'assets/images/backgrounds/payment_bg.png', characterImagePath: 'assets/images/characters/money_hero.png', targetScore: 350, timeLimit: 200, learningObjective: 'Students will understand digital payment safety.', tips: ['Never share passwords or PINs', 'Only use trusted payment apps', 'Ask adults before making payments', 'Watch out for payment scams'], challenges: [GameChallenge(id: 'payment_1', type: ChallengeType.multipleChoice, question: 'What should you do if someone asks for your payment PIN?', options: ['Share it if they seem nice', 'Never share PINs with anyone', 'Only share with friends', 'Write it down for them'], correctAnswerIndex: 1, explanation: 'PINs are like keys to your money - never share them!', points: 100)]);
  }

  static GameLevel _createCareerOpportunitiesLevel() {
    return GameLevel(levelNumber: 19, title: 'Career Explorer', theme: 'Career Opportunities', description: 'Discover careers and educational opportunities using the internet.', backgroundImagePath: 'assets/images/backgrounds/career_bg.png', characterImagePath: 'assets/images/characters/career_hero.png', targetScore: 320, timeLimit: 200, learningObjective: 'Students will learn to research career opportunities online.', tips: ['Explore different career paths', 'Look for educational requirements', 'Find government educational portals', 'Dream big and plan ahead'], challenges: [GameChallenge(id: 'career_1', type: ChallengeType.interactive, question: 'Research a career you are curious about!', options: ['Research Complete'], correctAnswerIndex: 0, explanation: 'Your future is bright!', points: 110)]);
  }

  static GameLevel _createDigitalPortfolioProjectLevel() {
    return GameLevel(
      levelNumber: 20,
      title: 'Portfolio Creator',
      theme: 'Digital Portfolio Project',
      description: 'Create a final project showcasing all your digital skills.',
      backgroundImagePath: 'assets/images/backgrounds/portfolio_bg.png',
      characterImagePath: 'assets/images/characters/portfolio_hero.png',
      targetScore: 400,
      timeLimit: 300,
      learningObjective: 'Students will demonstrate mastery of all digital literacy skills.',
      tips: [
        'Include work from all units',
        'Show your best efforts',
        'Write about your learning journey',
        'Plan how you will use these skills'
      ],
      challenges: [
        GameChallenge(
          id: 'portfolio_1',
          type: ChallengeType.interactive,
          question: 'Create your complete digital portfolio!',
          options: ['Portfolio Complete'],
          correctAnswerIndex: 0,
          explanation: 'Congratulations! You are now a digital literacy hero!',
          points: 200,
        ),
      ],
    );
  }
}
