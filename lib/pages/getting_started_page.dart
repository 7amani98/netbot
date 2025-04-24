import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to NetBot',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.purple.withOpacity(0.5),
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 1.seconds)
                  .slideY(begin: -0.2, end: 0),
              const SizedBox(height: 20),
              const Text(
                'Your AI-powered network assistant',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ).animate().fadeIn(delay: 0.5.seconds),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Get Started'),
              ).animate().scale(delay: 1.seconds),
            ],
          ),
        ),
      ),
    );
  }
}