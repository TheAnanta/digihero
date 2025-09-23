import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/services/game_service.dart';
import 'core/services/audio_service.dart';
import 'core/services/progress_service.dart';
import 'core/services/language_service.dart';
import 'core/services/auth_service.dart';
import 'core/constants/app_constants.dart';
import 'app_router.dart';
import 'l10n/app_localizations.dart';

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
        ChangeNotifierProvider(create: (_) => LanguageService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => GameService()),
        ChangeNotifierProvider(create: (_) => AudioService()),
        ChangeNotifierProvider(create: (_) => ProgressService()),
      ],
      child: Consumer<LanguageService>(
        builder: (context, languageService, child) {
          return MaterialApp(
            title: AppConstants.appName,
            locale: languageService.currentLocale, // Use app-controlled locale
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppConstants.primaryColor,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
              fontFamily: languageService.fontFamily,
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const AppRouter(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
