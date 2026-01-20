import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => ActivityScreenState();
}

class ActivityScreenState extends State<ActivityScreen> {
  final TextEditingController activityTypeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();

  void saveActivity() {
    if (activityTypeController.text.isEmpty ||
        durationController.text.isEmpty ||
        caloriesController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Activity saved successfully!'),
        duration: Duration(seconds: 2),
      ),
    );

    activityTypeController.clear();
    durationController.clear();
    caloriesController.clear();
  }

  @override
  void dispose() {
    activityTypeController.dispose();
    durationController.dispose();
    caloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Activity'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            TextField(
              controller: activityTypeController,
              decoration: const InputDecoration(
                labelText: 'Activity Type',
                hintText: 'e.g., Running, Cycling, Walking',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.directions_run),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Duration (minutes)',
                hintText: 'Enter duration in minutes',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.timer),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: caloriesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Calories Burned',
                hintText: 'Enter calories burned',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_fire_department),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: saveActivity,
              child: const Text('Save Activity'),
            ),
          ],
        ),
      ),
    );
  }
}
