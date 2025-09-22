import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/services/game_service.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Options'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<GameService>(
              builder: (context, gameService, child) {
                return Column(
                  children: [
                    Text('Player Age: ${gameService.playerAge}'),
                    Text('Difficulty: ${gameService.difficultyLevel}'),
                    Text('Has Set Age: ${gameService.hasSetAge}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        gameService.resetGameData();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/',
                          (route) => false,
                        );
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Clear All Data & Reset'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
