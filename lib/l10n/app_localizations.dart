import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_pa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('pa')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'DigiHero'**
  String get appTitle;

  /// The tagline of the application
  ///
  /// In en, this message translates to:
  /// **'Digital Literacy Adventure'**
  String get appTagline;

  /// The subtitle of the application
  ///
  /// In en, this message translates to:
  /// **'Learn • Play • Protect • Explore'**
  String get appSubtitle;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome to DigiHero!'**
  String get welcomeToDigiHero;

  /// Description of what the app does
  ///
  /// In en, this message translates to:
  /// **'Learn digital literacy through fun games'**
  String get learnDigitalLiteracy;

  /// Age input question
  ///
  /// In en, this message translates to:
  /// **'How old are you?'**
  String get howOldAreYou;

  /// Help text for age input
  ///
  /// In en, this message translates to:
  /// **'This helps us adjust the game difficulty for you'**
  String get ageHelpText;

  /// Age input label
  ///
  /// In en, this message translates to:
  /// **'Your Age'**
  String get yourAge;

  /// Age input placeholder
  ///
  /// In en, this message translates to:
  /// **'Enter your age (6-99)'**
  String get enterYourAge;

  /// Start button text
  ///
  /// In en, this message translates to:
  /// **'Start Learning!'**
  String get startLearning;

  /// Level selection screen title
  ///
  /// In en, this message translates to:
  /// **'Choose Your Level'**
  String get chooseYourLevel;

  /// Level selection description
  ///
  /// In en, this message translates to:
  /// **'Select a digital literacy challenge'**
  String get selectDigitalLiteracyChallenge;

  /// Locked level title
  ///
  /// In en, this message translates to:
  /// **'Level Locked'**
  String get levelLocked;

  /// Message shown when level is locked
  ///
  /// In en, this message translates to:
  /// **'Complete the previous level to unlock this one!'**
  String get levelLockedMessage;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Yes button text
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No button text
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Positive feedback
  ///
  /// In en, this message translates to:
  /// **'Excellent!'**
  String get excellent;

  /// Positive feedback
  ///
  /// In en, this message translates to:
  /// **'Perfect!'**
  String get perfect;

  /// Positive feedback
  ///
  /// In en, this message translates to:
  /// **'Great!'**
  String get great;

  /// Try again button text
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// Loading text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Congratulations text
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// City name Nabha
  ///
  /// In en, this message translates to:
  /// **'Nabha'**
  String get nabha;

  /// State name Punjab
  ///
  /// In en, this message translates to:
  /// **'Punjab'**
  String get punjab;

  /// City name Chandigarh
  ///
  /// In en, this message translates to:
  /// **'Chandigarh'**
  String get chandigarh;

  /// Village
  ///
  /// In en, this message translates to:
  /// **'Village'**
  String get village;

  /// City
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// Splash screen tagline
  ///
  /// In en, this message translates to:
  /// **'Digital Literacy Adventure'**
  String get splashTagline;

  /// Start button text on splash screen
  ///
  /// In en, this message translates to:
  /// **'Tap to Start Adventure'**
  String get splashStartButton;

  /// Label for age input field
  ///
  /// In en, this message translates to:
  /// **'Your Age'**
  String get ageLabel;

  /// Placeholder text for age input
  ///
  /// In en, this message translates to:
  /// **'Enter your age (6-99)'**
  String get agePlaceholder;

  /// Beginner age group
  ///
  /// In en, this message translates to:
  /// **'6-8 years (Beginner)'**
  String get beginner;

  /// Intermediate age group
  ///
  /// In en, this message translates to:
  /// **'9-12 years (Intermediate)'**
  String get intermediate;

  /// Advanced age group
  ///
  /// In en, this message translates to:
  /// **'13-16 years (Advanced)'**
  String get advanced;

  /// Expert age group
  ///
  /// In en, this message translates to:
  /// **'17+ years (Expert)'**
  String get expert;

  /// Level selection header
  ///
  /// In en, this message translates to:
  /// **'Choose Your Level'**
  String get chooseLevel;

  /// Challenge selection subtitle
  ///
  /// In en, this message translates to:
  /// **'Select a digital literacy challenge'**
  String get selectChallenge;

  /// Settings menu title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Music setting
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// Sound effects setting
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get soundEffects;

  /// Music volume setting
  ///
  /// In en, this message translates to:
  /// **'Music Volume'**
  String get musicVolume;

  /// Sound effects volume setting
  ///
  /// In en, this message translates to:
  /// **'SFX Volume'**
  String get sfxVolume;

  /// Progress button text
  ///
  /// In en, this message translates to:
  /// **'PROGRESS'**
  String get progress;

  /// Achievements button text
  ///
  /// In en, this message translates to:
  /// **'ACHIEVEMENTS'**
  String get achievements;

  /// Progress screen title
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get yourProgress;

  /// Achievements screen title
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

  /// No achievements message
  ///
  /// In en, this message translates to:
  /// **'No achievements yet. Keep playing to unlock them!'**
  String get noAchievements;

  /// Player label
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get player;

  /// Levels completed stat
  ///
  /// In en, this message translates to:
  /// **'Levels Completed'**
  String get levelsCompleted;

  /// Total play time stat
  ///
  /// In en, this message translates to:
  /// **'Total Play Time'**
  String get totalPlayTime;

  /// Current streak stat
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get currentStreak;

  /// Days unit
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// Level complete dialog title
  ///
  /// In en, this message translates to:
  /// **'Level Complete!'**
  String get levelComplete;

  /// Game over dialog title
  ///
  /// In en, this message translates to:
  /// **'Game Over'**
  String get gameOver;

  /// Game over dialog message
  ///
  /// In en, this message translates to:
  /// **'Don\'t give up! Try again to master this level.'**
  String get gameOverMessage;

  /// Back to level select button
  ///
  /// In en, this message translates to:
  /// **'Back to Level Select'**
  String get backToLevelSelect;

  /// Exit level dialog title
  ///
  /// In en, this message translates to:
  /// **'Exit Level?'**
  String get exitLevel;

  /// Exit level dialog message
  ///
  /// In en, this message translates to:
  /// **'Your progress will be lost.'**
  String get exitLevelMessage;

  /// Exit button text
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// Wrong answer dialog title
  ///
  /// In en, this message translates to:
  /// **'Wrong Answer'**
  String get wrongAnswer;

  /// Wrong answer dialog message
  ///
  /// In en, this message translates to:
  /// **'That\'s not correct. Try again!'**
  String get wrongAnswerMessage;

  /// Hint button text
  ///
  /// In en, this message translates to:
  /// **'Hint'**
  String get hint;

  /// Time bonus label
  ///
  /// In en, this message translates to:
  /// **'Time Bonus'**
  String get timeBonus;

  /// Score label
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// Continue button text
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Play button text
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// Replay button text
  ///
  /// In en, this message translates to:
  /// **'Replay'**
  String get replay;

  /// Close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Start adventure button text
  ///
  /// In en, this message translates to:
  /// **'START ADVENTURE'**
  String get startAdventure;

  /// Overall progress label
  ///
  /// In en, this message translates to:
  /// **'Overall Progress'**
  String get overallProgress;

  /// Character speech text
  ///
  /// In en, this message translates to:
  /// **'Ready for another digital adventure?'**
  String get readyForAdventure;

  /// Coins label
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get coins;

  /// Lives label
  ///
  /// In en, this message translates to:
  /// **'Lives'**
  String get lives;

  /// Default player name
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get anonymous;

  /// Level 1 title
  ///
  /// In en, this message translates to:
  /// **'Device Explorer'**
  String get deviceExplorer;

  /// Level 1 theme
  ///
  /// In en, this message translates to:
  /// **'Meet Your Digital Device'**
  String get meetYourDigitalDevice;

  /// Level 1 description
  ///
  /// In en, this message translates to:
  /// **'Learn about different types of devices and identify their main parts through interactive games.'**
  String get learnDevicesDescription;

  /// Level 1 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will identify different types of devices and understand their main parts.'**
  String get deviceLearningObjective;

  /// Device level tip 1
  ///
  /// In en, this message translates to:
  /// **'Look for common device parts like screen, keyboard, and mouse'**
  String get deviceTip1;

  /// Device level tip 2
  ///
  /// In en, this message translates to:
  /// **'Different devices have different purposes'**
  String get deviceTip2;

  /// Device level tip 3
  ///
  /// In en, this message translates to:
  /// **'Practice turning devices on and off safely'**
  String get deviceTip3;

  /// Device level tip 4
  ///
  /// In en, this message translates to:
  /// **'Ask for help when handling new devices'**
  String get deviceTip4;

  /// Device builder challenge question
  ///
  /// In en, this message translates to:
  /// **'Device Builder: Drag and drop the labels onto the correct parts of this computer!'**
  String get deviceBuilderQuestion;

  /// Computer monitor label
  ///
  /// In en, this message translates to:
  /// **'Monitor'**
  String get monitor;

  /// Computer CPU label
  ///
  /// In en, this message translates to:
  /// **'CPU'**
  String get cpu;

  /// Computer keyboard label
  ///
  /// In en, this message translates to:
  /// **'Keyboard'**
  String get keyboard;

  /// Computer mouse label
  ///
  /// In en, this message translates to:
  /// **'Mouse'**
  String get mouse;

  /// Device builder challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Great job! You correctly identified the main parts of a computer: Monitor (screen), CPU (main unit), Keyboard (for typing), and Mouse (for pointing).'**
  String get deviceBuilderExplanation;

  /// Power up sequence challenge question
  ///
  /// In en, this message translates to:
  /// **'Power Up! Put these steps in the correct order to turn on a computer safely:'**
  String get powerUpQuestion;

  /// Power up step 1
  ///
  /// In en, this message translates to:
  /// **'Plug in power cable'**
  String get plugPowerCable;

  /// Power up step 2
  ///
  /// In en, this message translates to:
  /// **'Press CPU power button'**
  String get pressCpuButton;

  /// Power up step 3
  ///
  /// In en, this message translates to:
  /// **'Press monitor power button'**
  String get pressMonitorButton;

  /// Power up step 4
  ///
  /// In en, this message translates to:
  /// **'Wait for startup'**
  String get waitForStartup;

  /// Power up sequence explanation
  ///
  /// In en, this message translates to:
  /// **'Perfect! The correct order is: 1. Plug in power, 2. Press CPU power button, 3. Press monitor power button, 4. Wait for startup.'**
  String get powerUpExplanation;

  /// Device types challenge question
  ///
  /// In en, this message translates to:
  /// **'Which device is best for making phone calls while traveling?'**
  String get deviceTypesQuestion;

  /// Desktop computer option
  ///
  /// In en, this message translates to:
  /// **'Desktop Computer'**
  String get desktopComputer;

  /// Smartphone option
  ///
  /// In en, this message translates to:
  /// **'Smartphone'**
  String get smartphone;

  /// Television option
  ///
  /// In en, this message translates to:
  /// **'Television'**
  String get television;

  /// Printer option
  ///
  /// In en, this message translates to:
  /// **'Printer'**
  String get printer;

  /// Smartphone explanation
  ///
  /// In en, this message translates to:
  /// **'Smartphones are portable and designed for communication, making them perfect for calls while traveling.'**
  String get smartphoneExplanation;

  /// Device shutdown challenge question
  ///
  /// In en, this message translates to:
  /// **'You finished your work on a tablet. What is the safest way to turn it off?'**
  String get deviceShutdownQuestion;

  /// Shutdown option 1
  ///
  /// In en, this message translates to:
  /// **'Just close the cover'**
  String get justCloseCover;

  /// Shutdown option 2
  ///
  /// In en, this message translates to:
  /// **'Use the power button to shut down properly'**
  String get usePowerButton;

  /// Shutdown option 3
  ///
  /// In en, this message translates to:
  /// **'Remove the battery'**
  String get removeBattery;

  /// Shutdown option 4
  ///
  /// In en, this message translates to:
  /// **'Wait for it to turn off automatically'**
  String get waitAutoShutdown;

  /// Shutdown explanation
  ///
  /// In en, this message translates to:
  /// **'Always use the proper shutdown process to save your work and protect the device.'**
  String get shutdownExplanation;

  /// Level 2 title
  ///
  /// In en, this message translates to:
  /// **'Screen Navigator'**
  String get screenNavigator;

  /// Level 2 theme
  ///
  /// In en, this message translates to:
  /// **'Understanding Your Screen'**
  String get understandingYourScreen;

  /// Level 2 description
  ///
  /// In en, this message translates to:
  /// **'Master desktop navigation through Icon Hunt and Cursor Maestro mini-games!'**
  String get masterDesktopNavigation;

  /// Level 2 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will identify common desktop icons and master basic mouse/touch navigation.'**
  String get screenLearningObjective;

  /// Screen level tip 1
  ///
  /// In en, this message translates to:
  /// **'Icons are small pictures that represent apps or files'**
  String get screenTip1;

  /// Screen level tip 2
  ///
  /// In en, this message translates to:
  /// **'Look carefully - each icon has a unique shape and meaning'**
  String get screenTip2;

  /// Screen level tip 3
  ///
  /// In en, this message translates to:
  /// **'Practice different mouse actions: click, double-click, drag'**
  String get screenTip3;

  /// Screen level tip 4
  ///
  /// In en, this message translates to:
  /// **'On touch screens, tap and swipe with confidence'**
  String get screenTip4;

  /// Icon hunt challenge 1 question
  ///
  /// In en, this message translates to:
  /// **'Icon Hunt: Find and tap the Folder icon on this desktop!'**
  String get iconHuntQuestion1;

  /// Folder found message
  ///
  /// In en, this message translates to:
  /// **'Folder found!'**
  String get folderFound;

  /// Need hint option
  ///
  /// In en, this message translates to:
  /// **'Need a hint?'**
  String get needHint;

  /// Time up message
  ///
  /// In en, this message translates to:
  /// **'Time up!'**
  String get timeUp;

  /// Folder icon explanation
  ///
  /// In en, this message translates to:
  /// **'Perfect! Folder icons usually look like manila file folders and help organize your files.'**
  String get folderExplanation;

  /// Icon hunt challenge 2 question
  ///
  /// In en, this message translates to:
  /// **'Icon Hunt: Quick! Tap the Recycle Bin before time runs out!'**
  String get iconHuntQuestion2;

  /// Recycle bin found message
  ///
  /// In en, this message translates to:
  /// **'Recycle Bin found!'**
  String get recycleBinFound;

  /// Recycle bin explanation
  ///
  /// In en, this message translates to:
  /// **'Excellent! The Recycle Bin holds deleted files and usually looks like a trash can.'**
  String get recycleBinExplanation;

  /// Level 3 theme
  ///
  /// In en, this message translates to:
  /// **'Working with Apps'**
  String get workingWithApps;

  /// Level 4 theme
  ///
  /// In en, this message translates to:
  /// **'Why Digital Skills Matter'**
  String get whyDigitalSkillsMatter;

  /// Level 5 theme
  ///
  /// In en, this message translates to:
  /// **'Mastering Our Learning App'**
  String get masteringOurLearningApp;

  /// Level 6 theme
  ///
  /// In en, this message translates to:
  /// **'Writing and Typing'**
  String get writingAndTyping;

  /// Level 7 theme
  ///
  /// In en, this message translates to:
  /// **'Creating Presentations'**
  String get creatingPresentations;

  /// Level 8 theme
  ///
  /// In en, this message translates to:
  /// **'Organizing Digital Work'**
  String get organizingDigitalWork;

  /// Level 9 theme
  ///
  /// In en, this message translates to:
  /// **'What is the Internet'**
  String get whatIsTheInternet;

  /// Level 10 theme
  ///
  /// In en, this message translates to:
  /// **'Searching for Information'**
  String get searchingForInformation;

  /// Level 11 theme
  ///
  /// In en, this message translates to:
  /// **'Staying Safe Online'**
  String get stayingSafeOnline;

  /// Level 12 theme
  ///
  /// In en, this message translates to:
  /// **'Being a Good Digital Citizen'**
  String get beingAGoodDigitalCitizen;

  /// Level 13 theme
  ///
  /// In en, this message translates to:
  /// **'Introduction to Email'**
  String get introductionToEmail;

  /// Level 14 theme
  ///
  /// In en, this message translates to:
  /// **'Messaging Apps Safety'**
  String get messagingAppsSafety;

  /// Level 15 theme
  ///
  /// In en, this message translates to:
  /// **'Understanding Progress'**
  String get understandingProgress;

  /// Level 16 theme
  ///
  /// In en, this message translates to:
  /// **'Working Together Online'**
  String get workingTogetherOnline;

  /// Level 17 theme
  ///
  /// In en, this message translates to:
  /// **'Exploring Hobbies Online'**
  String get exploringHobbiesOnline;

  /// Level 18 theme
  ///
  /// In en, this message translates to:
  /// **'Digital Payments Safety'**
  String get digitalPaymentsSafety;

  /// Level 19 theme
  ///
  /// In en, this message translates to:
  /// **'Career Opportunities'**
  String get careerOpportunities;

  /// Level 20 theme
  ///
  /// In en, this message translates to:
  /// **'Digital Portfolio Project'**
  String get digitalPortfolioProject;

  /// Level 1 title
  ///
  /// In en, this message translates to:
  /// **'Device Explorer'**
  String get levelTitle1;

  /// Level 2 title
  ///
  /// In en, this message translates to:
  /// **'Screen Navigator'**
  String get levelTitle2;

  /// Level 3 title
  ///
  /// In en, this message translates to:
  /// **'App Master'**
  String get levelTitle3;

  /// Level 4 title
  ///
  /// In en, this message translates to:
  /// **'Future Hero'**
  String get levelTitle4;

  /// Level 5 title
  ///
  /// In en, this message translates to:
  /// **'Learning App Expert'**
  String get levelTitle5;

  /// Level 6 title
  ///
  /// In en, this message translates to:
  /// **'Typing Champion'**
  String get levelTitle6;

  /// Level 7 title
  ///
  /// In en, this message translates to:
  /// **'Presentation Pro'**
  String get levelTitle7;

  /// Level 8 title
  ///
  /// In en, this message translates to:
  /// **'File Organizer'**
  String get levelTitle8;

  /// Level 9 title
  ///
  /// In en, this message translates to:
  /// **'Internet Explorer'**
  String get levelTitle9;

  /// Level 10 title
  ///
  /// In en, this message translates to:
  /// **'Search Master'**
  String get levelTitle10;

  /// Level 11 title
  ///
  /// In en, this message translates to:
  /// **'Safety Guardian'**
  String get levelTitle11;

  /// Level 12 title
  ///
  /// In en, this message translates to:
  /// **'Digital Citizen'**
  String get levelTitle12;

  /// Level 13 title
  ///
  /// In en, this message translates to:
  /// **'Email Expert'**
  String get levelTitle13;

  /// Level 14 title
  ///
  /// In en, this message translates to:
  /// **'Message Master'**
  String get levelTitle14;

  /// Level 15 title
  ///
  /// In en, this message translates to:
  /// **'Progress Tracker'**
  String get levelTitle15;

  /// Level 16 title
  ///
  /// In en, this message translates to:
  /// **'Team Player'**
  String get levelTitle16;

  /// Level 17 title
  ///
  /// In en, this message translates to:
  /// **'Hobby Hunter'**
  String get levelTitle17;

  /// Level 18 title
  ///
  /// In en, this message translates to:
  /// **'Money Guardian'**
  String get levelTitle18;

  /// Level 19 title
  ///
  /// In en, this message translates to:
  /// **'Career Explorer'**
  String get levelTitle19;

  /// Level 20 title
  ///
  /// In en, this message translates to:
  /// **'Portfolio Creator'**
  String get levelTitle20;

  /// Level 1 description
  ///
  /// In en, this message translates to:
  /// **'Learn about different types of devices and identify their main parts through interactive games.'**
  String get levelDescription1;

  /// Level 2 description
  ///
  /// In en, this message translates to:
  /// **'Master desktop navigation through Icon Hunt and Cursor Maestro mini-games!'**
  String get levelDescription2;

  /// Level 3 description
  ///
  /// In en, this message translates to:
  /// **'Explore app categories and learn smart organization through the App Sorter challenge!'**
  String get levelDescription3;

  /// Level 4 description
  ///
  /// In en, this message translates to:
  /// **'Discover the importance of digital skills through engaging challenges and real-world scenarios.'**
  String get levelDescription4;

  /// Level 5 description
  ///
  /// In en, this message translates to:
  /// **'Master our learning platform and become confident using educational apps.'**
  String get levelDescription5;

  /// Level 6 description
  ///
  /// In en, this message translates to:
  /// **'Develop typing skills and learn proper keyboard techniques through fun games.'**
  String get levelDescription6;

  /// Level 7 description
  ///
  /// In en, this message translates to:
  /// **'Create engaging presentations using digital tools and design principles.'**
  String get levelDescription7;

  /// Level 8 description
  ///
  /// In en, this message translates to:
  /// **'Learn to organize files, folders, and digital documents efficiently.'**
  String get levelDescription8;

  /// Level 9 description
  ///
  /// In en, this message translates to:
  /// **'Understand how the internet works and explore safe browsing practices.'**
  String get levelDescription9;

  /// Level 10 description
  ///
  /// In en, this message translates to:
  /// **'Master search techniques and learn to find reliable information online.'**
  String get levelDescription10;

  /// Level 11 description
  ///
  /// In en, this message translates to:
  /// **'Learn essential online safety practices and how to protect yourself.'**
  String get levelDescription11;

  /// Level 12 description
  ///
  /// In en, this message translates to:
  /// **'Understand digital citizenship and responsible online behavior.'**
  String get levelDescription12;

  /// Level 13 description
  ///
  /// In en, this message translates to:
  /// **'Learn email basics, etiquette, and communication skills.'**
  String get levelDescription13;

  /// Level 14 description
  ///
  /// In en, this message translates to:
  /// **'Understand messaging app safety and proper communication practices.'**
  String get levelDescription14;

  /// Level 15 description
  ///
  /// In en, this message translates to:
  /// **'Learn to track your learning progress and set digital goals.'**
  String get levelDescription15;

  /// Level 16 description
  ///
  /// In en, this message translates to:
  /// **'Discover online collaboration tools and teamwork skills.'**
  String get levelDescription16;

  /// Level 17 description
  ///
  /// In en, this message translates to:
  /// **'Explore hobbies and interests safely in the digital world.'**
  String get levelDescription17;

  /// Level 18 description
  ///
  /// In en, this message translates to:
  /// **'Learn about digital payments, online shopping safety, and financial literacy.'**
  String get levelDescription18;

  /// Level 19 description
  ///
  /// In en, this message translates to:
  /// **'Explore digital career opportunities and future skills.'**
  String get levelDescription19;

  /// Level 20 description
  ///
  /// In en, this message translates to:
  /// **'Create your own digital portfolio showcasing your skills and achievements.'**
  String get levelDescription20;

  /// Level 1 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will identify different types of devices and understand their main parts.'**
  String get levelObjective1;

  /// Level 2 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will identify common desktop icons and master basic mouse/touch navigation.'**
  String get levelObjective2;

  /// Level 3 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will categorize apps by purpose and understand app organization principles.'**
  String get levelObjective3;

  /// Level 4 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will understand the importance of digital skills in modern life and future careers.'**
  String get levelObjective4;

  /// Level 5 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will confidently navigate educational apps and utilize learning features.'**
  String get levelObjective5;

  /// Level 6 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will develop proper typing technique and improve keyboarding speed.'**
  String get levelObjective6;

  /// Level 7 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will create effective presentations using digital design principles.'**
  String get levelObjective7;

  /// Level 8 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will organize digital files systematically and understand folder structures.'**
  String get levelObjective8;

  /// Level 9 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will understand internet fundamentals and practice safe browsing.'**
  String get levelObjective9;

  /// Level 10 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will master search strategies and evaluate information credibility.'**
  String get levelObjective10;

  /// Level 11 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will implement online safety practices and recognize digital threats.'**
  String get levelObjective11;

  /// Level 12 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will demonstrate responsible digital citizenship and ethical online behavior.'**
  String get levelObjective12;

  /// Level 13 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will compose professional emails and understand communication etiquette.'**
  String get levelObjective13;

  /// Level 14 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will use messaging apps safely and communicate appropriately.'**
  String get levelObjective14;

  /// Level 15 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will track learning progress and set achievable digital goals.'**
  String get levelObjective15;

  /// Level 16 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will collaborate effectively using digital tools and platforms.'**
  String get levelObjective16;

  /// Level 17 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will explore interests safely and discover positive online communities.'**
  String get levelObjective17;

  /// Level 18 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will understand digital payments and practice safe online financial transactions.'**
  String get levelObjective18;

  /// Level 19 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will explore digital career paths and understand future skill requirements.'**
  String get levelObjective19;

  /// Level 20 learning objective
  ///
  /// In en, this message translates to:
  /// **'Students will create a comprehensive digital portfolio showcasing their skills.'**
  String get levelObjective20;

  /// Level 1 tip 1
  ///
  /// In en, this message translates to:
  /// **'Look for common device parts like screen, keyboard, and mouse'**
  String get levelTip1_1;

  /// Level 1 tip 2
  ///
  /// In en, this message translates to:
  /// **'Different devices have different purposes'**
  String get levelTip1_2;

  /// Level 1 tip 3
  ///
  /// In en, this message translates to:
  /// **'Practice turning devices on and off safely'**
  String get levelTip1_3;

  /// Level 1 tip 4
  ///
  /// In en, this message translates to:
  /// **'Ask for help when handling new devices'**
  String get levelTip1_4;

  /// Level 2 tip 1
  ///
  /// In en, this message translates to:
  /// **'Icons are small pictures that represent apps or files'**
  String get levelTip2_1;

  /// Level 2 tip 2
  ///
  /// In en, this message translates to:
  /// **'Look carefully - each icon has a unique shape and meaning'**
  String get levelTip2_2;

  /// Level 2 tip 3
  ///
  /// In en, this message translates to:
  /// **'Practice different mouse actions: click, double-click, drag'**
  String get levelTip2_3;

  /// Level 2 tip 4
  ///
  /// In en, this message translates to:
  /// **'On touch screens, tap and swipe with confidence'**
  String get levelTip2_4;

  /// Level 3 tip 1
  ///
  /// In en, this message translates to:
  /// **'Group similar apps together for easy access'**
  String get levelTip3_1;

  /// Level 3 tip 2
  ///
  /// In en, this message translates to:
  /// **'Learn what each app category is used for'**
  String get levelTip3_2;

  /// Level 3 tip 3
  ///
  /// In en, this message translates to:
  /// **'Check app reviews before downloading new ones'**
  String get levelTip3_3;

  /// Level 3 tip 4
  ///
  /// In en, this message translates to:
  /// **'Close apps when you\'re done to save battery'**
  String get levelTip3_4;

  /// Level 4 tip 1
  ///
  /// In en, this message translates to:
  /// **'Digital skills open doors to new opportunities'**
  String get levelTip4_1;

  /// Level 4 tip 2
  ///
  /// In en, this message translates to:
  /// **'Technology changes how we work, learn, and connect'**
  String get levelTip4_2;

  /// Level 4 tip 3
  ///
  /// In en, this message translates to:
  /// **'Start learning digital skills early for future success'**
  String get levelTip4_3;

  /// Level 4 tip 4
  ///
  /// In en, this message translates to:
  /// **'Practice regularly to build confidence with technology'**
  String get levelTip4_4;

  /// Level 5 tip 1
  ///
  /// In en, this message translates to:
  /// **'Explore all features of educational apps to maximize learning'**
  String get levelTip5_1;

  /// Level 5 tip 2
  ///
  /// In en, this message translates to:
  /// **'Use help sections when you\'re stuck'**
  String get levelTip5_2;

  /// Level 5 tip 3
  ///
  /// In en, this message translates to:
  /// **'Track your progress to stay motivated'**
  String get levelTip5_3;

  /// Level 5 tip 4
  ///
  /// In en, this message translates to:
  /// **'Take breaks during long learning sessions'**
  String get levelTip5_4;

  /// Level 6 tip 1
  ///
  /// In en, this message translates to:
  /// **'Keep your fingers curved and relaxed while typing'**
  String get levelTip6_1;

  /// Level 6 tip 2
  ///
  /// In en, this message translates to:
  /// **'Use the correct finger for each key'**
  String get levelTip6_2;

  /// Level 6 tip 3
  ///
  /// In en, this message translates to:
  /// **'Start slowly and focus on accuracy over speed'**
  String get levelTip6_3;

  /// Level 6 tip 4
  ///
  /// In en, this message translates to:
  /// **'Practice typing for short periods daily'**
  String get levelTip6_4;

  /// Level 7 tip 1
  ///
  /// In en, this message translates to:
  /// **'Keep slides simple with clear, readable text'**
  String get levelTip7_1;

  /// Level 7 tip 2
  ///
  /// In en, this message translates to:
  /// **'Use images and graphics to support your message'**
  String get levelTip7_2;

  /// Level 7 tip 3
  ///
  /// In en, this message translates to:
  /// **'Practice your presentation before presenting'**
  String get levelTip7_3;

  /// Level 7 tip 4
  ///
  /// In en, this message translates to:
  /// **'Make eye contact with your audience'**
  String get levelTip7_4;

  /// Level 8 tip 1
  ///
  /// In en, this message translates to:
  /// **'Create folders with descriptive names'**
  String get levelTip8_1;

  /// Level 8 tip 2
  ///
  /// In en, this message translates to:
  /// **'Sort files by date, name, or type'**
  String get levelTip8_2;

  /// Level 8 tip 3
  ///
  /// In en, this message translates to:
  /// **'Regularly delete files you no longer need'**
  String get levelTip8_3;

  /// Level 8 tip 4
  ///
  /// In en, this message translates to:
  /// **'Back up important files in multiple locations'**
  String get levelTip8_4;

  /// Level 9 tip 1
  ///
  /// In en, this message translates to:
  /// **'The internet connects computers worldwide'**
  String get levelTip9_1;

  /// Level 9 tip 2
  ///
  /// In en, this message translates to:
  /// **'Websites have addresses called URLs'**
  String get levelTip9_2;

  /// Level 9 tip 3
  ///
  /// In en, this message translates to:
  /// **'Look for https:// for secure connections'**
  String get levelTip9_3;

  /// Level 9 tip 4
  ///
  /// In en, this message translates to:
  /// **'Use reliable browsers with updated security'**
  String get levelTip9_4;

  /// Level 10 tip 1
  ///
  /// In en, this message translates to:
  /// **'Use specific keywords for better search results'**
  String get levelTip10_1;

  /// Level 10 tip 2
  ///
  /// In en, this message translates to:
  /// **'Check multiple sources to verify information'**
  String get levelTip10_2;

  /// Level 10 tip 3
  ///
  /// In en, this message translates to:
  /// **'Look for recent dates and credible authors'**
  String get levelTip10_3;

  /// Level 10 tip 4
  ///
  /// In en, this message translates to:
  /// **'Use quotation marks for exact phrases'**
  String get levelTip10_4;

  /// Level 11 tip 1
  ///
  /// In en, this message translates to:
  /// **'Never share personal information with strangers online'**
  String get levelTip11_1;

  /// Level 11 tip 2
  ///
  /// In en, this message translates to:
  /// **'Use strong, unique passwords for each account'**
  String get levelTip11_2;

  /// Level 11 tip 3
  ///
  /// In en, this message translates to:
  /// **'Be careful what you post publicly'**
  String get levelTip11_3;

  /// Level 11 tip 4
  ///
  /// In en, this message translates to:
  /// **'Tell a trusted adult about suspicious online activity'**
  String get levelTip11_4;

  /// Level 12 tip 1
  ///
  /// In en, this message translates to:
  /// **'Treat others online with respect and kindness'**
  String get levelTip12_1;

  /// Level 12 tip 2
  ///
  /// In en, this message translates to:
  /// **'Think before you post - words can hurt'**
  String get levelTip12_2;

  /// Level 12 tip 3
  ///
  /// In en, this message translates to:
  /// **'Don\'t participate in cyberbullying'**
  String get levelTip12_3;

  /// Level 12 tip 4
  ///
  /// In en, this message translates to:
  /// **'Report inappropriate behavior to authorities'**
  String get levelTip12_4;

  /// Level 13 tip 1
  ///
  /// In en, this message translates to:
  /// **'Write clear, polite subject lines'**
  String get levelTip13_1;

  /// Level 13 tip 2
  ///
  /// In en, this message translates to:
  /// **'Use proper greeting and closing'**
  String get levelTip13_2;

  /// Level 13 tip 3
  ///
  /// In en, this message translates to:
  /// **'Check for spelling and grammar before sending'**
  String get levelTip13_3;

  /// Level 13 tip 4
  ///
  /// In en, this message translates to:
  /// **'Keep emails concise and to the point'**
  String get levelTip13_4;

  /// Level 14 tip 1
  ///
  /// In en, this message translates to:
  /// **'Only message people you know in real life'**
  String get levelTip14_1;

  /// Level 14 tip 2
  ///
  /// In en, this message translates to:
  /// **'Don\'t share photos or personal details'**
  String get levelTip14_2;

  /// Level 14 tip 3
  ///
  /// In en, this message translates to:
  /// **'Use privacy settings to control who can contact you'**
  String get levelTip14_3;

  /// Level 14 tip 4
  ///
  /// In en, this message translates to:
  /// **'Report and block inappropriate contacts'**
  String get levelTip14_4;

  /// Level 15 tip 1
  ///
  /// In en, this message translates to:
  /// **'Set realistic, achievable goals'**
  String get levelTip15_1;

  /// Level 15 tip 2
  ///
  /// In en, this message translates to:
  /// **'Celebrate small wins along the way'**
  String get levelTip15_2;

  /// Level 15 tip 3
  ///
  /// In en, this message translates to:
  /// **'Track your progress regularly'**
  String get levelTip15_3;

  /// Level 15 tip 4
  ///
  /// In en, this message translates to:
  /// **'Adjust goals as you learn and grow'**
  String get levelTip15_4;

  /// Level 16 tip 1
  ///
  /// In en, this message translates to:
  /// **'Listen to team members\' ideas respectfully'**
  String get levelTip16_1;

  /// Level 16 tip 2
  ///
  /// In en, this message translates to:
  /// **'Share tasks fairly among team members'**
  String get levelTip16_2;

  /// Level 16 tip 3
  ///
  /// In en, this message translates to:
  /// **'Communicate clearly about deadlines and expectations'**
  String get levelTip16_3;

  /// Level 16 tip 4
  ///
  /// In en, this message translates to:
  /// **'Use collaboration tools to stay organized'**
  String get levelTip16_4;

  /// Level 17 tip 1
  ///
  /// In en, this message translates to:
  /// **'Research hobbies from reliable sources'**
  String get levelTip17_1;

  /// Level 17 tip 2
  ///
  /// In en, this message translates to:
  /// **'Join moderated communities for safe interaction'**
  String get levelTip17_2;

  /// Level 17 tip 3
  ///
  /// In en, this message translates to:
  /// **'Be cautious about meeting online friends in person'**
  String get levelTip17_3;

  /// Level 17 tip 4
  ///
  /// In en, this message translates to:
  /// **'Keep personal information private'**
  String get levelTip17_4;

  /// Level 18 tip 1
  ///
  /// In en, this message translates to:
  /// **'Only shop on secure, reputable websites'**
  String get levelTip18_1;

  /// Level 18 tip 2
  ///
  /// In en, this message translates to:
  /// **'Check your account statements regularly'**
  String get levelTip18_2;

  /// Level 18 tip 3
  ///
  /// In en, this message translates to:
  /// **'Never share your passwords or PINs'**
  String get levelTip18_3;

  /// Level 18 tip 4
  ///
  /// In en, this message translates to:
  /// **'Be aware of online scams and fraud'**
  String get levelTip18_4;

  /// Level 19 tip 1
  ///
  /// In en, this message translates to:
  /// **'Explore different tech career paths'**
  String get levelTip19_1;

  /// Level 19 tip 2
  ///
  /// In en, this message translates to:
  /// **'Build a portfolio of your digital projects'**
  String get levelTip19_2;

  /// Level 19 tip 3
  ///
  /// In en, this message translates to:
  /// **'Network with professionals in fields of interest'**
  String get levelTip19_3;

  /// Level 19 tip 4
  ///
  /// In en, this message translates to:
  /// **'Keep learning new technologies and skills'**
  String get levelTip19_4;

  /// Level 20 tip 1
  ///
  /// In en, this message translates to:
  /// **'Showcase your best work and achievements'**
  String get levelTip20_1;

  /// Level 20 tip 2
  ///
  /// In en, this message translates to:
  /// **'Include projects from different subject areas'**
  String get levelTip20_2;

  /// Level 20 tip 3
  ///
  /// In en, this message translates to:
  /// **'Write clear descriptions of your learning process'**
  String get levelTip20_3;

  /// Level 20 tip 4
  ///
  /// In en, this message translates to:
  /// **'Update your portfolio regularly with new work'**
  String get levelTip20_4;

  /// App sorter challenge question
  ///
  /// In en, this message translates to:
  /// **'App Sorter: Drag these apps into the correct boxes - System Software or Application Software!'**
  String get challengeAppSorterQuestion;

  /// App sorter challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Perfect sorting! System Software (Android, Windows, iOS) runs the device. Application Software (Calculator, Paint, Notes) does specific tasks.'**
  String get challengeAppSorterExplanation;

  /// App management challenge question
  ///
  /// In en, this message translates to:
  /// **'You opened a drawing app and finished your artwork. What should you do next?'**
  String get challengeAppManagementQuestion;

  /// App management challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Always save your work first, then close apps properly to keep your device running smoothly.'**
  String get challengeAppManagementExplanation;

  /// App safety challenge question
  ///
  /// In en, this message translates to:
  /// **'Which of these is the safest way to get new apps for your device?'**
  String get challengeAppSafetyQuestion;

  /// App safety challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Official app stores check apps for safety before making them available to download.'**
  String get challengeAppSafetyExplanation;

  /// App types challenge question
  ///
  /// In en, this message translates to:
  /// **'Match each app type with its purpose:'**
  String get challengeAppTypesQuestion;

  /// App types challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Great job! Each app is designed for a specific purpose to help you with different tasks.'**
  String get challengeAppTypesExplanation;

  /// Digital heroes challenge question
  ///
  /// In en, this message translates to:
  /// **'Digital Heroes Match-Up: Connect each person with how digital skills help them!'**
  String get challengeDigitalHeroesQuestion;

  /// Digital heroes challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Amazing! You connected each digital hero with their tools: Farmers check weather, shopkeepers accept digital payments, students learn online, and doctors keep digital records.'**
  String get challengeDigitalHeroesExplanation;

  /// Career benefits challenge question
  ///
  /// In en, this message translates to:
  /// **'How do digital skills help a rural teacher improve their teaching?'**
  String get challengeCareerBenefitsQuestion;

  /// Career benefits challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Digital skills help teachers find better educational resources, create engaging lessons, and even teach students remotely when needed.'**
  String get challengeCareerBenefitsExplanation;

  /// Community impact challenge question
  ///
  /// In en, this message translates to:
  /// **'A village needs to apply for a government program online. Who can help using digital skills?'**
  String get challengeCommunityImpactQuestion;

  /// Community impact challenge explanation
  ///
  /// In en, this message translates to:
  /// **'With basic digital skills, anyone can help their community access government services, apply for programs, and connect with resources online.'**
  String get challengeCommunityImpactExplanation;

  /// Future opportunities challenge question
  ///
  /// In en, this message translates to:
  /// **'Drag these digital skills to match the opportunities they create:'**
  String get challengeFutureOpportunitiesQuestion;

  /// Cursor maestro challenge 1 question
  ///
  /// In en, this message translates to:
  /// **'Cursor Maestro: Drag the file into the folder!'**
  String get challengeCursorMaestroQuestion1;

  /// Cursor maestro challenge 1 explanation
  ///
  /// In en, this message translates to:
  /// **'Great dragging technique! Click and hold, then move the mouse to drag files into folders.'**
  String get challengeCursorMaestroExplanation1;

  /// Cursor maestro challenge 2 question
  ///
  /// In en, this message translates to:
  /// **'Cursor Maestro: Double-click to open the picture!'**
  String get challengeCursorMaestroQuestion2;

  /// Cursor maestro challenge 2 explanation
  ///
  /// In en, this message translates to:
  /// **'Perfect double-click! Two quick clicks in the same spot opens files and programs.'**
  String get challengeCursorMaestroExplanation2;

  /// Slide designer challenge 1 question
  ///
  /// In en, this message translates to:
  /// **'Slide Designer: Task 1 - Create a title slide for \"My Village\"'**
  String get challengeSlideDesignerQuestion1;

  /// Slide designer challenge 1 explanation
  ///
  /// In en, this message translates to:
  /// **'Excellent! You created a beautiful title slide. A good title slide introduces your presentation topic clearly.'**
  String get challengeSlideDesignerExplanation1;

  /// Slide designer challenge 2 question
  ///
  /// In en, this message translates to:
  /// **'Slide Designer: Task 2 - Add a picture of a flower to your slide'**
  String get challengeSlideDesignerQuestion2;

  /// Slide designer challenge 2 explanation
  ///
  /// In en, this message translates to:
  /// **'Wonderful! Pictures make presentations more interesting and help explain your ideas better.'**
  String get challengeSlideDesignerExplanation2;

  /// Slide designer challenge 3 question
  ///
  /// In en, this message translates to:
  /// **'Slide Designer: Task 3 - Choose a nice background color for your presentation'**
  String get challengeSlideDesignerQuestion3;

  /// Slide designer challenge 3 explanation
  ///
  /// In en, this message translates to:
  /// **'Great color choice! The right background makes your text easy to read and your presentation look professional.'**
  String get challengeSlideDesignerExplanation3;

  /// Presentation tips challenge question
  ///
  /// In en, this message translates to:
  /// **'What makes a good presentation slide?'**
  String get challengePresentationTipsQuestion;

  /// Presentation tips challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Perfect! Good slides have clear titles, simple text that is easy to read, and pictures that support your message.'**
  String get challengePresentationTipsExplanation;

  /// File organizer challenge question
  ///
  /// In en, this message translates to:
  /// **'File Organizer: This desktop is messy! Create folders for \"Schoolwork\" and \"Personal\" then organize these files.'**
  String get challengeFileOrganizerQuestion;

  /// File organizer challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Excellent organization! You created proper folders and sorted all files correctly. Now you can find your work easily!'**
  String get challengeFileOrganizerExplanation;

  /// File naming challenge question
  ///
  /// In en, this message translates to:
  /// **'Which is the best name for a file containing your math homework from Monday?'**
  String get challengeFileNamingQuestion;

  /// File naming challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Perfect! \"Math_Homework_Monday.txt\" tells you exactly what the file contains and when it was from.'**
  String get challengeFileNamingExplanation;

  /// Folder structure challenge question
  ///
  /// In en, this message translates to:
  /// **'You have many school subjects. How should you organize your schoolwork folder?'**
  String get challengeFolderStructureQuestion;

  /// Folder structure challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Excellent choice! Separate folders for each subject make it easy to find specific homework or notes quickly.'**
  String get challengeFolderStructureExplanation;

  /// Backup importance challenge question
  ///
  /// In en, this message translates to:
  /// **'It is important to back up your important school files to prevent losing them.'**
  String get challengeBackupImportanceQuestion;

  /// Backup importance challenge explanation
  ///
  /// In en, this message translates to:
  /// **'True! Backing up files protects your hard work. Save important files in multiple places or cloud storage.'**
  String get challengeBackupImportanceExplanation;

  /// Password safety challenge question
  ///
  /// In en, this message translates to:
  /// **'Which is the strongest password?'**
  String get challengePasswordSafetyQuestion;

  /// Password safety challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Excellent! \"MyVillage2024!\" is strong because it combines letters, numbers, and symbols. It is also something you can remember.'**
  String get challengePasswordSafetyExplanation;

  /// Positive communication challenge question
  ///
  /// In en, this message translates to:
  /// **'What is the best way to disagree with someone online?'**
  String get challengePositiveCommunicationQuestion;

  /// Positive communication challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Perfect! Respectful disagreement shows maturity and helps create positive online discussions where everyone can learn.'**
  String get challengePositiveCommunicationExplanation;

  /// Appropriate language challenge question
  ///
  /// In en, this message translates to:
  /// **'Which message is most appropriate for a school group chat?'**
  String get challengeAppropriateLanguageQuestion;

  /// Appropriate language challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Perfect! Asking for help politely keeps the conversation positive and focused on learning.'**
  String get challengeAppropriateLanguageExplanation;

  /// Payment safety challenge question
  ///
  /// In en, this message translates to:
  /// **'Your friend asks for your UPI PIN to help transfer money. What should you do?'**
  String get challengePaymentSafetyQuestion;

  /// Payment safety challenge explanation
  ///
  /// In en, this message translates to:
  /// **'Perfect! PINs are like the keys to your money - never share them with anyone, not even close friends or family.'**
  String get challengePaymentSafetyExplanation;

  /// Option: Leave it running in the background
  ///
  /// In en, this message translates to:
  /// **'Leave it running in the background'**
  String get optionLeaveRunning;

  /// Option: Save your work and close the app properly
  ///
  /// In en, this message translates to:
  /// **'Save your work and close the app properly'**
  String get optionSaveAndClose;

  /// Option: Turn off the device immediately
  ///
  /// In en, this message translates to:
  /// **'Turn off the device immediately'**
  String get optionTurnOffImmediately;

  /// Option: Open more apps
  ///
  /// In en, this message translates to:
  /// **'Open more apps'**
  String get optionOpenMoreApps;

  /// Option: Download from unknown websites
  ///
  /// In en, this message translates to:
  /// **'Download from unknown websites'**
  String get optionDownloadUnknown;

  /// Option: Use official app stores like Google Play or App Store
  ///
  /// In en, this message translates to:
  /// **'Use official app stores like Google Play or App Store'**
  String get optionUseOfficialStores;

  /// Option: Get apps from friends via email
  ///
  /// In en, this message translates to:
  /// **'Get apps from friends via email'**
  String get optionGetFromFriends;

  /// Option: Download from any website
  ///
  /// In en, this message translates to:
  /// **'Download from any website'**
  String get optionDownloadAnyWebsite;

  /// Option: Calculator - Math tasks
  ///
  /// In en, this message translates to:
  /// **'Calculator - Math tasks'**
  String get optionCalculatorMath;

  /// Option: Music Player - Playing songs
  ///
  /// In en, this message translates to:
  /// **'Music Player - Playing songs'**
  String get optionMusicPlayerSongs;

  /// Option: Notes - Writing reminders
  ///
  /// In en, this message translates to:
  /// **'Notes - Writing reminders'**
  String get optionNotesReminders;

  /// Option: Camera - Taking photos
  ///
  /// In en, this message translates to:
  /// **'Camera - Taking photos'**
  String get optionCameraPhotos;

  /// Option: Farmer using weather app
  ///
  /// In en, this message translates to:
  /// **'Farmer using weather app'**
  String get optionFarmerWeather;

  /// Option: Shopkeeper with payment QR code
  ///
  /// In en, this message translates to:
  /// **'Shopkeeper with payment QR code'**
  String get optionShopkeeperQR;

  /// Option: Student learning online
  ///
  /// In en, this message translates to:
  /// **'Student learning online'**
  String get optionStudentOnline;

  /// Option: Doctor using digital records
  ///
  /// In en, this message translates to:
  /// **'Doctor using digital records'**
  String get optionDoctorRecords;

  /// Option: They make teaching harder
  ///
  /// In en, this message translates to:
  /// **'They make teaching harder'**
  String get optionMakeTeachingHarder;

  /// Option: They allow access to online resources, educational videos, and virtual classrooms
  ///
  /// In en, this message translates to:
  /// **'They allow access to online resources, educational videos, and virtual classrooms'**
  String get optionAllowAccessResources;

  /// Option: They are only useful for entertainment
  ///
  /// In en, this message translates to:
  /// **'They are only useful for entertainment'**
  String get optionOnlyEntertainment;

  /// Option: They replace the need for students
  ///
  /// In en, this message translates to:
  /// **'They replace the need for students'**
  String get optionReplaceStudents;

  /// Option: No one - rural people cannot use technology
  ///
  /// In en, this message translates to:
  /// **'No one - rural people cannot use technology'**
  String get optionNoOneRural;

  /// Option: Anyone who has learned basic computer and internet skills
  ///
  /// In en, this message translates to:
  /// **'Anyone who has learned basic computer and internet skills'**
  String get optionAnyoneBasicSkills;

  /// Option: Only city people can do this
  ///
  /// In en, this message translates to:
  /// **'Only city people can do this'**
  String get optionOnlyCityPeople;

  /// Option: It is impossible to do from a village
  ///
  /// In en, this message translates to:
  /// **'It is impossible to do from a village'**
  String get optionImpossibleVillage;

  /// Option: Online selling - Start your own business
  ///
  /// In en, this message translates to:
  /// **'Online selling - Start your own business'**
  String get optionOnlineSellingBusiness;

  /// Option: Video calling - Connect with family far away
  ///
  /// In en, this message translates to:
  /// **'Video calling - Connect with family far away'**
  String get optionVideoCallingFamily;

  /// Option: Digital banking - Save money safely
  ///
  /// In en, this message translates to:
  /// **'Digital banking - Save money safely'**
  String get optionDigitalBankingSafe;

  /// Option: Online learning - Access any course worldwide
  ///
  /// In en, this message translates to:
  /// **'Online learning - Access any course worldwide'**
  String get optionOnlineLearningCourse;

  /// Option: Lots of text and many colors
  ///
  /// In en, this message translates to:
  /// **'Lots of text and many colors'**
  String get optionLotsTextColors;

  /// Option: Clear title, simple text, and relevant pictures
  ///
  /// In en, this message translates to:
  /// **'Clear title, simple text, and relevant pictures'**
  String get optionClearTitleSimple;

  /// Option: Fancy animations and loud colors
  ///
  /// In en, this message translates to:
  /// **'Fancy animations and loud colors'**
  String get optionFancyAnimations;

  /// Option: Only pictures with no text
  ///
  /// In en, this message translates to:
  /// **'Only pictures with no text'**
  String get optionOnlyPictures;

  /// Option: file1.txt
  ///
  /// In en, this message translates to:
  /// **'file1.txt'**
  String get optionFile1Txt;

  /// Option: Math_Homework_Monday.txt
  ///
  /// In en, this message translates to:
  /// **'Math_Homework_Monday.txt'**
  String get optionMathHomeworkMonday;

  /// Option: homework.txt
  ///
  /// In en, this message translates to:
  /// **'homework.txt'**
  String get optionHomeworkTxt;

  /// Option: untitled.txt
  ///
  /// In en, this message translates to:
  /// **'untitled.txt'**
  String get optionUntitledTxt;

  /// Option: Put everything in one big folder
  ///
  /// In en, this message translates to:
  /// **'Put everything in one big folder'**
  String get optionOneBigFolder;

  /// Option: Create separate folders for each subject (Math, English, Science, etc.)
  ///
  /// In en, this message translates to:
  /// **'Create separate folders for each subject (Math, English, Science, etc.)'**
  String get optionSeparateSubjectFolders;

  /// Option: Create folders by date only
  ///
  /// In en, this message translates to:
  /// **'Create folders by date only'**
  String get optionFoldersByDate;

  /// Option: Do not use folders at all
  ///
  /// In en, this message translates to:
  /// **'Do not use folders at all'**
  String get optionNoFolders;

  /// Option: 123456
  ///
  /// In en, this message translates to:
  /// **'123456'**
  String get optionPassword123456;

  /// Option: password
  ///
  /// In en, this message translates to:
  /// **'password'**
  String get optionPasswordPassword;

  /// Option: MyVillage2024!
  ///
  /// In en, this message translates to:
  /// **'MyVillage2024!'**
  String get optionPasswordMyVillage;

  /// Option: abcdef
  ///
  /// In en, this message translates to:
  /// **'abcdef'**
  String get optionPasswordAbcdef;

  /// Option: Use all capital letters to show you are serious
  ///
  /// In en, this message translates to:
  /// **'Use all capital letters to show you are serious'**
  String get optionUseCapitalLetters;

  /// Option: Explain your different opinion politely and respectfully
  ///
  /// In en, this message translates to:
  /// **'Explain your different opinion politely and respectfully'**
  String get optionExplainPolitely;

  /// Option: Post mean comments about the person
  ///
  /// In en, this message translates to:
  /// **'Post mean comments about the person'**
  String get optionPostMeanComments;

  /// Option: Get all your friends to argue with them
  ///
  /// In en, this message translates to:
  /// **'Get all your friends to argue with them'**
  String get optionGetFriendsArgue;

  /// Option: OMG this homework is sooooo boring 😴
  ///
  /// In en, this message translates to:
  /// **'OMG this homework is sooooo boring 😴'**
  String get optionHomeworkBoring;

  /// Option: Can someone help me understand question 3?
  ///
  /// In en, this message translates to:
  /// **'Can someone help me understand question 3?'**
  String get optionHelpQuestion3;

  /// Option: I hate this class!!!
  ///
  /// In en, this message translates to:
  /// **'I hate this class!!!'**
  String get optionHateClass;

  /// Option: The teacher is so annoying
  ///
  /// In en, this message translates to:
  /// **'The teacher is so annoying'**
  String get optionTeacherAnnoying;

  /// Option: Give them the PIN since they are your friend
  ///
  /// In en, this message translates to:
  /// **'Give them the PIN since they are your friend'**
  String get optionGivePinFriend;

  /// Option: Never share your PIN with anyone, even friends
  ///
  /// In en, this message translates to:
  /// **'Never share your PIN with anyone, even friends'**
  String get optionNeverSharePin;

  /// Option: Share it only this once
  ///
  /// In en, this message translates to:
  /// **'Share it only this once'**
  String get optionShareOnlyOnce;

  /// Option: Write it down for them
  ///
  /// In en, this message translates to:
  /// **'Write it down for them'**
  String get optionWriteDownPin;

  /// Game action: Title slide created!
  ///
  /// In en, this message translates to:
  /// **'Title slide created!'**
  String get gameActionTitleSlideCreated;

  /// Game action: Let me try again
  ///
  /// In en, this message translates to:
  /// **'Let me try again'**
  String get gameActionLetMeTryAgain;

  /// Game action: Show me how
  ///
  /// In en, this message translates to:
  /// **'Show me how'**
  String get gameActionShowMeHow;

  /// Game action: Perfect design!
  ///
  /// In en, this message translates to:
  /// **'Perfect design!'**
  String get gameActionPerfectDesign;

  /// Game action: Picture added!
  ///
  /// In en, this message translates to:
  /// **'Picture added!'**
  String get gameActionPictureAdded;

  /// Game action: Help me position it
  ///
  /// In en, this message translates to:
  /// **'Help me position it'**
  String get gameActionHelpPosition;

  /// Game action: Choose different picture
  ///
  /// In en, this message translates to:
  /// **'Choose different picture'**
  String get gameActionChooseDifferentPicture;

  /// Game action: Looks great!
  ///
  /// In en, this message translates to:
  /// **'Looks great!'**
  String get gameActionLooksGreat;

  /// Game action: Background chosen!
  ///
  /// In en, this message translates to:
  /// **'Background chosen!'**
  String get gameActionBackgroundChosen;

  /// Game action: Try different color
  ///
  /// In en, this message translates to:
  /// **'Try different color'**
  String get gameActionTryDifferentColor;

  /// Game action: Looks beautiful!
  ///
  /// In en, this message translates to:
  /// **'Looks beautiful!'**
  String get gameActionLooksBeautiful;

  /// Game action: Perfect choice!
  ///
  /// In en, this message translates to:
  /// **'Perfect choice!'**
  String get gameActionPerfectChoice;

  /// Game action: All files organized!
  ///
  /// In en, this message translates to:
  /// **'All files organized!'**
  String get gameActionAllFilesOrganized;

  /// Game action: Help me sort
  ///
  /// In en, this message translates to:
  /// **'Help me sort'**
  String get gameActionHelpMeSort;

  /// Game action: Perfect organization!
  ///
  /// In en, this message translates to:
  /// **'Perfect organization!'**
  String get gameActionPerfectOrganization;

  /// Game action: Successfully moved!
  ///
  /// In en, this message translates to:
  /// **'Successfully moved!'**
  String get gameActionSuccessfullyMoved;

  /// Game action: Try again
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get gameActionTryAgain;

  /// Game action: Almost there!
  ///
  /// In en, this message translates to:
  /// **'Almost there!'**
  String get gameActionAlmostThere;

  /// Game action: Perfect technique!
  ///
  /// In en, this message translates to:
  /// **'Perfect technique!'**
  String get gameActionPerfectTechnique;

  /// Game action: Picture opened!
  ///
  /// In en, this message translates to:
  /// **'Picture opened!'**
  String get gameActionPictureOpened;

  /// Game action: Single click detected
  ///
  /// In en, this message translates to:
  /// **'Single click detected'**
  String get gameActionSingleClickDetected;

  /// Game action: Perfect timing!
  ///
  /// In en, this message translates to:
  /// **'Perfect timing!'**
  String get gameActionPerfectTiming;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'hi', 'pa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
    case 'pa': return AppLocalizationsPa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
