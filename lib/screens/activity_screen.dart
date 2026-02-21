import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/activity_model.dart';
import '../main.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => ActivityScreenState();
}

class ActivityScreenState extends State<ActivityScreen> {
  final TextEditingController activityController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();

  int? editingIndex;

  Box<ActivityModel> get activityBox => Hive.box<ActivityModel>('activities');

  Future<void> showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'activity_channel',
      'Activity Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(0, title, body, details);
  }

  void saveActivity() {
    if (activityController.text.isEmpty ||
        durationController.text.isEmpty ||
        caloriesController.text.isEmpty)
      return;

    final newActivity = ActivityModel(
      type: activityController.text,
      duration: int.parse(durationController.text),
      calories: int.parse(caloriesController.text),
    );

    if (editingIndex == null) {
      activityBox.add(newActivity);

      showNotification(
        "Activity Saved",
        "${newActivity.type} for ${newActivity.duration} min",
      );
    } else {
      activityBox.putAt(editingIndex!, newActivity);
      editingIndex = null;
    }

    activityController.clear();
    durationController.clear();
    caloriesController.clear();
    setState(() {});
  }

  void editActivity(int index, ActivityModel activity) {
    activityController.text = activity.type;
    durationController.text = activity.duration.toString();
    caloriesController.text = activity.calories.toString();

    editingIndex = index;
    setState(() {});
  }

  void deleteActivity(int index) {
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
              activityBox.deleteAt(index);
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  Future<void> exportToPDF() async {
    final pdf = pw.Document();

    final activities = activityBox.values.toList();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          children: [
            pw.Text(
              "Activity Report",
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            ...activities.map(
              (a) =>
                  pw.Text("${a.type} - ${a.duration} min - ${a.calories} cal"),
            ),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity Manager"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: exportToPDF,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// INPUT FORM
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: activityController,
                      decoration: const InputDecoration(
                        labelText: "Activity Type",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: durationController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Duration (min)",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: caloriesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Calories"),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: saveActivity,
                      child: Text(
                        editingIndex == null
                            ? "Save Activity"
                            : "Update Activity",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// LIST
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: activityBox.listenable(),
                builder: (context, Box<ActivityModel> box, _) {
                  if (box.isEmpty) {
                    return const Center(child: Text("No activities yet"));
                  }

                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final activity = box.getAt(index)!;

                      return Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(activity.type),
                          subtitle: Text(
                            "${activity.duration} min • ${activity.calories} cal",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () => editActivity(index, activity),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => deleteActivity(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
