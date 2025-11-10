import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';
import 'screens/home_screen.dart';
import 'screens/lesson_detail_screen.dart';
import 'screens/final_quiz_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeBeans',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingScreen(),
        '/lessons_list': (context) => const HomeScreen(),
        '/lesson_detail': (context) => const LessonDetailScreen(),
        '/final_quiz': (context) => const FinalQuizScreen(),
      },
    );
  }
}