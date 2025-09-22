import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/services/game_service.dart';
import '../features/onboarding/screens/age_input_screen.dart';
import '../features/game/screens/game_home_screen.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameService>(
      builder: (context, gameService, child) {
        // Check if user has set their age
        try {
          if (!gameService.hasSetAge) {
            return const AgeInputScreen();
          }

          // If age is set, go to the main game
          return const GameHomeScreen();
        } catch (e) {
          // If there's an error accessing GameService, show loading
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
