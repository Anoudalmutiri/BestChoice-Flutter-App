import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../Database/database_helper.dart';

class UserProfileScreen extends StatefulWidget {
  final String userName;
  final String major;
  final String level;

  const UserProfileScreen({
    super.key,
    required this.userName,
    required this.major,
    required this.level,
  });

  @override
  State<UserProfileScreen> createState() =>
      _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
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
        title: const Text("My Profile"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              widget.userName.isEmpty
                  ? "User"
                  : widget.userName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              child: ListTile(
                leading: const Icon(Icons.school),
                title: const Text("Major"),
                subtitle: Text(widget.major),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.workspace_premium),
                title: const Text("Level"),
                subtitle: Text(widget.level),
              ),
            ),

            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "My Saved Certifications",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            savedCourses.isEmpty
                ? const Text(
              "No saved certifications.",
              style: TextStyle(color: Colors.grey),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics:
              const NeverScrollableScrollPhysics(),
              itemCount: savedCourses.length,
              itemBuilder: (context, index) {
                final course = savedCourses[index];

                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.verified,
                      color: Colors.green,
                    ),
                    title: Text(course["title"]),
                    subtitle: Text(
                      "${course["provider"]} • ${course["type"]}",
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