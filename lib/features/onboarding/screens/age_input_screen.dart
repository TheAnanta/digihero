import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/services/game_service.dart';
import '../../../core/constants/app_constants.dart';
import '../../game/screens/game_home_screen.dart';

class AgeInputScreen extends StatefulWidget {
  const AgeInputScreen({super.key});

  @override
  State<AgeInputScreen> createState() => _AgeInputScreenState();
}

class _AgeInputScreenState extends State<AgeInputScreen> {
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
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 
                         MediaQuery.of(context).padding.top - 
                         MediaQuery.of(context).padding.bottom - 48,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // Welcome Header
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
                      'Welcome to DigiHero!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Learn digital literacy through fun games',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppConstants.textSecondaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Age Input
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
                      'How old are you?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This helps us adjust the game difficulty for you',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppConstants.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Age Input Field
                    TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      onChanged: _validateAge,
                      decoration: InputDecoration(
                        labelText: 'Your Age',
                        hintText: 'Enter your age (6-99)',
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
                                _getAgeGroupDescription(_selectedAgeGroup),
                                style: TextStyle(
                                  color: AppConstants.primaryColor,
                                  fontWeight: FontWeight.w500,
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

              // Continue Button
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
                        'Start Learning!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getAgeGroupDescription(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return 'Perfect! We\'ll start with simple concepts and colorful games.';
      case 'medium':
        return 'Great! You\'ll get interactive challenges and detailed explanations.';
      case 'hard':
        return 'Excellent! You\'ll face complex scenarios and advanced topics.';
      case 'expert':
        return 'Amazing! You\'ll tackle professional-level digital literacy challenges.';
      default:
        return '';
    }
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }
}
