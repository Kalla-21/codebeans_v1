import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';
import 'screens/home_screen.dart';
import 'screens/lesson_detail_screen.dart';
import 'screens/final_quiz_screen.dart';

void main() {
  runApp(const CodeBeansApp());
}

class CodeBeansApp extends StatelessWidget {
  const CodeBeansApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeBeans',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.brown),
        initialRoute: '/',
        routes: {
          '/': (context) => const LandingScreen(),
          '/lessons_list': (context) => const HomeScreen(),
          '/lesson_detail': (context) => const LessonDetailScreen(),
          '/final_quiz': (context) => const FinalQuizScreen(),
        }
    );
  }
}
