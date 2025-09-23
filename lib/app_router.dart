import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/game_service.dart';
import 'core/services/auth_service.dart';
import 'features/onboarding/screens/splash_screen.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<GameService, AuthService>(
      builder: (context, gameService, authService, child) {
        try {
          // Always show splash screen first - it will handle navigation
          return const SplashScreen();
        } catch (e) {
          // If there's an error accessing services, show loading
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
