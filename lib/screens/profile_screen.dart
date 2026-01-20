import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.blue, size: 40),
              title: const Text('Name'),
              subtitle: const Text(
                'Zulhilmi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.green, size: 40),
              title: const Text('Age'),
              subtitle: const Text(
                '20 years',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.fitness_center, color: Colors.orange, size: 40),
              title: const Text('Fitness Goal'),
              subtitle: const Text(
                'Fit and code',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
