import 'package:flutter/material.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final members = [
      {
        'name': 'Mark Balading',
        'role': 'Developer',
        'image': 'assets/credits/balading.png',
      },
      {
        'name': 'Lance Herrera',
        'role': 'Developer',
        'image': 'assets/credits/herrera.png',
      },
      {
        'name': 'Julian Yalung',
        'role': 'Developer',
        'image': 'assets/credits/yalung.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Credits'),
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...members.map((m) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 26,
                  backgroundImage: AssetImage(m['image']!),
                ),
                title: Text(
                  m['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Role: ${m['role']}'),
              ),
            );
          }),

          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 12),
          const Text(
            'In partial fulfillment of the requirements in\n'
                'ICS26011 (Applications Development And Emerging Technologies 3)\n'
                '3CSC - Data Science',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
