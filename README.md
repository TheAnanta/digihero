# DigiHero 🦸‍♂️

A complex gamified Flutter game for digital literacy education using the Flutter Causal Games toolkit, inspired by Google's Be Internet Awesome program.

## 🎯 Overview

DigiHero is an interactive educational game designed to teach children and young people essential digital literacy skills through engaging gameplay. The game features 10 comprehensive levels covering crucial topics like password security, phishing awareness, privacy settings, cyberbullying prevention, and responsible digital citizenship.

## 🎮 Features

### Game Mechanics
- **10 Educational Levels**: Each focusing on a specific digital literacy topic
- **Multiple Challenge Types**: 
  - Multiple choice questions
  - True/False scenarios  
  - Drag & drop activities
  - Interactive simulations
  - Real-world scenarios
- **Gamification Elements**:
  - Star rating system (1-3 stars per level)
  - Coin collection and rewards
  - Achievement system
  - Progress tracking
  - Life system for added challenge

### Educational Content
1. **Smart Passwords** - Learn to create strong, secure passwords
2. **Phishing Awareness** - Identify and avoid phishing attempts
3. **Privacy Settings** - Master privacy controls across platforms
4. **Cyberbullying** - Recognize and respond to online harassment
5. **Safe Downloads** - Identify safe sources and avoid malware
6. **Social Media Safety** - Navigate social platforms responsibly
7. **Digital Footprint** - Understand and manage online presence
8. **Secure Networks** - Connect safely to WiFi and networks
9. **Information Literacy** - Verify and evaluate online information
10. **Digital Citizenship** - Be a responsible member of online communities

### Visual Design
- **3D Cute Characters**: Engaging animated characters including DigiBuddy, CyberPal, and SafeBot
- **Colorful UI**: Inspired by Google's Material Design and Be Internet Awesome
- **Smooth Animations**: Flutter Animate for engaging transitions
- **Responsive Design**: Works across different screen sizes

### Technical Features
- **State Management**: Provider pattern for clean state management
- **Local Storage**: Hive for offline progress persistence
- **Audio System**: Background music and sound effects
- **Progress Tracking**: Comprehensive analytics and achievements
- **Modular Architecture**: Clean, maintainable code structure

## 🏗️ Architecture

The app follows a feature-based architecture:

```
lib/
├── core/
│   ├── constants/     # App-wide constants
│   ├── models/        # Data models
│   ├── services/      # Core services (Game, Audio, Progress)
│   └── utils/         # Utility functions
├── features/
│   ├── characters/    # Character widgets and logic
│   ├── game/          # Main game screens
│   ├── levels/        # Level selection and gameplay
│   └── ui/            # Reusable UI components
└── main.dart          # App entry point
```

## 🎨 Design Philosophy

DigiHero follows Google's Be Internet Awesome design principles:
- **Engaging**: Gamified learning keeps students motivated
- **Practical**: Real-world scenarios and applicable skills
- **Progressive**: Building knowledge from basic to advanced concepts
- **Inclusive**: Accessible design for diverse learners
- **Safe**: Teaching safety as the primary goal

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/TheAnanta/digihero.git
cd digihero
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 🎵 Assets

The game includes placeholder assets for:
- **Characters**: 3D-style cute character sprites
- **Audio**: Background music and sound effects
- **Fonts**: Custom game fonts
- **Images**: Backgrounds and UI elements

*Note: Replace placeholder assets with actual game assets before production deployment.*

## 🏆 Educational Goals

DigiHero aligns with digital literacy standards and aims to:
- Increase awareness of online safety risks
- Teach practical digital citizenship skills
- Build critical thinking about online information
- Promote kind and respectful online behavior
- Develop technical security knowledge

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for:
- Bug fixes
- Feature enhancements
- Educational content improvements
- Accessibility improvements
- Localization

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Inspired by Google's Be Internet Awesome program
- Built with Flutter and the Flutter community
- Educational content based on digital citizenship best practices

---

**Make the internet a safer place, one game at a time! 🌐✨**