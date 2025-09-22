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
          'Learn about different types of devices and identify their main parts.',
      backgroundImagePath: 'assets/images/backgrounds/device_bg.png',
      characterImagePath: 'assets/images/characters/explorer_hero.png',
      targetScore: 250,
      timeLimit: 150,
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
          id: 'device_1',
          type: ChallengeType.multipleChoice,
          question: 'Which of these is NOT a main part of a computer?',
          options: ['Monitor', 'Keyboard', 'Refrigerator', 'Mouse'],
          correctAnswerIndex: 2,
          explanation:
              'Computers have monitors, keyboards, and mice, but not refrigerators!',
          points: 50,
        ),
        GameChallenge(
          id: 'device_2',
          type: ChallengeType.dragAndDrop,
          question: 'Match each device with its main use:',
          options: ['Smartphone - Communication', 'Tablet - Reading', 'Computer - Work', 'TV - Entertainment'],
          correctAnswerIndex: 0,
          explanation:
              'Different devices are designed for different purposes, though many can do multiple things.',
          points: 75,
        ),
        GameChallenge(
          id: 'device_3',
          type: ChallengeType.trueFalse,
          question: 'You should always turn off a device properly instead of just unplugging it.',
          options: ['True', 'False'],
          correctAnswerIndex: 0,
          explanation:
              'Proper shutdown saves your work and protects the device from damage.',
          points: 60,
        ),
        GameChallenge(
          id: 'device_4',
          type: ChallengeType.interactive,
          question: 'Identify the parts of this computer setup!',
          options: ['Parts Identified'],
          correctAnswerIndex: 0,
          explanation: 'Great job learning about device parts!',
          points: 65,
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
          'Discover desktop icons, menus, and learn basic mouse and touch navigation.',
      backgroundImagePath: 'assets/images/backgrounds/screen_bg.png',
      characterImagePath: 'assets/images/characters/navigator_hero.png',
      targetScore: 300,
      timeLimit: 180,
      learningObjective:
          'Students will understand desktop elements and basic navigation using mouse or touch.',
      tips: [
        'Icons are small pictures that represent apps or files',
        'Click once to select, double-click to open',
        'On touch screens, tap once to select',
        'Menus show you different options'
      ],
      challenges: [
        GameChallenge(
          id: 'screen_1',
          type: ChallengeType.multipleChoice,
          question: 'What do icons on a screen represent?',
          options: ['Decorations', 'Apps and files', 'Nothing important', 'Screen protectors'],
          correctAnswerIndex: 1,
          explanation:
              'Icons are small pictures that help you find and open apps and files.',
          points: 60,
        ),
        GameChallenge(
          id: 'screen_2',
          type: ChallengeType.scenario,
          question: 'You want to open a calculator app. What should you do?',
          options: ['Double-click the calculator icon', 'Shake the device', 'Press any key', 'Turn off the device'],
          correctAnswerIndex: 0,
          explanation:
              'Double-clicking (or tapping on touch screens) opens apps and files.',
          points: 80,
        ),
        GameChallenge(
          id: 'screen_3',
          type: ChallengeType.dragAndDrop,
          question: 'Put these mouse actions in order to open a file:',
          options: ['Point to icon', 'Move mouse', 'Double-click', 'File opens'],
          correctAnswerIndex: 0,
          explanation:
              'First move the mouse to point at the icon, then double-click to open it.',
          points: 90,
        ),
        GameChallenge(
          id: 'screen_4',
          type: ChallengeType.interactive,
          question: 'Practice navigating this desktop!',
          options: ['Navigation Complete'],
          correctAnswerIndex: 0,
          explanation: 'Excellent navigation skills!',
          points: 70,
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
          'Learn what software and apps are, and how to open and close them safely.',
      backgroundImagePath: 'assets/images/backgrounds/apps_bg.png',
      characterImagePath: 'assets/images/characters/app_hero.png',
      targetScore: 280,
      timeLimit: 160,
      learningObjective:
          'Students will understand the difference between system and application software and learn to use apps safely.',
      tips: [
        'Apps are programs that help you do specific tasks',
        'Always close apps properly when done',
        'System software runs the device itself',
        'Try basic apps like calculator and notepad first'
      ],
      challenges: [
        GameChallenge(
          id: 'apps_1',
          type: ChallengeType.multipleChoice,
          question: 'What is the difference between system software and application software?',
          options: [
            'There is no difference',
            'System software runs the device, apps do specific tasks',
            'Apps are always free, system software costs money',
            'System software is newer than apps'
          ],
          correctAnswerIndex: 1,
          explanation:
              'System software (like Android or Windows) runs your device, while apps do specific tasks like calculating or drawing.',
          points: 70,
        ),
        GameChallenge(
          id: 'apps_2',
          type: ChallengeType.scenario,
          question: 'You finished using a drawing app. What should you do?',
          options: ['Leave it open', 'Close it properly', 'Turn off the device', 'Delete the app'],
          correctAnswerIndex: 1,
          explanation:
              'Closing apps properly saves memory and keeps your device running smoothly.',
          points: 60,
        ),
        GameChallenge(
          id: 'apps_3',
          type: ChallengeType.trueFalse,
          question: 'A calculator app is an example of application software.',
          options: ['True', 'False'],
          correctAnswerIndex: 0,
          explanation:
              'Calculator apps help you do specific tasks, making them application software.',
          points: 50,
        ),
        GameChallenge(
          id: 'apps_4',
          type: ChallengeType.interactive,
          question: 'Practice opening and closing these basic apps!',
          options: ['Practice Complete'],
          correctAnswerIndex: 0,
          explanation: 'Great job managing apps safely!',
          points: 100,
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
          'Discover how digital tools help in education, jobs, and daily life for your future success.',
      backgroundImagePath: 'assets/images/backgrounds/future_bg.png',
      characterImagePath: 'assets/images/characters/future_hero.png',
      targetScore: 320,
      timeLimit: 180,
      learningObjective:
          'Students will understand the importance of digital skills for their education and future careers.',
      tips: [
        'Digital skills help in almost every job today',
        'Technology makes learning more fun and interactive',
        'Digital tools connect you with people worldwide',
        'These skills will grow more important over time'
      ],
      challenges: [
        GameChallenge(
          id: 'future_1',
          type: ChallengeType.multipleChoice,
          question: 'How do digital skills help in education?',
          options: [
            'They make homework harder',
            'They allow access to online learning and research',
            'They are only for entertainment',
            'They replace the need for teachers'
          ],
          correctAnswerIndex: 1,
          explanation:
              'Digital skills open up endless learning opportunities through online resources, educational apps, and research tools.',
          points: 80,
        ),
        GameChallenge(
          id: 'future_2',
          type: ChallengeType.scenario,
          question: 'A farmer wants to check weather forecasts and crop prices. How do digital skills help?',
          options: [
            'Digital skills are not useful for farmers',
            'They can access weather apps and market information online',
            'They only help with entertainment',
            'They make farming more difficult'
          ],
          correctAnswerIndex: 1,
          explanation:
              'Digital tools help farmers make better decisions with weather forecasts, market prices, and farming techniques.',
          points: 90,
        ),
        GameChallenge(
          id: 'future_3',
          type: ChallengeType.dragAndDrop,
          question: 'Match these careers with how they use digital skills:',
          options: ['Teacher - Online lessons', 'Doctor - Digital records', 'Artist - Digital design', 'Shopkeeper - Digital payments'],
          correctAnswerIndex: 0,
          explanation:
              'Almost every career today uses digital tools to work more effectively.',
          points: 100,
        ),
        GameChallenge(
          id: 'future_4',
          type: ChallengeType.interactive,
          question: 'Explore how digital heroes in your region succeeded!',
          options: ['Exploration Complete'],
          correctAnswerIndex: 0,
          explanation: 'You can be a digital hero too!',
          points: 50,
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
      description: 'Master the learning app with login, lessons, videos, and offline features.',
      backgroundImagePath: 'assets/images/backgrounds/learning_bg.png',
      characterImagePath: 'assets/images/characters/learning_hero.png',
      targetScore: 350,
      timeLimit: 200,
      learningObjective: 'Students will effectively navigate and use educational apps.',
      tips: ['Practice logging in safely', 'Download lessons for offline use', 'Complete quizzes to test knowledge', 'Watch videos for better understanding'],
      challenges: [
        GameChallenge(
          id: 'learning_1',
          type: ChallengeType.multipleChoice,
          question: 'What should you do first when using a new learning app?',
          options: ['Start any lesson', 'Create a secure login', 'Download everything', 'Share with friends'],
          correctAnswerIndex: 1,
          explanation: 'Creating a secure login protects your progress and personal information.',
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
      description: 'Learn keyboard layout and practice typing in your local language and English.',
      backgroundImagePath: 'assets/images/backgrounds/typing_bg.png',
      characterImagePath: 'assets/images/characters/typing_hero.png',
      targetScore: 300,
      timeLimit: 180,
      learningObjective: 'Students will develop basic typing skills in multiple languages.',
      tips: ['Start with proper finger placement', 'Practice regularly for improvement', 'Use both local language and English', 'Take breaks to avoid strain'],
      challenges: [
        GameChallenge(
          id: 'typing_1',
          type: ChallengeType.interactive,
          question: 'Complete this typing exercise: "My Village"',
          options: ['Exercise Complete'],
          correctAnswerIndex: 0,
          explanation: 'Great typing practice!',
          points: 100,
        ),
      ],
    );
  }

  static GameLevel _createCreatingPresentationsLevel() {
    return GameLevel(
      levelNumber: 7,
      title: 'Presentation Pro',
      theme: 'Creating Presentations',
      description: 'Learn to create simple presentations with text and images.',
      backgroundImagePath: 'assets/images/backgrounds/presentation_bg.png',
      characterImagePath: 'assets/images/characters/presentation_hero.png',
      targetScore: 280,
      timeLimit: 200,
      learningObjective: 'Students will create basic presentations using simple software.',
      tips: ['Keep slides simple and clear', 'Use images to support your message', 'Practice presenting your work', 'Save your work frequently'],
      challenges: [
        GameChallenge(
          id: 'presentation_1',
          type: ChallengeType.interactive,
          question: 'Create a 3-slide presentation about your favorite subject!',
          options: ['Presentation Created'],
          correctAnswerIndex: 0,
          explanation: 'Excellent presentation skills!',
          points: 120,
        ),
      ],
    );
  }

  static GameLevel _createOrganizingDigitalWorkLevel() {
    return GameLevel(
      levelNumber: 8,
      title: 'File Organizer',
      theme: 'Organizing Digital Work',
      description: 'Learn to create folders, name files properly, and organize your digital schoolwork.',
      backgroundImagePath: 'assets/images/backgrounds/organize_bg.png',
      characterImagePath: 'assets/images/characters/organize_hero.png',
      targetScore: 320,
      timeLimit: 160,
      learningObjective: 'Students will organize digital files and folders effectively.',
      tips: ['Use clear, descriptive file names', 'Create folders for different subjects', 'Save work in the right location', 'Back up important files'],
      challenges: [
        GameChallenge(
          id: 'organize_1',
          type: ChallengeType.interactive,
          question: 'Organize these school files into proper folders!',
          options: ['Files Organized'],
          correctAnswerIndex: 0,
          explanation: 'Perfect organization skills!',
          points: 100,
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
