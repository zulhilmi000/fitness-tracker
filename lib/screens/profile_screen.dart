import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;

  final TextEditingController nameController = TextEditingController(
    text: "Zulhilmi",
  );
  final TextEditingController ageController = TextEditingController(text: "20");
  final TextEditingController goalController = TextEditingController(
    text: "Fit and code",
  );

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void saveProfile() {
    setState(() {
      isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully")),
    );
  }

  Widget buildCard({
    required IconData icon,
    required Color color,
    required String title,
    required TextEditingController controller,
    String suffix = "",
  }) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(title),
        subtitle: isEditing
            ? TextField(
                controller: controller,
                keyboardType: title == "Age"
                    ? TextInputType.number
                    : TextInputType.text,
              )
            : Text(
                "${controller.text}$suffix",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.close : Icons.edit),
            onPressed: toggleEdit,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 24),

          buildCard(
            icon: Icons.person,
            color: Colors.blue,
            title: "Name",
            controller: nameController,
          ),

          const SizedBox(height: 16),

          buildCard(
            icon: Icons.calendar_today,
            color: Colors.green,
            title: "Age",
            controller: ageController,
            suffix: " years",
          ),

          const SizedBox(height: 16),

          buildCard(
            icon: Icons.fitness_center,
            color: Colors.orange,
            title: "Fitness Goal",
            controller: goalController,
          ),

          const SizedBox(height: 32),

          if (isEditing)
            ElevatedButton(
              onPressed: saveProfile,
              child: const Text("Save Profile"),
            ),
        ],
      ),
    );
  }
}
