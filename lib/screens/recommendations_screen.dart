import 'package:flutter/material.dart';
import '../services/saved_certifications.dart';
import '../Database/database_helper.dart';
class RecommendationsScreen extends StatelessWidget {
  final String major;

  const RecommendationsScreen({
    super.key,
    required this.major,
  });

  @override
  Widget build(BuildContext context) {

    final Map<String, List<Map<String, String>>> recommendations = {
      "Information Technology": [
        {
          "title": "Google Data Analytics",
          "provider": "Google",
          "type": "Free",
        },
        {
          "title": "AWS Cloud Practitioner",
          "provider": "Amazon",
          "type": "Paid",
        },
        {
          "title": "Microsoft Azure AZ-900",
          "provider": "Microsoft",
          "type": "Free",
        },
        {
          "title": "Oracle Java Foundations",
          "provider": "Oracle",
          "type": "Free",
        },
        {
          "title": "Cisco CCNA",
          "provider": "Cisco",
          "type": "Paid",
        },
      ],

      "Cybersecurity": [
        {
          "title": "CompTIA Security+",
          "provider": "CompTIA",
          "type": "Paid",
        },
        {
          "title": "CEH",
          "provider": "EC-Council",
          "type": "Paid",
        },
      ],
      "Data Science": [
        {
          "title": "Google Data Analytics",
          "provider": "Google",
          "type": "Free",
        },
        {
          "title": "Microsoft Power BI",
          "provider": "Microsoft",
          "type": "Free",
        },
        {
          "title": "IBM Data Science",
          "provider": "IBM",
          "type": "Paid",
        },
        {
          "title": "SQL for Data Analysis",
          "provider": "Coursera",
          "type": "Free",
        },
      ],
      "Artificial Intelligence": [
        {
          "title": "TensorFlow Developer",
          "provider": "Google",
          "type": "Paid",
        },
        {
          "title": "Azure AI Fundamentals",
          "provider": "Microsoft",
          "type": "Free",
        },
      ],
    };

    final courses = recommendations[major] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommendations"),
        centerTitle: true,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: Text(course["title"]!),
              subtitle: Text(
                "${course["provider"]} • ${course["type"]}",
              ),
              trailing:ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper.instance.insertSavedCertification(
                    course["title"]!,
                    course["provider"]!,
                    course["type"]!,
                  );

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${course["title"]} saved successfully!"),
                    ),
                  );
                },
                child: const Text("Save"),
              ),
            ),
          );
        },
      ),
    );
  }
}