import 'package:civil_war/pages/game_page.dart';
import 'package:civil_war/pages/main_menu_page.dart';
import 'package:civil_war/pages/onboarding_screen_page.dart';
import 'package:civil_war/pages/ranking_page.dart';
import 'package:civil_war/providers/game_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GamePageProvider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Manrope'),
        debugShowCheckedModeBanner: false,
        title: 'Guerra Civil',
        initialRoute: 'onboarding',
        routes: {
          'onboarding': (_) => const OnboardingPage(),
          'home': (_) => const MainMenu(),
          'game': (_) => const GamePage(),
          'ranking': (_) => const RankingPage(),
        });
  }
}
