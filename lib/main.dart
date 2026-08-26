import 'package:flutter/material.dart';

import 'presentation/raid/raid_screen.dart';

void main() {
  runApp(const GraffitiGhostsApp());
}

class GraffitiGhostsApp extends StatelessWidget {
  const GraffitiGhostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graffiti Ghosts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0A0820),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF25E7FF),
          secondary: Color(0xFFED28C5),
          tertiary: Color(0xFFA9FF2F),
          surface: Color(0xFF121034),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFE2E7FF)),
          bodyMedium: TextStyle(color: Color(0xFFE2E7FF)),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF25E7FF),
            foregroundColor: const Color(0xFF08101D),
            minimumSize: const Size(48, 48),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(48, 48),
            foregroundColor: const Color(0xFFE2E7FF),
            side: const BorderSide(color: Color(0xFF4D4B8A)),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
          ),
        ),
      ),
      home: const RaidScreen(),
    );
  }
}
