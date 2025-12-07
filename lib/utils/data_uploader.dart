// ============================================
// FILE: lib/screens/data_uploader_screen.dart
// ============================================

import 'package:flutter/material.dart';
import '../data/lesson_data.dart';
import '../data/final_quiz_data.dart';
import '../data/user_data.dart'; // 💡 Import for user count
import '../services/firebase_service.dart';

/// This screen provides a button to upload all hardcoded data to Firebase
/// USE THIS ONLY ONCE, then delete or comment it out
class DataUploaderScreen extends StatefulWidget {
  const DataUploaderScreen({super.key});

  @override
  State<DataUploaderScreen> createState() => _DataUploaderScreenState();
}

class _DataUploaderScreenState extends State<DataUploaderScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  bool isUploading = false;
  bool uploadComplete = false;
  String statusMessage = '';

  /// Upload all data to Firebase
  Future<void> _uploadData() async {
    setState(() {
      isUploading = true;
      statusMessage = 'Starting upload...';
    });

    try {
      // Upload users, lessons, and final quiz questions
      await _firebaseService.uploadInitialData();

      setState(() {
        isUploading = false;
        uploadComplete = true;
        statusMessage = 'Upload complete! ✅\n\n'
            'Created ${initialTestUsers.length} test users\n' // 💡 Updated count
            'Uploaded ${initialLessons.length} lessons\n'
            'Uploaded ${finalQuizQuestions.length} final quiz questions\n\n'
            'You can now delete this screen and use the app!';
      });
    } catch (e) {
      setState(() {
        isUploading = false;
        statusMessage = 'Upload failed! ❌\n\nError: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Data Uploader'),
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                uploadComplete ? Icons.check_circle : Icons.cloud_upload,
                size: 100,
                color: uploadComplete ? Colors.green : Colors.brown.shade700,
              ),
              const SizedBox(height: 30),
              Text(
                uploadComplete ? 'Upload Successful!' : 'Upload Data to Firebase',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                statusMessage.isEmpty
                    ? 'This will upload all lessons, quiz questions, and '
                    '${initialTestUsers.length} test users to Firebase.\n\n' // 💡 Updated text
                    '⚠️ Only do this ONCE!'
                    : statusMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
              if (isUploading)
                CircularProgressIndicator(
                  color: Colors.brown.shade700,
                )
              else if (!uploadComplete)
                ElevatedButton.icon(
                  onPressed: _uploadData,
                  icon: const Icon(Icons.upload),
                  label: const Text('Upload Data Now'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    backgroundColor: Colors.brown.shade700,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to the main application screen
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('Go to Home'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '✨ You can now delete the data_uploader.dart file!',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================
// ALTERNATIVE: Run this function from main.dart
// ============================================
// If you don't want a separate screen, you can call this directly

Future<void> uploadDataFromMain() async {
  print('📤 Starting data upload...');

  final firebaseService = FirebaseService();

  try {
    await firebaseService.uploadInitialData();

    print('✅ Upload complete!');
  } catch (e) {
    print('❌ Upload failed: $e');
  }
}