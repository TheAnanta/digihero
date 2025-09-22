import 'package:hive_flutter/hive_flutter.dart';

/// Simple script to clear age data from Hive storage
/// Run this to reset the age setting and force the app to show age input screen
void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  try {
    // Open the game progress box
    final gameBox = await Hive.openBox('gameProgress');

    print('Current stored age: ${gameBox.get('playerAge')}');
    print('Current stored difficulty: ${gameBox.get('difficultyLevel')}');

    // Clear age and difficulty data
    await gameBox.delete('playerAge');
    await gameBox.delete('difficultyLevel');

    print('Age data cleared!');
    print('After clearing - age: ${gameBox.get('playerAge')}');
    print('After clearing - difficulty: ${gameBox.get('difficultyLevel')}');

    await gameBox.close();
    print('Done! App should now show age input screen.');
  } catch (e) {
    print('Error: $e');
  }
}
