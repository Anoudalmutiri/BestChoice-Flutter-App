import 'package:flutter/material.dart';
import 'recommendations_screen.dart';
import 'saved_certifications_screen.dart';
class HomeScreen extends StatelessWidget {
  final String userName;
  final String major;
  final String level;

  const HomeScreen({
    super.key,
    required this.userName,
    required this.major,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BestChoice"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, $userName 👋",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Major: $major",
              style: const TextStyle(fontSize: 16),
            ),

            Text(
              "Level: $level",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 35),

            const Text(
              "Quick Access",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _buildCard(
              context,
              title: "Recommendations",
              subtitle: "Discover certifications for your major",
              icon: Icons.menu_book,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecommendationsScreen(
                      major: major,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            _buildCard(
              context,
              title: "Saved Certifications",
              subtitle: "View your saved certifications",
              icon: Icons.bookmark,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SavedCertificationsScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            _buildCard(
              context,
              title: "Results",
              subtitle: "View previous comparison results",
              icon: Icons.bar_chart,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: 35,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}