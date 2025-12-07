import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';
import 'screens/home_screen.dart';
import 'screens/lesson_detail_screen.dart';
import 'screens/final_quiz_screen.dart';
import 'screens/firebase_debug_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'utils/data_uploader.dart';

void writeTestMessage() async {
  // Get a reference to a specific location in your database.
  // This will create a new node called 'test_writes' if it doesn't exist.
  DatabaseReference ref = FirebaseDatabase.instance.ref("test_writes");

  try {
    // Use the push() method to create a new unique ID for the entry.
    // Then use set() to write the data.
    await ref.push().set({
      "message": "Hello, Firebase! This is a test write.",
      "timestamp": DateTime.now().toIso8601String(),
      "user": "test_user"
    });

    print("Data written successfully!");

  } catch (error) {
    print("Failed to write data: $error");
  }
}

Future<void> main() async{
  // Ensure Flutter is ready.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the core Firebase app (this is correct).
  await Firebase.initializeApp();

  // Explicitly tell the SDK which database URL to use for Realtime Database.
  FirebaseDatabase.instance.databaseURL = "https://codebeans-85e23-default-rtdb.asia-southeast1.firebasedatabase.app";

  runApp(const CodeBeansApp());
}

class CodeBeansApp extends StatelessWidget {
  const CodeBeansApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CodeBeans',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.brown),
        // 💡 CHANGE INITIAL ROUTE to /login
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
        }
    );
  }
}
