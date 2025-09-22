import '../../../core/models/game_models.dart';
import '../../../core/constants/app_constants.dart';

class LevelData {
  static GameLevel getLevelData(int levelNumber) {
    switch (levelNumber) {
      case 1:
        return _createSmartPasswordsLevel();
      case 2:
        return _createPhishingAwarenessLevel();
      case 3:
        return _createPrivacySettingsLevel();
      case 4:
        return _createCyberbullyingLevel();
      case 5:
        return _createSafeDownloadsLevel();
      case 6:
        return _createSocialMediaSafetyLevel();
      case 7:
        return _createDigitalFootprintLevel();
      case 8:
        return _createSecureNetworksLevel();
      case 9:
        return _createInformationLiteracyLevel();
      case 10:
        return _createDigitalCitizenshipLevel();
      default:
        return _createSmartPasswordsLevel();
    }
  }

  static GameLevel _createSmartPasswordsLevel() {
    return GameLevel(
      levelNumber: 1,
      title: 'Password Power',
      theme: 'Smart Passwords',
      description: 'Learn to create strong, secure passwords that protect your digital life.',
      backgroundImagePath: 'assets/images/backgrounds/password_bg.png',
      characterImagePath: 'assets/images/characters/password_hero.png',
      targetScore: 300,
      timeLimit: 120,
      learningObjective: 'Students will understand the importance of strong passwords and learn how to create them.',
      tips: [
        'Use a mix of letters, numbers, and symbols',
        'Make passwords at least 12 characters long',
        'Avoid using personal information',
        'Use different passwords for different accounts'
      ],
      challenges: [
        GameChallenge(
          id: 'password_1',
          type: ChallengeType.multipleChoice,
          question: 'Which password is the strongest?',
          options: [
            'password123',
            'MyP@ssw0rd2024!',
            'john1990',
            '12345678'
          ],
          correctAnswerIndex: 1,
          explanation: 'Strong passwords use a mix of uppercase, lowercase, numbers, and special characters.',
          points: 50,
        ),
        GameChallenge(
          id: 'password_2',
          type: ChallengeType.trueFalse,
          question: 'It\'s safe to use the same password for all your accounts.',
          options: ['True', 'False'],
          correctAnswerIndex: 1,
          explanation: 'Using the same password everywhere means if one account is hacked, all accounts are at risk.',
          points: 50,
        ),
        GameChallenge(
          id: 'password_3',
          type: ChallengeType.dragAndDrop,
          question: 'Arrange these password elements from weakest to strongest:',
          options: ['123456', 'MyName', 'M@4$Tr0ng!P@ss', 'password'],
          correctAnswerIndex: 0, // Not used for drag and drop
          explanation: 'Longer passwords with mixed characters are stronger.',
          points: 75,
        ),
        GameChallenge(
          id: 'password_4',
          type: ChallengeType.scenario,
          question: 'Your friend asks for your social media password to help you with something. What should you do?',
          options: [
            'Give them the password since they\'re your friend',
            'Tell them no and do it yourself instead',
            'Give them a fake password',
            'Ask your parents first'
          ],
          correctAnswerIndex: 1,
          explanation: 'Never share passwords, even with friends. Keep your accounts secure by doing things yourself.',
          points: 75,
        ),
        GameChallenge(
          id: 'password_5',
          type: ChallengeType.interactive,
          question: 'Create a strong password using the password generator!',
          options: ['Completed'],
          correctAnswerIndex: 0,
          explanation: 'Password generators help create random, strong passwords.',
          points: 50,
        ),
      ],
    );
  }

  static GameLevel _createPhishingAwarenessLevel() {
    return GameLevel(
      levelNumber: 2,
      title: 'Phishing Detective',
      theme: 'Phishing Awareness',
      description: 'Become a detective and learn to spot fake emails, messages, and websites.',
      backgroundImagePath: 'assets/images/backgrounds/detective_bg.png',
      characterImagePath: 'assets/images/characters/detective_hero.png',
      targetScore: 350,
      timeLimit: 150,
      learningObjective: 'Students will identify phishing attempts and learn how to respond safely.',
      tips: [
        'Check sender email addresses carefully',
        'Look for spelling and grammar mistakes',
        'Don\'t click suspicious links',
        'Verify requests through official channels'
      ],
      challenges: [
        GameChallenge(
          id: 'phishing_1',
          type: ChallengeType.scenario,
          question: 'You receive an email saying "Your account will be closed! Click here to verify." What should you do?',
          options: [
            'Click the link immediately',
            'Delete the email and contact the company directly',
            'Forward it to friends',
            'Reply with your password'
          ],
          correctAnswerIndex: 1,
          explanation: 'Legitimate companies don\'t ask for urgent action via email. Always verify through official channels.',
          points: 75,
        ),
        GameChallenge(
          id: 'phishing_2',
          type: ChallengeType.multipleChoice,
          question: 'Which email address looks suspicious?',
          options: [
            'support@amazon.com',
            'noreply@paypal.com',
            'security@g00gle.com',
            'updates@microsoft.com'
          ],
          correctAnswerIndex: 2,
          explanation: 'Notice the "00" instead of "oo" in google - this is a common phishing trick.',
          points: 60,
        ),
        GameChallenge(
          id: 'phishing_3',
          type: ChallengeType.trueFalse,
          question: 'Phishing emails always have obvious spelling mistakes.',
          options: ['True', 'False'],
          correctAnswerIndex: 1,
          explanation: 'Modern phishing emails can be very convincing and well-written. Always be cautious.',
          points: 50,
        ),
        GameChallenge(
          id: 'phishing_4',
          type: ChallengeType.dragAndDrop,
          question: 'Sort these red flags from most to least suspicious:',
          options: ['Urgent action required', 'Generic greeting', 'Strange sender', 'Poor grammar'],
          correctAnswerIndex: 0,
          explanation: 'All are red flags, but urgent action requests are especially dangerous.',
          points: 80,
        ),
        GameChallenge(
          id: 'phishing_5',
          type: ChallengeType.interactive,
          question: 'Analyze this suspicious email for phishing signs!',
          options: ['Analysis Complete'],
          correctAnswerIndex: 0,
          explanation: 'Good job identifying the warning signs!',
          points: 85,
        ),
      ],
    );
  }

  static GameLevel _createPrivacySettingsLevel() {
    return GameLevel(
      levelNumber: 3,
      title: 'Privacy Guardian',
      theme: 'Privacy Settings',
      description: 'Master your privacy settings to control who sees your information online.',
      backgroundImagePath: 'assets/images/backgrounds/privacy_bg.png',
      characterImagePath: 'assets/images/characters/privacy_hero.png',
      targetScore: 400,
      timeLimit: 180,
      learningObjective: 'Students will learn to configure privacy settings across different platforms.',
      tips: [
        'Review privacy settings regularly',
        'Limit who can see your posts',
        'Control what information is public',
        'Understand data collection practices'
      ],
      challenges: [
        GameChallenge(
          id: 'privacy_1',
          type: ChallengeType.multipleChoice,
          question: 'What should you do before posting photos of friends?',
          options: [
            'Post them without asking',
            'Ask for permission first',
            'Tag everyone automatically',
            'Make them public for everyone'
          ],
          correctAnswerIndex: 1,
          explanation: 'Always get permission before posting photos of others to respect their privacy.',
          points: 60,
        ),
        GameChallenge(
          id: 'privacy_2',
          type: ChallengeType.scenario,
          question: 'A social media app asks for access to your contacts, camera, and location. What should you consider?',
          options: [
            'Accept all permissions to use the app',
            'Only give permissions that make sense for the app',
            'Deny all permissions',
            'Ask friends what they did'
          ],
          correctAnswerIndex: 1,
          explanation: 'Only grant permissions that are necessary for the app to function properly.',
          points: 75,
        ),
        GameChallenge(
          id: 'privacy_3',
          type: ChallengeType.trueFalse,
          question: 'It\'s okay to share your location with all your social media followers.',
          options: ['True', 'False'],
          correctAnswerIndex: 1,
          explanation: 'Sharing location can put you at risk. Only share with close friends and family when necessary.',
          points: 50,
        ),
        GameChallenge(
          id: 'privacy_4',
          type: ChallengeType.dragAndDrop,
          question: 'Match privacy settings with their purposes:',
          options: ['Friends Only', 'Private Account', 'Location Off', 'No Tagging'],
          correctAnswerIndex: 0,
          explanation: 'Each privacy setting helps protect different aspects of your online presence.',
          points: 90,
        ),
        GameChallenge(
          id: 'privacy_5',
          type: ChallengeType.interactive,
          question: 'Configure the privacy settings for this social media profile!',
          options: ['Settings Configured'],
          correctAnswerIndex: 0,
          explanation: 'Great job setting up strong privacy protection!',
          points: 125,
        ),
      ],
    );
  }

  static GameLevel _createCyberbullyingLevel() {
    return GameLevel(
      levelNumber: 4,
      title: 'Kindness Champion',
      theme: 'Cyberbullying',
      description: 'Learn to recognize, prevent, and respond to cyberbullying with kindness and courage.',
      backgroundImagePath: 'assets/images/backgrounds/kindness_bg.png',
      characterImagePath: 'assets/images/characters/kindness_hero.png',
      targetScore: 450,
      timeLimit: 200,
      learningObjective: 'Students will understand cyberbullying and learn strategies to address it.',
      tips: [
        'Be kind and respectful online',
        'Don\'t engage with bullies',
        'Report harmful behavior',
        'Support others who are being bullied'
      ],
      challenges: [
        GameChallenge(
          id: 'cyberbully_1',
          type: ChallengeType.scenario,
          question: 'Someone is posting mean comments about your friend. What should you do?',
          options: [
            'Join in with the comments',
            'Ignore it completely',
            'Support your friend and report the behavior',
            'Screenshot and share the comments'
          ],
          correctAnswerIndex: 2,
          explanation: 'Supporting your friend and reporting harmful behavior helps stop cyberbullying.',
          points: 100,
        ),
        GameChallenge(
          id: 'cyberbully_2',
          type: ChallengeType.multipleChoice,
          question: 'Which response shows good digital citizenship?',
          options: [
            'That\'s a stupid idea!',
            'I disagree, but I respect your opinion.',
            'You\'re so wrong about everything.',
            'Nobody asked for your opinion.'
          ],
          correctAnswerIndex: 1,
          explanation: 'Respectful disagreement shows good digital citizenship and prevents conflicts.',
          points: 75,
        ),
        GameChallenge(
          id: 'cyberbully_3',
          type: ChallengeType.trueFalse,
          question: 'Cyberbullying only happens on social media platforms.',
          options: ['True', 'False'],
          correctAnswerIndex: 1,
          explanation: 'Cyberbullying can happen anywhere online - social media, games, messaging apps, etc.',
          points: 60,
        ),
        GameChallenge(
          id: 'cyberbully_4',
          type: ChallengeType.dragAndDrop,
          question: 'Arrange these responses from least to most helpful:',
          options: ['Ignore', 'Fight Back', 'Report', 'Support Victim'],
          correctAnswerIndex: 0,
          explanation: 'Supporting victims and reporting are the most helpful responses to cyberbullying.',
          points: 90,
        ),
        GameChallenge(
          id: 'cyberbully_5',
          type: ChallengeType.interactive,
          question: 'Practice responding to a cyberbullying situation with kindness!',
          options: ['Response Completed'],
          correctAnswerIndex: 0,
          explanation: 'Your kind response can make a real difference!',
          points: 125,
        ),
      ],
    );
  }

  static GameLevel _createSafeDownloadsLevel() {
    return GameLevel(
      levelNumber: 5,
      title: 'Download Detective',
      theme: 'Safe Downloads',
      description: 'Learn to identify safe downloads and protect your devices from malware.',
      backgroundImagePath: 'assets/images/backgrounds/download_bg.png',
      characterImagePath: 'assets/images/characters/download_hero.png',
      targetScore: 500,
      timeLimit: 160,
      learningObjective: 'Students will learn to safely download files and recognize potential threats.',
      tips: [
        'Only download from trusted sources',
        'Check file types before downloading',
        'Use antivirus software',
        'Be cautious of free software offers'
      ],
      challenges: [
        GameChallenge(
          id: 'download_1',
          type: ChallengeType.multipleChoice,
          question: 'Which is the safest place to download apps?',
          options: [
            'Random websites offering free apps',
            'Official app stores (Google Play, Apple App Store)',
            'Email attachments from strangers',
            'Pop-up ads promising free software'
          ],
          correctAnswerIndex: 1,
          explanation: 'Official app stores review apps for safety before making them available.',
          points: 80,
        ),
        GameChallenge(
          id: 'download_2',
          type: ChallengeType.scenario,
          question: 'A pop-up claims your computer is infected and offers a free antivirus download. What should you do?',
          options: [
            'Download the antivirus immediately',
            'Close the pop-up and run your regular antivirus',
            'Click to learn more about the offer',
            'Share the link with friends'
          ],
          correctAnswerIndex: 1,
          explanation: 'Pop-up antivirus offers are often malware. Use your trusted antivirus software instead.',
          points: 100,
        ),
        GameChallenge(
          id: 'download_3',
          type: ChallengeType.trueFalse,
          question: 'It\'s safe to download files with .exe extension from any website.',
          options: ['True', 'False'],
          correctAnswerIndex: 1,
          explanation: '.exe files can contain viruses. Only download them from trusted sources.',
          points: 70,
        ),
        GameChallenge(
          id: 'download_4',
          type: ChallengeType.dragAndDrop,
          question: 'Sort these file sources from safest to most risky:',
          options: ['Official Website', 'App Store', 'Unknown Email', 'Torrent Site'],
          correctAnswerIndex: 0,
          explanation: 'App stores and official websites are much safer than unknown sources.',
          points: 90,
        ),
        GameChallenge(
          id: 'download_5',
          type: ChallengeType.interactive,
          question: 'Scan this file for safety before downloading!',
          options: ['Scan Complete'],
          correctAnswerIndex: 0,
          explanation: 'Always scan downloads to keep your device safe!',
          points: 160,
        ),
      ],
    );
  }

  static GameLevel _createSocialMediaSafetyLevel() {
    return GameLevel(
      levelNumber: 6,
      title: 'Social Media Superhero',
      theme: 'Social Media Safety',
      description: 'Navigate social media safely and responsibly while having fun with friends.',
      backgroundImagePath: 'assets/images/backgrounds/social_bg.png',
      characterImagePath: 'assets/images/characters/social_hero.png',
      targetScore: 550,
      timeLimit: 190,
      learningObjective: 'Students will learn safe social media practices and how to identify risks.',
      tips: [
        'Think before you post',
        'Don\'t share personal information',
        'Be careful with friend requests',
        'Report inappropriate content'
      ],
      challenges: [
        GameChallenge(
          id: 'social_1',
          type: ChallengeType.scenario,
          question: 'Someone you don\'t know sends you a friend request with an attractive profile picture. What should you do?',
          options: [
            'Accept immediately - they look friendly',
            'Check their profile carefully and only accept if you know them',
            'Accept and start chatting right away',
            'Ask them for more photos'
          ],
          correctAnswerIndex: 1,
          explanation: 'Only connect with people you actually know. Fake profiles are common online.',
          points: 110,
        ),
        GameChallenge(
          id: 'social_2',
          type: ChallengeType.multipleChoice,
          question: 'What information should you NOT share publicly on social media?',
          options: [
            'Your favorite movie',
            'Your school name and schedule',
            'Photos of your pet',
            'Your hobby interests'
          ],
          correctAnswerIndex: 1,
          explanation: 'School information and schedules can help strangers find you in real life.',
          points: 90,
        ),
        GameChallenge(
          id: 'social_3',
          type: ChallengeType.trueFalse,
          question: 'Once you delete a post on social media, it\'s completely gone forever.',
          options: ['True', 'False'],
          correctAnswerIndex: 1,
          explanation: 'Deleted posts may still exist in backups or screenshots. Think before posting!',
          points: 80,
        ),
        GameChallenge(
          id: 'social_4',
          type: ChallengeType.dragAndDrop,
          question: 'Match these situations with the best responses:',
          options: ['Inappropriate Message', 'Cyberbullying', 'Spam Post', 'Fake Profile'],
          correctAnswerIndex: 0,
          explanation: 'Each situation requires a different but important response to stay safe.',
          points: 120,
        ),
        GameChallenge(
          id: 'social_5',
          type: ChallengeType.interactive,
          question: 'Review this social media profile for safety issues!',
          options: ['Review Complete'],
          correctAnswerIndex: 0,
          explanation: 'Great job spotting potential safety concerns!',
          points: 150,
        ),
      ],
    );
  }

  static GameLevel _createDigitalFootprintLevel() {
    return GameLevel(
      levelNumber: 7,
      title: 'Footprint Guardian',
      theme: 'Digital Footprint',
      description: 'Learn how your online actions create a digital footprint and how to manage it wisely.',
      backgroundImagePath: 'assets/images/backgrounds/footprint_bg.png',
      characterImagePath: 'assets/images/characters/footprint_hero.png',
      targetScore: 600,
      timeLimit: 210,
      learningObjective: 'Students will understand digital footprints and learn to manage their online presence.',
      tips: [
        'Everything you do online leaves a trace',
        'Think about your future self',
        'Regularly review your online presence',
        'Create positive digital content'
      ],
      challenges: [
        GameChallenge(
          id: 'footprint_1',
          type: ChallengeType.multipleChoice,
          question: 'What is a digital footprint?',
          options: [
            'A special type of internet password',
            'The trail of data you leave when using the internet',
            'A way to track your steps while walking',
            'A new type of social media app'
          ],
          correctAnswerIndex: 1,
          explanation: 'Your digital footprint is all the information about you that exists online.',
          points: 100,
        ),
        GameChallenge(
          id: 'footprint_2',
          type: ChallengeType.scenario,
          question: 'You want to post a funny but embarrassing video of yourself. What should you consider?',
          options: [
            'Post it right away - it\'s funny!',
            'Think about how it might affect your future',
            'Only post it if friends dare you to',
            'Post it anonymously'
          ],
          correctAnswerIndex: 1,
          explanation: 'Consider how your posts might be viewed by future employers, schools, or family.',
          points: 120,
        ),
        GameChallenge(
          id: 'footprint_3',
          type: ChallengeType.trueFalse,
          question: 'Your digital footprint only includes things you post yourself.',
          options: ['True', 'False'],
          correctAnswerIndex: 1,
          explanation: 'Others can tag you, mention you, or post about you, adding to your digital footprint.',
          points: 90,
        ),
        GameChallenge(
          id: 'footprint_4',
          type: ChallengeType.dragAndDrop,
          question: 'Arrange these activities by how much they affect your digital footprint:',
          options: ['Browsing Websites', 'Posting Photos', 'Online Shopping', 'Creating Accounts'],
          correctAnswerIndex: 0,
          explanation: 'All online activities contribute to your footprint, but some are more visible than others.',
          points: 130,
        ),
        GameChallenge(
          id: 'footprint_5',
          type: ChallengeType.interactive,
          question: 'Audit and clean up this digital footprint!',
          options: ['Cleanup Complete'],
          correctAnswerIndex: 0,
          explanation: 'Regular footprint maintenance helps maintain a positive online presence!',
          points: 160,
        ),
      ],
    );
  }

  static GameLevel _createSecureNetworksLevel() {
    return GameLevel(
      levelNumber: 8,
      title: 'Network Guardian',
      theme: 'Secure Networks',
      description: 'Learn to identify secure networks and protect yourself when connecting to the internet.',
      backgroundImagePath: 'assets/images/backgrounds/network_bg.png',
      characterImagePath: 'assets/images/characters/network_hero.png',
      targetScore: 650,
      timeLimit: 180,
      learningObjective: 'Students will learn to identify secure networks and practice safe connection habits.',
      tips: [
        'Look for secure (locked) WiFi networks',
        'Avoid public WiFi for sensitive activities',
        'Use VPNs when necessary',
        'Keep your devices updated'
      ],
      challenges: [
        GameChallenge(
          id: 'network_1',
          type: ChallengeType.multipleChoice,
          question: 'Which WiFi network is safest to connect to?',
          options: [
            'FreeWiFi (no password)',
            'CoffeeShop_Guest (no password)',
            'MyHome_WiFi (password protected)',
            'ClickHere_ForInternet (no password)'
          ],
          correctAnswerIndex: 2,
          explanation: 'Password-protected networks are more secure than open public networks.',
          points: 110,
        ),
        GameChallenge(
          id: 'network_2',
          type: ChallengeType.scenario,
          question: 'You\'re at a coffee shop and need to check your bank account. What should you do?',
          options: [
            'Use the coffee shop\'s free WiFi',
            'Wait until you get home or use your phone\'s data',
            'Ask to borrow someone else\'s phone',
            'Use any available WiFi network'
          ],
          correctAnswerIndex: 1,
          explanation: 'Never access sensitive information like banking on public WiFi.',
          points: 130,
        ),
        GameChallenge(
          id: 'network_3',
          type: ChallengeType.trueFalse,
          question: 'It\'s safe to enter passwords when connected to public WiFi.',
          options: ['True', 'False'],
          correctAnswerIndex: 1,
          explanation: 'Public WiFi can be monitored by others. Avoid entering sensitive information.',
          points: 100,
        ),
        GameChallenge(
          id: 'network_4',
          type: ChallengeType.dragAndDrop,
          question: 'Rank these networks from most to least secure:',
          options: ['Home WiFi', 'Mobile Data', 'Public WiFi', 'Unknown Network'],
          correctAnswerIndex: 0,
          explanation: 'Your home WiFi and mobile data are much safer than public or unknown networks.',
          points: 140,
        ),
        GameChallenge(
          id: 'network_5',
          type: ChallengeType.interactive,
          question: 'Configure secure network settings for this device!',
          options: ['Configuration Complete'],
          correctAnswerIndex: 0,
          explanation: 'Great job setting up secure network connections!',
          points: 170,
        ),
      ],
    );
  }

  static GameLevel _createInformationLiteracyLevel() {
    return GameLevel(
      levelNumber: 9,
      title: 'Fact Detective',
      theme: 'Information Literacy',
      description: 'Become a fact-checking detective and learn to verify online information.',
      backgroundImagePath: 'assets/images/backgrounds/fact_bg.png',
      characterImagePath: 'assets/images/characters/fact_hero.png',
      targetScore: 700,
      timeLimit: 220,
      learningObjective: 'Students will learn to evaluate online information and identify reliable sources.',
      tips: [
        'Check multiple sources',
        'Look for author credentials',
        'Verify with fact-checking websites',
        'Be skeptical of sensational claims'
      ],
      challenges: [
        GameChallenge(
          id: 'info_1',
          type: ChallengeType.scenario,
          question: 'You see a shocking news story shared by a friend. What should you do before sharing it?',
          options: [
            'Share it immediately - your friend wouldn\'t lie',
            'Check if it\'s reported by reliable news sources',
            'Share it but add "not sure if true"',
            'Only share it to close friends'
          ],
          correctAnswerIndex: 1,
          explanation: 'Always verify information with reliable sources before sharing to prevent spreading misinformation.',
          points: 140,
        ),
        GameChallenge(
          id: 'info_2',
          type: ChallengeType.multipleChoice,
          question: 'Which source is most reliable for health information?',
          options: [
            'A random blog post',
            'A social media influencer',
            'A medical website like Mayo Clinic',
            'A comment on a forum'
          ],
          correctAnswerIndex: 2,
          explanation: 'Established medical institutions provide the most reliable health information.',
          points: 120,
        ),
        GameChallenge(
          id: 'info_3',
          type: ChallengeType.trueFalse,
          question: 'If information appears on multiple websites, it must be true.',
          options: ['True', 'False'],
          correctAnswerIndex: 1,
          explanation: 'False information can spread across multiple sites. Check the original source and credibility.',
          points: 110,
        ),
        GameChallenge(
          id: 'info_4',
          type: ChallengeType.dragAndDrop,
          question: 'Arrange these sources from most to least credible:',
          options: ['Academic Journal', 'News Website', 'Social Media Post', 'Anonymous Blog'],
          correctAnswerIndex: 0,
          explanation: 'Academic sources and established news outlets are generally more credible.',
          points: 150,
        ),
        GameChallenge(
          id: 'info_5',
          type: ChallengeType.interactive,
          question: 'Fact-check this news article using reliable sources!',
          options: ['Fact-Check Complete'],
          correctAnswerIndex: 0,
          explanation: 'Excellent detective work verifying the facts!',
          points: 180,
        ),
      ],
    );
  }

  static GameLevel _createDigitalCitizenshipLevel() {
    return GameLevel(
      levelNumber: 10,
      title: 'Digital Citizen Hero',
      theme: 'Digital Citizenship',
      description: 'Master all aspects of being a responsible and positive digital citizen.',
      backgroundImagePath: 'assets/images/backgrounds/citizen_bg.png',
      characterImagePath: 'assets/images/characters/citizen_hero.png',
      targetScore: 800,
      timeLimit: 240,
      learningObjective: 'Students will demonstrate comprehensive understanding of digital citizenship principles.',
      tips: [
        'Be respectful and kind online',
        'Protect your privacy and others\'',
        'Think critically about information',
        'Help create a positive online community'
      ],
      challenges: [
        GameChallenge(
          id: 'citizen_1',
          type: ChallengeType.scenario,
          question: 'You witness cyberbullying in an online game. As a digital citizen, what should you do?',
          options: [
            'Join in to fit in with the group',
            'Ignore it - it\'s not your problem',
            'Support the victim and report the behavior',
            'Leave the game immediately'
          ],
          correctAnswerIndex: 2,
          explanation: 'Good digital citizens stand up against bullying and help create safer online spaces.',
          points: 160,
        ),
        GameChallenge(
          id: 'citizen_2',
          type: ChallengeType.multipleChoice,
          question: 'What is the most important principle of digital citizenship?',
          options: [
            'Getting the most followers',
            'Treating others with respect and kindness',
            'Sharing everything about your life',
            'Always being right in arguments'
          ],
          correctAnswerIndex: 1,
          explanation: 'Respect and kindness are the foundation of good digital citizenship.',
          points: 140,
        ),
        GameChallenge(
          id: 'citizen_3',
          type: ChallengeType.trueFalse,
          question: 'Digital citizenship only applies to social media platforms.',
          options: ['True', 'False'],
          correctAnswerIndex: 1,
          explanation: 'Digital citizenship applies to all online interactions - games, email, websites, apps, etc.',
          points: 120,
        ),
        GameChallenge(
          id: 'citizen_4',
          type: ChallengeType.dragAndDrop,
          question: 'Match these digital citizenship principles with their descriptions:',
          options: ['Respect', 'Privacy', 'Integrity', 'Responsibility'],
          correctAnswerIndex: 0,
          explanation: 'All these principles work together to create positive online communities.',
          points: 170,
        ),
        GameChallenge(
          id: 'citizen_5',
          type: ChallengeType.interactive,
          question: 'Create a positive impact in this online community scenario!',
          options: ['Impact Created'],
          correctAnswerIndex: 0,
          explanation: 'Congratulations! You\'ve mastered digital citizenship and can make the internet a better place!',
          points: 210,
        ),
      ],
    );
  }
}