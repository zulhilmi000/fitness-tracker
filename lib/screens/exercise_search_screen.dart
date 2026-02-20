import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Required for kIsWeb
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'exercise_detail_screen.dart';

class ExerciseSearchScreen extends StatefulWidget {
  const ExerciseSearchScreen({super.key});

  @override
  State<ExerciseSearchScreen> createState() => _ExerciseSearchScreenState();
}

class _ExerciseSearchScreenState extends State<ExerciseSearchScreen> {
  final TextEditingController bodyPartController = TextEditingController();
  bool isLoadingExercises = false;
  bool hasError = false;
  List<Map<String, String>> exerciseResults = [];

  static const String apiKey =
      '3c2be5718dmsh8ae88403bac5d38p1df3bcjsn877016467ce6';
  static const String baseUrl =
      'https://edb-with-videos-and-images-by-ascendapi.p.rapidapi.com';

  @override
  void dispose() {
    bodyPartController.dispose();
    super.dispose();
  }

  Future<void> handleSearch() async {
    String query = bodyPartController.text.trim().toLowerCase();
    if (query.isEmpty) return;

    setState(() {
      isLoadingExercises = true;
      hasError = false;
      exerciseResults = [];
    });

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/exercises?limit=100'),
        headers: {
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host':
              'edb-with-videos-and-images-by-ascendapi.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = json.decode(response.body);
        final List<dynamic> data = decoded['data'] ?? [];

        final filtered = data.where((exercise) {
          final List<dynamic> bodyParts = exercise['bodyParts'] ?? [];
          final List<dynamic> targets = exercise['targetMuscles'] ?? [];
          final String name = (exercise['name'] ?? '').toString().toLowerCase();

          return bodyParts.any(
                (p) => p.toString().toLowerCase().contains(query),
              ) ||
              targets.any((t) => t.toString().toLowerCase().contains(query)) ||
              name.contains(query);
        }).toList();

        setState(() {
          exerciseResults = filtered.map((exercise) {
            String rawUrl = exercise['imageUrl']?.toString() ?? '';

            // SMART IMAGE LOADING:
            // Use proxy on Web (laptop) to fix CORS. Use direct URL on Phone.
            String finalImageUrl = (kIsWeb && rawUrl.isNotEmpty)
                ? 'https://corsproxy.io/?${Uri.encodeComponent(rawUrl)}'
                : rawUrl;

            return {
              'name': exercise['name']?.toString() ?? 'Unknown',
              'target':
                  (exercise['targetMuscles'] as List?)?.join(', ') ?? 'N/A',
              'equipment':
                  (exercise['equipments'] as List?)?.join(', ') ?? 'N/A',
              'image': finalImageUrl,
            };
          }).toList();
          isLoadingExercises = false;
        });
      } else {
        throw Exception('Failed');
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoadingExercises = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Search'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          _buildSearchInput(),
          Expanded(child: _buildResultList()),
        ],
      ),
    );
  }

  Widget _buildSearchInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: bodyPartController,
        decoration: InputDecoration(
          hintText: 'Search (e.g. calves, back)',
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: handleSearch,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onSubmitted: (_) => handleSearch(),
      ),
    );
  }

  Widget _buildResultList() {
    if (isLoadingExercises) {
      return const Center(child: CircularProgressIndicator());
    }
    if (hasError) return const Center(child: Text('Check internet connection'));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: exerciseResults.length,
      itemBuilder: (context, index) {
        final exercise = exerciseResults[index];
        return Hero(
          tag: 'hero-${exercise['name']}',
          child: Card(
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ExerciseDetailScreen(exercise: exercise),
                ),
              ),
              child: Column(
                children: [
                  if (exercise['image'] != '')
                    Image.network(
                      exercise['image']!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ListTile(
                    title: Text(
                      exercise['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Target: ${exercise['target']}'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
