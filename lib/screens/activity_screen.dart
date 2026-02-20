import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import '../main.dart';

class Activity {
  String type;
  int duration;
  int calories;

  Activity({
    required this.type,
    required this.duration,
    required this.calories,
  });
}

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => ActivityScreenState();
}

class ActivityScreenState extends State<ActivityScreen> {
  final TextEditingController activityTypeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  List<Activity> activities = [];
  int? editingIndex;

  String sortBy = "None";
  bool ascending = true;

  // ================= NOTIFICATION =================
  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'activity_channel',
          'Activity Notifications',
          channelDescription: 'Notification for saved activities',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  // ================= SAVE ACTIVITY =================
  void saveActivity() {
    if (activityTypeController.text.isEmpty ||
        durationController.text.isEmpty ||
        caloriesController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    final newActivity = Activity(
      type: activityTypeController.text,
      duration: int.parse(durationController.text),
      calories: int.parse(caloriesController.text),
    );

    setState(() {
      if (editingIndex == null) {
        activities.add(newActivity);
      } else {
        activities[editingIndex!] = newActivity;
        editingIndex = null;
      }
    });

    showNotification(
      "Activity Saved",
      "${newActivity.type} for ${newActivity.duration} minutes",
    );

    activityTypeController.clear();
    durationController.clear();
    caloriesController.clear();
  }

  // ================= DELETE CONFIRMATION =================
  void confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Activity"),
        content: const Text("Are you sure you want to delete this activity?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                activities.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // ================= EDIT =================
  void editActivity(int index) {
    setState(() {
      editingIndex = index;
      activityTypeController.text = activities[index].type;
      durationController.text = activities[index].duration.toString();
      caloriesController.text = activities[index].calories.toString();
    });
  }

  // ================= SEARCH + SORT =================
  List<Activity> getProcessedActivities() {
    List<Activity> result = List.from(activities);

    if (searchController.text.isNotEmpty) {
      result = result
          .where(
            (a) => a.type.toLowerCase().contains(
              searchController.text.toLowerCase(),
            ),
          )
          .toList();
    }

    if (sortBy == "Duration") {
      result.sort(
        (a, b) => ascending
            ? a.duration.compareTo(b.duration)
            : b.duration.compareTo(a.duration),
      );
    } else if (sortBy == "Calories") {
      result.sort(
        (a, b) => ascending
            ? a.calories.compareTo(b.calories)
            : b.calories.compareTo(a.calories),
      );
    }

    return result;
  }

  // ================= EXPORT TO PDF =================
  Future<void> exportToPdf() async {
    if (activities.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No activities to export")));
      return;
    }

    final pdf = pw.Document();

    int totalCalories = activities.fold(0, (sum, item) => sum + item.calories);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Fitness Tracker ~~ Activity Report ~~",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),

              ...activities.map(
                (activity) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 8),
                  child: pw.Text(
                    "${activity.type} - ${activity.duration} min - ${activity.calories} cal",
                  ),
                ),
              ),

              pw.Divider(),
              pw.SizedBox(height: 10),

              pw.Text(
                "Total Calories: $totalCalories",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/activity_report.pdf");

    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("PDF saved successfully")));

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'activity_report.pdf',
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final processedActivities = getProcessedActivities();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity Manager"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ===== FORM CARD =====
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: activityTypeController,
                      decoration: const InputDecoration(
                        labelText: 'Activity Type',
                        prefixIcon: Icon(Icons.directions_run),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: durationController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Duration (minutes)',
                        prefixIcon: Icon(Icons.timer),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: caloriesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Calories Burned',
                        prefixIcon: Icon(Icons.local_fire_department),
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: saveActivity,
                        child: Text(
                          editingIndex == null
                              ? "Save Activity"
                              : "Update Activity",
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: exportToPdf,
                        icon: const Icon(Icons.picture_as_pdf),
                        label: const Text("Export to PDF"),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ===== SEARCH =====
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search Activity',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 15),

            // ===== SORT =====
            Row(
              children: [
                const Text("Sort by: "),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: sortBy,
                  items: const [
                    DropdownMenuItem(value: "None", child: Text("None")),
                    DropdownMenuItem(
                      value: "Duration",
                      child: Text("Duration"),
                    ),
                    DropdownMenuItem(
                      value: "Calories",
                      child: Text("Calories"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      sortBy = value!;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    ascending ? Icons.arrow_upward : Icons.arrow_downward,
                  ),
                  onPressed: () {
                    setState(() {
                      ascending = !ascending;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ===== LIST =====
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: processedActivities.length,
              itemBuilder: (context, index) {
                final activity = processedActivities[index];
                final originalIndex = activities.indexOf(activity);

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: Text(activity.type),
                    subtitle: Text(
                      "${activity.duration} min • ${activity.calories} cal",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => editActivity(originalIndex),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => confirmDelete(originalIndex),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
