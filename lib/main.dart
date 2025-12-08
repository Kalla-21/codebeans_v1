import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'screens/landing_screen.dart';
import 'screens/home_screen.dart';
import 'screens/lesson_detail_screen.dart';
import 'screens/final_quiz_screen.dart';
import 'screens/firebase_debug_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'utils/data_uploader.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/credits_screen.dart';

void writeTestMessage() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('test_writes');

  try {
    await ref.push().set({
      'message': 'Hello, Firebase! This is a test write.',
      'timestamp': DateTime.now().toIso8601String(),
      'user': 'test_user',
    });
    print('Data written successfully!');
  } catch (error) {
    print('Failed to write data: $error');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseDatabase.instance.databaseURL =
  'https://codebeans-85e23-default-rtdb.asia-southeast1.firebasedatabase.app';

  runApp(const CodeBeansApp());
}

class CodeBeansApp extends StatefulWidget {
  const CodeBeansApp({super.key});

  @override
  State<CodeBeansApp> createState() => _CodeBeansAppState();
}

class _CodeBeansAppState extends State<CodeBeansApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _updateTheme(bool darkMode) {
    setState(() {
      _themeMode = darkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeBeans',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.brown,
        fontFamily: 'Montserrat',
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.brown,
        fontFamily: 'Montserrat',
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingScreen(),
        '/debug': (context) => const FirebaseDebugScreen(),
        '/upload_data': (context) => const DataUploaderScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/lessons_list': (context) => const HomeScreen(),
        '/lesson_detail': (context) => const LessonDetailScreen(),
        '/final_quiz': (context) => const FinalQuizScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) {
          final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          final progressive = args?['progressiveMode'] as bool? ?? true;
          final darkMode =
              args?['darkMode'] as bool? ?? (_themeMode == ThemeMode.dark);

          return SettingsScreen(
            initialProgressiveMode: progressive,
            initialDarkMode: darkMode,
            onThemeChanged: _updateTheme,
          );
        },
        '/credits': (context) => const CreditsScreen(),
      },
    );
  }
}
