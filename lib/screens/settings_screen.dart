import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onDarkModeChanged;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 24),

          /// 🌙 Dark Mode Toggle
          Card(
            elevation: 4,
            child: SwitchListTile(
              title: const Text(
                'Dark Mode',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text('Toggle dark theme'),
              value: widget.isDarkMode,
              onChanged: (bool value) {
                widget.onDarkModeChanged(value);
              },
              secondary: const Icon(
                Icons.dark_mode,
                color: Colors.blue,
                size: 40,
              ),
            ),
          ),

          const SizedBox(height: 32),

          /// 📱 App Version Info
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.info, color: Colors.green, size: 40),
              title: const Text(
                'App Version',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text('v1.0.0'),
              trailing: const Icon(Icons.check_circle, color: Colors.green),
            ),
          ),

          const SizedBox(height: 32),

          /// ℹ️ About App
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(
                Icons.fitness_center,
                color: Colors.orange,
                size: 40,
              ),
              title: const Text(
                'About Fitness Tracker',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text(
                'This app helps you track your daily activities, '
                'monitor calories burned, count steps, and export '
                'your activity history to PDF.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
