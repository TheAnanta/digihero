import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class ThemeLocalizer {
  static String getLocalizedTheme(BuildContext context, String englishTheme) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return englishTheme;

    switch (englishTheme) {
      case 'Meet Your Digital Device':
        return localizations.meetYourDigitalDevice;
      case 'Understanding Your Screen':
        return localizations.understandingYourScreen;
      case 'Working with Apps':
        return localizations.workingWithApps;
      case 'Why Digital Skills Matter':
        return localizations.whyDigitalSkillsMatter;
      case 'Mastering Our Learning App':
        return localizations.masteringOurLearningApp;
      case 'Writing and Typing':
        return localizations.writingAndTyping;
      case 'Creating Presentations':
        return localizations.creatingPresentations;
      case 'Organizing Digital Work':
        return localizations.organizingDigitalWork;
      case 'What is the Internet':
        return localizations.whatIsTheInternet;
      case 'Searching for Information':
        return localizations.searchingForInformation;
      case 'Staying Safe Online':
        return localizations.stayingSafeOnline;
      case 'Being a Good Digital Citizen':
        return localizations.beingAGoodDigitalCitizen;
      case 'Introduction to Email':
        return localizations.introductionToEmail;
      case 'Messaging Apps Safety':
        return localizations.messagingAppsSafety;
      case 'Understanding Progress':
        return localizations.understandingProgress;
      case 'Working Together Online':
        return localizations.workingTogetherOnline;
      case 'Exploring Hobbies Online':
        return localizations.exploringHobbiesOnline;
      case 'Digital Payments Safety':
        return localizations.digitalPaymentsSafety;
      case 'Career Opportunities':
        return localizations.careerOpportunities;
      case 'Digital Portfolio Project':
        return localizations.digitalPortfolioProject;
      default:
        return englishTheme; // Fallback to English if not found
    }
  }
}
