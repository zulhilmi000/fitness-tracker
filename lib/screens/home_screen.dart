import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<StepCount> _stepCountStream;
  String _steps = "0";
  String _status = "Waiting...";

  @override
  void initState() {
    super.initState();
    startListening();
  }

  void startListening() {
    _stepCountStream = Pedometer.stepCountStream;

    _stepCountStream.listen(
      onStepCount,
      onError: onStepError,
      cancelOnError: true,
    );
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps.toString();
      _status = "Walking detected";
    });

    print("Steps: ${event.steps}");
  }

  void onStepError(error) {
    setState(() {
      _status = "Step sensor not available";
    });
    print("Step error: $error");
  }

  @override
  Widget build(BuildContext context) {
    int steps = int.tryParse(_steps) ?? 0;
    int calories = (steps * 0.04).round(); // simple estimation

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
              leading: const Icon(
                Icons.directions_walk,
                color: Colors.blue,
                size: 40,
              ),
              title: const Text('Steps Today'),
              subtitle: Text(
                _steps,
                style: const TextStyle(
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
              leading: const Icon(
                Icons.local_fire_department,
                color: Colors.orange,
                size: 40,
              ),
              title: const Text('Calories Burned'),
              subtitle: Text(
                "$calories calories",
                style: const TextStyle(
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
              leading: const Icon(Icons.info, color: Colors.green, size: 40),
              title: const Text('Activity Status'),
              subtitle: Text(
                _status,
                style: const TextStyle(
                  fontSize: 18,
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
