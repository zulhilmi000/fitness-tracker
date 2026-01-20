import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.directions_walk, color: Colors.blue, size: 40),
              title: const Text('Steps Today'),
              subtitle: const Text(
                '8,542 steps',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.local_fire_department, color: Colors.orange, size: 40),
              title: const Text('Calories Burned'),
              subtitle: const Text(
                '1,245 calories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.fitness_center, color: Colors.green, size: 40),
              title: const Text('Workout Status'),
              subtitle: const Text(
                '2 workouts completed today',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
