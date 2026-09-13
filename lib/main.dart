import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'screens/login_screen.dart';
import 'utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const BestChoiceApp());
}

class BestChoiceApp extends StatelessWidget {
  const BestChoiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BestChoice',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const LoginScreen(),
    );
  }
}