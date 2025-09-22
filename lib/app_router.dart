import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/services/game_service.dart';
import '../features/onboarding/screens/splash_screen.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameService>(
      builder: (context, gameService, child) {
        try {
          // Always show splash screen first - it will handle navigation
          return const SplashScreen();
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
