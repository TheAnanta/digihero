# DigiHero 🦸‍♂️

A complex gamified Flutter game for digital literacy education using the Flutter Causal Games toolkit, aligned with a comprehensive rural education syllabus.

## 🎯 Overview

DigiHero is an interactive educational game designed to teach rural students essential digital literacy skills through engaging gameplay. The game features 20 comprehensive levels organized into 5 educational units, covering everything from basic device operation to advanced digital citizenship and career preparation.

## 🎮 Features

### Game Mechanics
- **20 Educational Levels**: Organized into 5 units with 4 chapters each
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

### Educational Content (5-Unit Syllabus)

#### Unit 1: My First Step into the Digital World
1. **Meet Your Digital Device** - Learn about different devices and their parts
2. **Understanding Your Screen** - Discover icons, menus and basic navigation
3. **Working with Apps** - Learn to open and use applications safely
4. **Why Digital Skills Matter** - Understand how technology helps your future

#### Unit 2: Using Digital Tools for School and Learning
5. **Mastering Our Learning App** - Navigate and use educational apps effectively
6. **Writing and Typing** - Practice typing in your language and English
7. **Creating Presentations** - Make simple presentations with text and images
8. **Organizing Digital Work** - Learn to save and organize your files

#### Unit 3: Exploring the Internet Safely
9. **What is the Internet** - Understand the internet and how to connect
10. **Searching for Information** - Learn to search effectively and safely
11. **Staying Safe Online** - Protect yourself and your personal information
12. **Being a Good Digital Citizen** - Be kind and respectful online

#### Unit 4: Communication and Collaboration
13. **Introduction to Email** - Learn to compose and send emails safely
14. **Messaging Apps Safety** - Use messaging apps responsibly for school
15. **Understanding Progress** - Track your learning journey and improvement
16. **Working Together Online** - Collaborate on digital projects with others

#### Unit 5: Digital Skills for Life
17. **Exploring Hobbies Online** - Find reliable information about your interests
18. **Digital Payments Safety** - Understand and stay safe with digital money
19. **Career Opportunities** - Discover careers and educational opportunities
20. **Digital Portfolio Project** - Create a showcase of your digital skills

### Visual Design
- **3D Cute Characters**: Engaging animated characters including DigiBuddy, CyberPal, and SafeBot
- **Colorful UI**: Inspired by Google's Material Design with educational themes
- **Smooth Animations**: Flutter Animate for engaging transitions
- **Responsive Design**: Works across different screen sizes

### Technical Features
- **State Management**: Provider pattern for clean state management
- **Local Storage**: Hive for offline progress persistence
- **Audio System**: Background music and sound effects
- **Progress Tracking**: Comprehensive analytics and achievements
- **Modular Architecture**: Clean, maintainable code structure
- **Unit-Based Progression**: Follow the structured syllabus path

## 🏗️ Architecture

The app follows a feature-based architecture with syllabus integration:

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