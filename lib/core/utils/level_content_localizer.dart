import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class LevelContentLocalizer {
  static String getLocalizedTitle(BuildContext context, String englishTitle) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return englishTitle;

    switch (englishTitle) {
      case 'Device Explorer':
        return localizations.levelTitle1;
      case 'Screen Navigator':
        return localizations.levelTitle2;
      case 'App Master':
        return localizations.levelTitle3;
      case 'Future Hero':
        return localizations.levelTitle4;
      case 'Learning App Expert':
        return localizations.levelTitle5;
      case 'Typing Champion':
        return localizations.levelTitle6;
      case 'Presentation Pro':
        return localizations.levelTitle7;
      case 'File Organizer':
        return localizations.levelTitle8;
      case 'Internet Explorer':
        return localizations.levelTitle9;
      case 'Search Master':
        return localizations.levelTitle10;
      case 'Safety Guardian':
        return localizations.levelTitle11;
      case 'Digital Citizen':
        return localizations.levelTitle12;
      case 'Email Expert':
        return localizations.levelTitle13;
      case 'Message Master':
        return localizations.levelTitle14;
      case 'Progress Tracker':
        return localizations.levelTitle15;
      case 'Team Player':
        return localizations.levelTitle16;
      case 'Hobby Hunter':
        return localizations.levelTitle17;
      case 'Money Guardian':
        return localizations.levelTitle18;
      case 'Career Explorer':
        return localizations.levelTitle19;
      case 'Portfolio Creator':
        return localizations.levelTitle20;
      default:
        return englishTitle;
    }
  }

  static String getLocalizedDescription(BuildContext context, int levelNumber) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return '';

    switch (levelNumber) {
      case 1:
        return localizations.levelDescription1;
      case 2:
        return localizations.levelDescription2;
      case 3:
        return localizations.levelDescription3;
      case 4:
        return localizations.levelDescription4;
      case 5:
        return localizations.levelDescription5;
      case 6:
        return localizations.levelDescription6;
      case 7:
        return localizations.levelDescription7;
      case 8:
        return localizations.levelDescription8;
      case 9:
        return localizations.levelDescription9;
      case 10:
        return localizations.levelDescription10;
      case 11:
        return localizations.levelDescription11;
      case 12:
        return localizations.levelDescription12;
      case 13:
        return localizations.levelDescription13;
      case 14:
        return localizations.levelDescription14;
      case 15:
        return localizations.levelDescription15;
      case 16:
        return localizations.levelDescription16;
      case 17:
        return localizations.levelDescription17;
      case 18:
        return localizations.levelDescription18;
      case 19:
        return localizations.levelDescription19;
      case 20:
        return localizations.levelDescription20;
      default:
        return '';
    }
  }

  static String getLocalizedLearningObjective(
      BuildContext context, int levelNumber) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return '';

    switch (levelNumber) {
      case 1:
        return localizations.levelObjective1;
      case 2:
        return localizations.levelObjective2;
      case 3:
        return localizations.levelObjective3;
      case 4:
        return localizations.levelObjective4;
      case 5:
        return localizations.levelObjective5;
      case 6:
        return localizations.levelObjective6;
      case 7:
        return localizations.levelObjective7;
      case 8:
        return localizations.levelObjective8;
      case 9:
        return localizations.levelObjective9;
      case 10:
        return localizations.levelObjective10;
      case 11:
        return localizations.levelObjective11;
      case 12:
        return localizations.levelObjective12;
      case 13:
        return localizations.levelObjective13;
      case 14:
        return localizations.levelObjective14;
      case 15:
        return localizations.levelObjective15;
      case 16:
        return localizations.levelObjective16;
      case 17:
        return localizations.levelObjective17;
      case 18:
        return localizations.levelObjective18;
      case 19:
        return localizations.levelObjective19;
      case 20:
        return localizations.levelObjective20;
      default:
        return '';
    }
  }

  static List<String> getLocalizedTips(BuildContext context, int levelNumber) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return [];

    switch (levelNumber) {
      case 1:
        return [
          localizations.levelTip1_1,
          localizations.levelTip1_2,
          localizations.levelTip1_3,
          localizations.levelTip1_4,
        ];
      case 2:
        return [
          localizations.levelTip2_1,
          localizations.levelTip2_2,
          localizations.levelTip2_3,
          localizations.levelTip2_4,
        ];
      case 3:
        return [
          localizations.levelTip3_1,
          localizations.levelTip3_2,
          localizations.levelTip3_3,
          localizations.levelTip3_4,
        ];
      case 4:
        return [
          localizations.levelTip4_1,
          localizations.levelTip4_2,
          localizations.levelTip4_3,
          localizations.levelTip4_4,
        ];
      case 5:
        return [
          localizations.levelTip5_1,
          localizations.levelTip5_2,
          localizations.levelTip5_3,
          localizations.levelTip5_4,
        ];
      case 6:
        return [
          localizations.levelTip6_1,
          localizations.levelTip6_2,
          localizations.levelTip6_3,
          localizations.levelTip6_4,
        ];
      case 7:
        return [
          localizations.levelTip7_1,
          localizations.levelTip7_2,
          localizations.levelTip7_3,
          localizations.levelTip7_4,
        ];
      case 8:
        return [
          localizations.levelTip8_1,
          localizations.levelTip8_2,
          localizations.levelTip8_3,
          localizations.levelTip8_4,
        ];
      case 9:
        return [
          localizations.levelTip9_1,
          localizations.levelTip9_2,
          localizations.levelTip9_3,
          localizations.levelTip9_4,
        ];
      case 10:
        return [
          localizations.levelTip10_1,
          localizations.levelTip10_2,
          localizations.levelTip10_3,
          localizations.levelTip10_4,
        ];
      case 11:
        return [
          localizations.levelTip11_1,
          localizations.levelTip11_2,
          localizations.levelTip11_3,
          localizations.levelTip11_4,
        ];
      case 12:
        return [
          localizations.levelTip12_1,
          localizations.levelTip12_2,
          localizations.levelTip12_3,
          localizations.levelTip12_4,
        ];
      case 13:
        return [
          localizations.levelTip13_1,
          localizations.levelTip13_2,
          localizations.levelTip13_3,
          localizations.levelTip13_4,
        ];
      case 14:
        return [
          localizations.levelTip14_1,
          localizations.levelTip14_2,
          localizations.levelTip14_3,
          localizations.levelTip14_4,
        ];
      case 15:
        return [
          localizations.levelTip15_1,
          localizations.levelTip15_2,
          localizations.levelTip15_3,
          localizations.levelTip15_4,
        ];
      case 16:
        return [
          localizations.levelTip16_1,
          localizations.levelTip16_2,
          localizations.levelTip16_3,
          localizations.levelTip16_4,
        ];
      case 17:
        return [
          localizations.levelTip17_1,
          localizations.levelTip17_2,
          localizations.levelTip17_3,
          localizations.levelTip17_4,
        ];
      case 18:
        return [
          localizations.levelTip18_1,
          localizations.levelTip18_2,
          localizations.levelTip18_3,
          localizations.levelTip18_4,
        ];
      case 19:
        return [
          localizations.levelTip19_1,
          localizations.levelTip19_2,
          localizations.levelTip19_3,
          localizations.levelTip19_4,
        ];
      case 20:
        return [
          localizations.levelTip20_1,
          localizations.levelTip20_2,
          localizations.levelTip20_3,
          localizations.levelTip20_4,
        ];
      default:
        return [];
    }
  }

  static String getLocalizedChallengeQuestion(
      BuildContext context, String challengeId) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return '';

    switch (challengeId) {
      case 'app_sorter_1':
        return localizations.challengeAppSorterQuestion;
      case 'app_management_1':
        return localizations.challengeAppManagementQuestion;
      case 'app_safety_1':
        return localizations.challengeAppSafetyQuestion;
      case 'app_types_1':
        return localizations.challengeAppTypesQuestion;
      case 'digital_heroes_1':
        return localizations.challengeDigitalHeroesQuestion;
      case 'career_benefits_1':
        return localizations.challengeCareerBenefitsQuestion;
      case 'community_impact_1':
        return localizations.challengeCommunityImpactQuestion;
      case 'future_opportunities_1':
        return localizations.challengeFutureOpportunitiesQuestion;
      case 'cursor_maestro_1':
        return localizations.challengeCursorMaestroQuestion1;
      case 'cursor_maestro_2':
        return localizations.challengeCursorMaestroQuestion2;
      case 'slide_designer_1':
        return localizations.challengeSlideDesignerQuestion1;
      case 'slide_designer_2':
        return localizations.challengeSlideDesignerQuestion2;
      case 'slide_designer_3':
        return localizations.challengeSlideDesignerQuestion3;
      case 'presentation_tips_1':
        return localizations.challengePresentationTipsQuestion;
      case 'file_organizer_1':
        return localizations.challengeFileOrganizerQuestion;
      case 'file_naming_1':
        return localizations.challengeFileNamingQuestion;
      case 'folder_structure_1':
        return localizations.challengeFolderStructureQuestion;
      case 'backup_importance_1':
        return localizations.challengeBackupImportanceQuestion;
      case 'password_safety_1':
        return localizations.challengePasswordSafetyQuestion;
      case 'positive_communication_1':
        return localizations.challengePositiveCommunicationQuestion;
      case 'appropriate_language_1':
        return localizations.challengeAppropriateLanguageQuestion;
      case 'payment_safety_1':
        return localizations.challengePaymentSafetyQuestion;
      default:
        return '';
    }
  }

  static String getLocalizedChallengeExplanation(
      BuildContext context, String challengeId) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return '';

    switch (challengeId) {
      case 'app_sorter_1':
        return localizations.challengeAppSorterExplanation;
      case 'app_management_1':
        return localizations.challengeAppManagementExplanation;
      case 'app_safety_1':
        return localizations.challengeAppSafetyExplanation;
      case 'app_types_1':
        return localizations.challengeAppTypesExplanation;
      case 'digital_heroes_1':
        return localizations.challengeDigitalHeroesExplanation;
      case 'career_benefits_1':
        return localizations.challengeCareerBenefitsExplanation;
      case 'community_impact_1':
        return localizations.challengeCommunityImpactExplanation;
      case 'cursor_maestro_1':
        return localizations.challengeCursorMaestroExplanation1;
      case 'cursor_maestro_2':
        return localizations.challengeCursorMaestroExplanation2;
      case 'slide_designer_1':
        return localizations.challengeSlideDesignerExplanation1;
      case 'slide_designer_2':
        return localizations.challengeSlideDesignerExplanation2;
      case 'slide_designer_3':
        return localizations.challengeSlideDesignerExplanation3;
      case 'presentation_tips_1':
        return localizations.challengePresentationTipsExplanation;
      case 'file_organizer_1':
        return localizations.challengeFileOrganizerExplanation;
      case 'file_naming_1':
        return localizations.challengeFileNamingExplanation;
      case 'folder_structure_1':
        return localizations.challengeFolderStructureExplanation;
      case 'backup_importance_1':
        return localizations.challengeBackupImportanceExplanation;
      case 'password_safety_1':
        return localizations.challengePasswordSafetyExplanation;
      case 'positive_communication_1':
        return localizations.challengePositiveCommunicationExplanation;
      case 'appropriate_language_1':
        return localizations.challengeAppropriateLanguageExplanation;
      case 'payment_safety_1':
        return localizations.challengePaymentSafetyExplanation;
      default:
        return '';
    }
  }

  static List<String> getLocalizedChallengeOptions(
      BuildContext context, String challengeId) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return [];

    switch (challengeId) {
      case 'app_management_1':
        return [
          localizations.optionLeaveRunning,
          localizations.optionSaveAndClose,
          localizations.optionTurnOffImmediately,
          localizations.optionOpenMoreApps,
        ];
      case 'app_safety_1':
        return [
          localizations.optionDownloadUnknown,
          localizations.optionUseOfficialStores,
          localizations.optionGetFromFriends,
          localizations.optionDownloadAnyWebsite,
        ];
      case 'app_types_1':
        return [
          localizations.optionCalculatorMath,
          localizations.optionMusicPlayerSongs,
          localizations.optionNotesReminders,
          localizations.optionCameraPhotos,
        ];
      case 'digital_heroes_1':
        return [
          localizations.optionFarmerWeather,
          localizations.optionShopkeeperQR,
          localizations.optionStudentOnline,
          localizations.optionDoctorRecords,
        ];
      case 'career_benefits_1':
        return [
          localizations.optionMakeTeachingHarder,
          localizations.optionAllowAccessResources,
          localizations.optionOnlyEntertainment,
          localizations.optionReplaceStudents,
        ];
      case 'community_impact_1':
        return [
          localizations.optionNoOneRural,
          localizations.optionAnyoneBasicSkills,
          localizations.optionOnlyCityPeople,
          localizations.optionImpossibleVillage,
        ];
      case 'future_opportunities_1':
        return [
          localizations.optionOnlineSellingBusiness,
          localizations.optionVideoCallingFamily,
          localizations.optionDigitalBankingSafe,
          localizations.optionOnlineLearningCourse,
        ];
      case 'presentation_tips_1':
        return [
          localizations.optionLotsTextColors,
          localizations.optionClearTitleSimple,
          localizations.optionFancyAnimations,
          localizations.optionOnlyPictures,
        ];
      case 'file_naming_1':
        return [
          localizations.optionFile1Txt,
          localizations.optionMathHomeworkMonday,
          localizations.optionHomeworkTxt,
          localizations.optionUntitledTxt,
        ];
      case 'folder_structure_1':
        return [
          localizations.optionOneBigFolder,
          localizations.optionSeparateSubjectFolders,
          localizations.optionFoldersByDate,
          localizations.optionNoFolders,
        ];
      case 'password_safety_1':
        return [
          localizations.optionPassword123456,
          localizations.optionPasswordPassword,
          localizations.optionPasswordMyVillage,
          localizations.optionPasswordAbcdef,
        ];
      case 'positive_communication_1':
        return [
          localizations.optionUseCapitalLetters,
          localizations.optionExplainPolitely,
          localizations.optionPostMeanComments,
          localizations.optionGetFriendsArgue,
        ];
      case 'appropriate_language_1':
        return [
          localizations.optionHomeworkBoring,
          localizations.optionHelpQuestion3,
          localizations.optionHateClass,
          localizations.optionTeacherAnnoying,
        ];
      case 'payment_safety_1':
        return [
          localizations.optionGivePinFriend,
          localizations.optionNeverSharePin,
          localizations.optionShareOnlyOnce,
          localizations.optionWriteDownPin,
        ];
      case 'slide_designer_1':
        return [
          localizations.gameActionTitleSlideCreated,
          localizations.gameActionLetMeTryAgain,
          localizations.gameActionShowMeHow,
          localizations.gameActionPerfectDesign,
        ];
      case 'slide_designer_2':
        return [
          localizations.gameActionPictureAdded,
          localizations.gameActionHelpPosition,
          localizations.gameActionChooseDifferentPicture,
          localizations.gameActionLooksGreat,
        ];
      case 'slide_designer_3':
        return [
          localizations.gameActionBackgroundChosen,
          localizations.gameActionTryDifferentColor,
          localizations.gameActionLooksBeautiful,
          localizations.gameActionPerfectChoice,
        ];
      case 'file_organizer_1':
        return [
          localizations.gameActionAllFilesOrganized,
          localizations.gameActionLetMeTryAgain,
          localizations.gameActionHelpMeSort,
          localizations.gameActionPerfectOrganization,
        ];
      case 'cursor_maestro_1':
        return [
          localizations.gameActionSuccessfullyMoved,
          localizations.gameActionTryAgain,
          localizations.gameActionAlmostThere,
          localizations.gameActionPerfectTechnique,
        ];
      case 'cursor_maestro_2':
        return [
          localizations.gameActionPictureOpened,
          localizations.gameActionTryAgain,
          localizations.gameActionSingleClickDetected,
          localizations.gameActionPerfectTiming,
        ];
      default:
        return [];
    }
  }

  static String getLocalizedGameAction(BuildContext context, String actionKey) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return actionKey;

    switch (actionKey) {
      case 'Title slide created!':
        return localizations.gameActionTitleSlideCreated;
      case 'Let me try again':
        return localizations.gameActionLetMeTryAgain;
      case 'Show me how':
        return localizations.gameActionShowMeHow;
      case 'Perfect design!':
        return localizations.gameActionPerfectDesign;
      case 'Picture added!':
        return localizations.gameActionPictureAdded;
      case 'Help me position it':
        return localizations.gameActionHelpPosition;
      case 'Choose different picture':
        return localizations.gameActionChooseDifferentPicture;
      case 'Looks great!':
        return localizations.gameActionLooksGreat;
      case 'Background chosen!':
        return localizations.gameActionBackgroundChosen;
      case 'Try different color':
        return localizations.gameActionTryDifferentColor;
      case 'Looks beautiful!':
        return localizations.gameActionLooksBeautiful;
      case 'Perfect choice!':
        return localizations.gameActionPerfectChoice;
      case 'All files organized!':
        return localizations.gameActionAllFilesOrganized;
      case 'Help me sort':
        return localizations.gameActionHelpMeSort;
      case 'Perfect organization!':
        return localizations.gameActionPerfectOrganization;
      case 'Successfully moved!':
        return localizations.gameActionSuccessfullyMoved;
      case 'Try again':
        return localizations.gameActionTryAgain;
      case 'Almost there!':
        return localizations.gameActionAlmostThere;
      case 'Perfect technique!':
        return localizations.gameActionPerfectTechnique;
      case 'Picture opened!':
        return localizations.gameActionPictureOpened;
      case 'Single click detected':
        return localizations.gameActionSingleClickDetected;
      case 'Perfect timing!':
        return localizations.gameActionPerfectTiming;
      default:
        return actionKey;
    }
  }

  static String getLocalizedInstruction(
      BuildContext context, String englishInstruction) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return englishInstruction;

    // For now, use a simple approach that works with the current localization system
    // This can be expanded once the ARB files are properly regenerated

    // Map of English instructions to Hindi and Punjabi translations
    final instructionTranslations = {
      'Drag each label to the matching part of the device': {
        'hi': 'प्रत्येक लेबल को डिवाइस के मैचिंग भाग पर खींचें',
        'pa': 'ਹਰ ਲੇਬਲ ਨੂੰ ਡਿਵਾਈਸ ਦੇ ਮੇਲ ਖਾਂਦੇ ਹਿੱਸੇ ਤੱਕ ਖਿੱਚੋ',
      },
      'Arrange the steps in the right order': {
        'hi': 'चरणों को सही क्रम में व्यवस्थित करें',
        'pa': 'ਕਦਮਾਂ ਨੂੰ ਸਹੀ ਕ੍ਰਮ ਵਿੱਚ ਵਿਵਸਥਿਤ ਕਰੋ',
      },
      'Tap the folder icon as quickly as you can!': {
        'hi': 'फ़ोल्डर आइकन पर जल्दी से टैप करें!',
        'pa': 'ਫੋਲਡਰ ਆਈਕਨ \'ਤੇ ਜਲਦੀ ਟੈਪ ਕਰੋ!',
      },
      'Find the Recycle Bin icon!': {
        'hi': 'रीसाइकल बिन आइकन खोजें!',
        'pa': 'ਰੀਸਾਈਕਲ ਬਿਨ ਆਈਕਨ ਲੱਭੋ!',
      },
      'Click and drag the document into the folder': {
        'hi': 'दस्तावेज़ को क्लिक करके फ़ोल्डर में खींचें',
        'pa': 'ਦਸਤਾਵੇਜ਼ ਨੂੰ ਕਲਿੱਕ ਕਰੋ ਅਤੇ ਫੋਲਡਰ ਵਿੱਚ ਖਿੱਚੋ',
      },
      'Double-click the picture to open it': {
        'hi': 'तस्वीर को खोलने के लिए डबल-क्लिक करें',
        'pa': 'ਤਸਵੀਰ ਨੂੰ ਖੋਲ੍ਹਣ ਲਈ ਡਬਲ-ਕਲਿੱਕ ਕਰੋ',
      },
      'Drag each app icon to the correct category box': {
        'hi': 'प्रत्येक ऐप आइकन को सही श्रेणी बॉक्स में खींचें',
        'pa': 'ਹਰ ਐਪ ਆਈਕਨ ਨੂੰ ਸਹੀ ਸ਼ਰੇਣੀ ਬਾਕਸ ਵਿੱਚ ਖਿੱਚੋ',
      },
      'Use the toolbox to design your slide!': {
        'hi': 'अपनी स्लाइड डिज़ाइन करने के लिए टूलबॉक्स का उपयोग करें!',
        'pa': 'ਆਪਣੀ ਸਲਾਈਡ ਡਿਜ਼ਾਈਨ ਕਰਨ ਲਈ ਟੂਲਬਾਕਸ ਦੀ ਵਰਤੋਂ ਕਰੋ!',
      },
      'Use the text tool to add your title and subtitle': {
        'hi': 'अपना शीर्षक और उपशीर्षक जोड़ने के लिए टेक्स्ट टूल का उपयोग करें',
        'pa': 'ਆਪਣਾ ਸਿਰਲੇਖ ਅਤੇ ਉਪ-ਸਿਰਲੇਖ ਜੋੜਨ ਲਈ ਟੈਕਸਟ ਟੂਲ ਦੀ ਵਰਤੋਂ ਕਰੋ',
      },
      'Select a flower image and place it on your slide': {
        'hi': 'एक फूल की छवि चुनें और इसे अपनी स्लाइड पर रखें',
        'pa': 'ਇੱਕ ਫੁੱਲ ਦੀ ਤਸਵੀਰ ਚੁਣੋ ਅਤੇ ਇਸਨੂੰ ਆਪਣੀ ਸਲਾਈਡ \'ਤੇ ਰੱਖੋ',
      },
      'Choose a beautiful background for your slide': {
        'hi': 'अपनी स्लाइड के लिए एक सुंदर पृष्ठभूमि चुनें',
        'pa': 'ਆਪਣੀ ਸਲਾਈਡ ਲਈ ਇੱਕ ਸੁੰਦਰ ਪਿਛੋਕੜ ਚੁਣੋ',
      },
      'Create folders for "Schoolwork" and "Personal" then organize these files':
          {
        'hi':
            '"स्कूलवर्क" और "व्यक्तिगत" के लिए फ़ोल्डर बनाएं और फिर इन फाइलों को व्यवस्थित करें',
        'pa':
            '"ਸਕੂਲਵਰਕ" ਅਤੇ "ਨਿੱਜੀ" ਲਈ ਫੋਲਡਰ ਬਣਾਓ ਫਿਰ ਇਨ੍ਹਾਂ ਫਾਈਲਾਂ ਨੂੰ ਵਿਵਸਥਿਤ ਕਰੋ',
      },
      'Search for the answer and choose the most reliable source!': {
        'hi': 'उत्तर खोजें और सबसे विश्वसनीय स्रोत चुनें!',
        'pa': 'ਜਵਾਬ ਲਈ ਖੋਜ ਕਰੋ ਅਤੇ ਸਭ ਤੋਂ ਭਰੋਸੇਮੰਦ ਸਰੋਤ ਚੁਣੋ!',
      },
      'Tap a person, then tap their matching description to connect them!': {
        'hi':
            'एक व्यक्ति पर टैप करें, फिर उनके मैचिंग विवरण पर टैप करके उन्हें जोड़ें!',
        'pa':
            'ਇੱਕ ਵਿਅਕਤੀ \'ਤੇ ਟੈਪ ਕਰੋ, ਫਿਰ ਉਨ੍ਹਾਂ ਦੇ ਮੇਲ ਖਾਂਦੇ ਵੇਰਵੇ \'ਤੇ ਟੈਪ ਕਰਕੇ ਉਨ੍ਹਾਂ ਨੂੰ ਜੋੜੋ!',
      },
    };

    // Get current locale
    final locale = localizations.localeName;

    // Return translated instruction if available
    if (instructionTranslations.containsKey(englishInstruction)) {
      final translations = instructionTranslations[englishInstruction]!;
      return translations[locale] ?? englishInstruction;
    }

    // Return original instruction if no translation found
    return englishInstruction;
  }
}
