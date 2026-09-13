import 'package:flutter/material.dart';
import '../Database/database_helper.dart';

class SavedCertificationsScreen extends StatefulWidget {
  const SavedCertificationsScreen({super.key});

  @override
  State<SavedCertificationsScreen> createState() =>
      _SavedCertificationsScreenState();
}

class _SavedCertificationsScreenState
    extends State<SavedCertificationsScreen> {

  List<Map<String, dynamic>> savedCourses = [];

  @override
  void initState() {
    super.initState();
    loadSavedCourses();
  }

  Future<void> loadSavedCourses() async {
    final data =
    await DatabaseHelper.instance.getSavedCertifications();

    setState(() {
      savedCourses = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Saved Certifications"),
        centerTitle: true,
      ),

      body: savedCourses.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              "No saved certifications yet.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: savedCourses.length,
        itemBuilder: (context, index) {
          final course = savedCourses[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: const Icon(Icons.workspace_premium),

              title: Text(course["title"]),

              subtitle: Text(
                "${course["provider"]} • ${course["type"]}",
              ),

              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () async {
                  await DatabaseHelper.instance.deleteSavedCertification(
                    course["id"],
                  );

                  loadSavedCourses();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}