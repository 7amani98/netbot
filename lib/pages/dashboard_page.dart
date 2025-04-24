import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Full Name'),
              style: const TextStyle(color: Colors.white),
            ).animate().slideX(begin: -0.2, end: 0),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              style: const TextStyle(color: Colors.white),
            ).animate().slideX(begin: 0.2, end: 0),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save user data (placeholder)
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ).animate().scale(),
          ],
        ),
      ),
    );
  }
}