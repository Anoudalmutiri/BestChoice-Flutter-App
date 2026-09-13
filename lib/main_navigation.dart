import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/recommendations_screen.dart';
import 'screens/saved_certifications_screen.dart';
import 'screens/user_profile_screen.dart';

class MainNavigation extends StatefulWidget {
  final String userName;
  final String major;
  final String level;

  const MainNavigation({
    super.key,
    required this.userName,
    required this.major,
    required this.level,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      HomeScreen(
        userName: widget.userName,
        major: widget.major,
        level: widget.level,
      ),

      RecommendationsScreen(
        major: widget.major,
      ),

      const SavedCertificationsScreen(),

      UserProfileScreen(
        userName: widget.userName,
        major: widget.major,
        level: widget.level,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1E5EFF),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 13,
        unselectedFontSize: 12,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recommend),
            label: "Recommendations",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: "Saved",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}