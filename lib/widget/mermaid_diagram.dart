import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MermaidDiagram extends StatelessWidget {
  final String code;

  const MermaidDiagram({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    // For now, display code as text; replace with WebView for actual rendering
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mermaid Diagram',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            code,
            style: const TextStyle(color: Colors.white70, fontFamily: 'monospace'),
          ),
        ],
      ),
    ).animate().fadeIn();
  }
}