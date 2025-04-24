import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up for NetBot',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ).animate().fadeIn(),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                style: const TextStyle(color: Colors.white),
              ).animate().slideX(begin: -0.2, end: 0),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                style: const TextStyle(color: Colors.white),
              ).animate().slideX(begin: 0.2, end: 0),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                style: const TextStyle(color: Colors.white),
              ).animate().slideX(begin: -0.2, end: 0),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Sign Up'),
              ).animate().scale(),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Already have an account? Login'),
              ).animate().fadeIn(delay: 0.5.seconds),
            ],
          ),
        ),
      ),
    );
  }
}