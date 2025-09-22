import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/services/game_service.dart';
import 'core/services/audio_service.dart';
import 'core/services/progress_service.dart';
import 'features/game/screens/game_home_screen.dart';
import 'core/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  await Hive.openBox('gameProgress');
  await Hive.openBox('settings');
  
  runApp(const DigiHeroApp());
}

class DigiHeroApp extends StatelessWidget {
  const DigiHeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameService()),
        ChangeNotifierProvider(create: (_) => AudioService()),
        ChangeNotifierProvider(create: (_) => ProgressService()),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppConstants.primaryColor,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          fontFamily: 'GameFont',
        ),
        home: const GameHomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}