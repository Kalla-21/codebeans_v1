import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';
import 'screens/home_screen.dart';
import 'screens/lesson_detail_screen.dart';
import 'screens/final_quiz_screen.dart';
import 'package:firebase_database/firebase_database.dart';

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

  // --- THIS IS THE FIX ---
  // Explicitly tell the SDK which database URL to use.
  // This overrides the default US-central URL.
  FirebaseDatabase.instance.databaseURL = "https://codebeans-85e23-default-rtdb.asia-southeast1.firebasedatabase.app";

  // Now, when you call FirebaseDatabase.instance anywhere else in the app,
  // it will automatically use the correct URL.
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
