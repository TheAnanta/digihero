import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/services/game_service.dart';
import '../../../core/services/language_service.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/language_selection.dart';
import '../../game/screens/game_home_screen.dart';

class LocalizedAgeInputDemo extends StatefulWidget {
  const LocalizedAgeInputDemo({super.key});

  @override
  State<LocalizedAgeInputDemo> createState() => _LocalizedAgeInputDemoState();
}

class _LocalizedAgeInputDemoState extends State<LocalizedAgeInputDemo> {
  final TextEditingController _ageController = TextEditingController();
  String _selectedAgeGroup = '';
  bool _isValidAge = false;

  final List<Map<String, dynamic>> _ageGroups = [
    {'label': '6-8 years (Beginner)', 'min': 6, 'max': 8, 'difficulty': 'easy'},
    {
      'label': '9-12 years (Intermediate)',
      'min': 9,
      'max': 12,
      'difficulty': 'medium'
    },
    {
      'label': '13-16 years (Advanced)',
      'min': 13,
      'max': 16,
      'difficulty': 'hard'
    },
    {
      'label': '17+ years (Expert)',
      'min': 17,
      'max': 99,
      'difficulty': 'expert'
    },
  ];

  void _validateAge(String value) {
    setState(() {
      if (value.isNotEmpty) {
        final age = int.tryParse(value);
        if (age != null && age >= 6 && age <= 99) {
          _isValidAge = true;
          _determineAgeGroup(age);
        } else {
          _isValidAge = false;
          _selectedAgeGroup = '';
        }
      } else {
        _isValidAge = false;
        _selectedAgeGroup = '';
      }
    });
  }

  void _determineAgeGroup(int age) {
    for (var group in _ageGroups) {
      if (age >= group['min'] && age <= group['max']) {
        _selectedAgeGroup = group['difficulty'];
        break;
      }
    }
  }

  void _continueToGame() {
    if (_isValidAge && _selectedAgeGroup.isNotEmpty) {
      final age = int.parse(_ageController.text);
      context.read<GameService>().setPlayerAge(age, _selectedAgeGroup);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GameHomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the localization service
    final localizations = AppLocalizations.of(context)!;
    final languageService = context.watch<LanguageService>();

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          localizations.appName,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          // Language selection button
          IconButton(
            icon: const Icon(Icons.language, color: Colors.white),
            onPressed: () => LanguageSelectionDialog.show(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Welcome Header - Using localized strings
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppConstants.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.shield,
                      size: 80,
                      color: AppConstants.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      localizations.welcomeMessage, // Localized
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.textPrimaryColor,
                        fontFamily: languageService.fontFamily,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localizations.welcomeDescription, // Localized
                      style: TextStyle(
                        fontSize: 16,
                        color: AppConstants.textSecondaryColor,
                        fontFamily: languageService.fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Age Input - Using localized strings
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppConstants.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.ageQuestion, // Localized
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.textPrimaryColor,
                        fontFamily: languageService.fontFamily,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localizations.ageDescription, // Localized
                      style: TextStyle(
                        fontSize: 14,
                        color: AppConstants.textSecondaryColor,
                        fontFamily: languageService.fontFamily,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Age Input Field
                    TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      onChanged: _validateAge,
                      decoration: InputDecoration(
                        labelText: localizations.translate(
                            'onboarding.ageInput.ageLabel'), // Localized
                        hintText: localizations.translate(
                            'onboarding.ageInput.agePlaceholder'), // Localized
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppConstants.primaryColor,
                            width: 2,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.cake,
                          color: AppConstants.primaryColor,
                        ),
                      ),
                    ),

                    // Age Group Display
                    if (_selectedAgeGroup.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppConstants.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppConstants.primaryColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppConstants.primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                localizations.getAgeGroupDescription(
                                    _selectedAgeGroup), // Localized
                                style: TextStyle(
                                  color: AppConstants.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: languageService.fontFamily,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Continue Button - Using localized strings
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isValidAge ? _continueToGame : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localizations.startLearning, // Localized
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: languageService.fontFamily,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Show Nabha-specific content if in Punjabi
              if (languageService.shouldShowNabhaContent) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppConstants.secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppConstants.secondaryColor.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppConstants.secondaryColor,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              localizations.getNabhaContent('localHeroes'),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.secondaryColor,
                                fontFamily: languageService.fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        localizations
                            .translate('nabhaSpecific.examples.farmer'),
                        style: TextStyle(
                          fontSize: 14,
                          color: AppConstants.textSecondaryColor,
                          fontFamily: languageService.fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }
}
