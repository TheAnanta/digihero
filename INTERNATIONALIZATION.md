# DigiHero Internationalization (i18n) Implementation

## Overview

This implementation adds comprehensive internationalization support to the DigiHero app with JSON-based translations for three languages:

- **English (en)** - Default language
- **Hindi (hi)** - Major Indian language
- **Punjabi (pa)** - Regional language with special content for Nabha city

## Files Added/Modified

### 1. Translation Files

- `assets/i18n/en.json` - English translations
- `assets/i18n/hi.json` - Hindi translations
- `assets/i18n/pa.json` - Punjabi translations (includes Nabha-specific content)

### 2. Service Files

- `lib/core/services/localization_service.dart` - Main localization service
- `lib/core/services/language_service.dart` - Language switching and preferences
- `lib/core/widgets/language_selection.dart` - UI components for language selection

### 3. Configuration Updates

- `pubspec.yaml` - Added internationalization dependencies
- `lib/main.dart` - Added localization configuration

## Key Features

### 1. Comprehensive String Extraction

All user-facing strings have been extracted and organized into categories:

- App metadata (name, tagline)
- Onboarding screens
- Game elements (levels, challenges, instructions)
- UI components (buttons, messages)
- Educational content
- Character names and game assets

### 2. Nabha-Specific Content

The Punjabi translation includes special content for Nabha city residents:

- Local examples and references
- Regional context for digital literacy
- Community-relevant scenarios

### 3. Language Service Features

- Automatic language detection
- Persistent language preferences
- Font family selection per language
- RTL support preparation (for future languages)

## Usage Examples

### Basic Translation

```dart
// In any widget with BuildContext
import '../core/services/localization_service.dart';

// Using extension method
Text(context.loc.welcomeMessage)

// Using static method
Text(AppLocalizations.of(context)!.welcomeMessage)

// Using translate method for nested keys
Text(AppLocalizations.of(context)!.translate('levels.themes.meetDevice'))
```

### Language Selection

```dart
// Show language selection dialog
LanguageSelectionDialog.show(context);

// Embed language selection widget
LanguageSelectionWidget(
  showAsList: true,
  onLanguageChanged: () {
    // Handle language change
  },
)
```

### Language Service

```dart
// Change language programmatically
context.read<LanguageService>().changeLanguage('pa');

// Check current language
final languageService = context.read<LanguageService>();
if (languageService.shouldShowNabhaContent) {
  // Show Nabha-specific content
}
```

## Translation Structure

### Hierarchical Organization

```json
{
  "app": {
    "name": "DigiHero",
    "tagline": "Digital Literacy Adventure"
  },
  "onboarding": {
    "ageInput": {
      "welcome": "Welcome to DigiHero!",
      "description": "Learn digital literacy through fun games"
    }
  },
  "levels": {
    "themes": {
      "meetDevice": "Meet Your Digital Device"
    }
  }
}
```

### Nabha-Specific Content (Punjabi only)

```json
{
  "nabhaSpecific": {
    "localHeroes": "ਨਾਭਾ ਦੇ ਡਿਜੀਟਲ ਹੀਰੋ",
    "examples": {
      "farmer": "ਇੱਕ ਨਾਭਾ ਦਾ ਕਿਸਾਨ ਮੌਸਮ ਦੀ ਜਾਣਕਾਰੀ ਆਨਲਾਈਨ ਦੇਖਦਾ ਹੈ"
    }
  }
}
```

## Implementation Steps

### Step 1: Install Dependencies

```bash
flutter pub get
```

### Step 2: Update Existing Widgets

Replace hardcoded strings with localization calls:

**Before:**

```dart
Text('Welcome to DigiHero!')
```

**After:**

```dart
Text(context.loc.welcomeMessage)
```

### Step 3: Add Language Selection

Add language selection to settings or onboarding:

```dart
// In app bar or settings
IconButton(
  icon: Icon(Icons.language),
  onPressed: () => LanguageSelectionDialog.show(context),
)
```

### Step 4: Test Translations

1. Run the app: `flutter run`
2. Test language switching
3. Verify all strings are translated
4. Test Nabha-specific content in Punjabi

## Localization Best Practices

### 1. Key Naming Convention

- Use dot notation for hierarchy: `category.subcategory.key`
- Use camelCase for keys: `ageInput`, `welcomeMessage`
- Keep keys descriptive but concise

### 2. Content Organization

- Group related strings together
- Separate UI elements from content
- Use consistent terminology across languages

### 3. Cultural Sensitivity

- Adapt content for local context (Nabha examples)
- Consider regional preferences
- Use appropriate honorifics and formality levels

### 4. Technical Considerations

- Support for complex scripts (Devanagari, Gurmukhi)
- Font selection per language
- Layout adjustments for text length differences

## Future Enhancements

### 1. Additional Languages

- Add more regional Indian languages
- Support for other states/cities
- RTL language support (Arabic, Urdu)

### 2. Dynamic Content

- Server-side translation updates
- User-contributed translations
- Context-aware content adaptation

### 3. Accessibility

- Screen reader support for all languages
- Voice navigation in local languages
- High contrast mode with language-specific fonts

### 4. Analytics

- Track language usage patterns
- Monitor translation quality
- A/B test localized content effectiveness

## Content Guidelines for Nabha

When adding Nabha-specific content:

1. **Local Context**: Use familiar local landmarks, businesses, and scenarios
2. **Cultural Relevance**: Reference local festivals, traditions, and practices
3. **Educational Value**: Connect digital literacy to local opportunities
4. **Language Authenticity**: Use natural Punjabi expressions and idioms
5. **Community Focus**: Emphasize how digital skills benefit the local community

## Maintenance

### Adding New Strings

1. Add to all three JSON files (`en.json`, `hi.json`, `pa.json`)
2. Use the same key structure across all files
3. Test in all languages before release
4. Update this documentation

### Quality Assurance

- Native speaker review for translations
- Cultural sensitivity review
- Technical testing on different devices
- User feedback collection and incorporation

This internationalization system provides a solid foundation for making DigiHero accessible to diverse users while maintaining special focus on the Nabha community through localized Punjabi content.
