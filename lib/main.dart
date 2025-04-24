import 'package:flutter/material.dart';
import 'pages/getting_started_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/home_page.dart';
import 'pages/dashboard_page.dart';

void main() {
  runApp(const NetBotApp());
}

class NetBotApp extends StatelessWidget {
  const NetBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetBot',
      theme: ThemeData(
        primaryColor: const Color(0xFF6B4CAF),
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6B4CAF),
          secondary: Color(0xFF9575CD),
          surface: Color(0xFF16213E),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF0F0F1B),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF6B4CAF)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6B4CAF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: '/getting_started',
      routes: {
        '/getting_started': (context) => const GettingStartedPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}