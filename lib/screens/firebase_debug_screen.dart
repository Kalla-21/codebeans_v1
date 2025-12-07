// ============================================
// FILE: lib/screens/firebase_debug_screen.dart
// ============================================
// This screen helps you verify Firebase data is being read correctly
// Shows raw data from Firebase and helps troubleshoot issues

import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/lesson.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDebugScreen extends StatefulWidget {
  const FirebaseDebugScreen({super.key});

  @override
  State<FirebaseDebugScreen> createState() => _FirebaseDebugScreenState();
}

class _FirebaseDebugScreenState extends State<FirebaseDebugScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  bool isLoading = false;
  String debugLog = '';

  // Test results
  int lessonsCount = 0;
  int finalQuizCount = 0;
  List<String> lessonIds = [];
  Map<String, dynamic> rawData = {};

  @override
  void initState() {
    super.initState();
    _addLog('📱 Firebase Debug Screen initialized');
  }

  void _addLog(String message) {
    setState(() {
      debugLog += '$message\n';
    });
    print(message);
  }

  /// Test 1: Check Firebase Connection
  Future<void> _testConnection() async {
    _addLog('\n🔍 TEST 1: Testing Firebase connection...');
    setState(() => isLoading = true);

    try {
      final snapshot = await _database.get();
      if (snapshot.exists) {
        _addLog('✅ Firebase connected successfully!');
        _addLog('📊 Root data exists');
      } else {
        _addLog('⚠️ Firebase connected but no data found');
      }
    } catch (e) {
      _addLog('❌ Connection failed: $e');
    }

    setState(() => isLoading = false);
  }

  /// Test 2: Read Lessons from Firebase
  Future<void> _testReadLessons() async {
    _addLog('\n🔍 TEST 2: Reading lessons from Firebase...');
    setState(() => isLoading = true);

    try {
      // Method 1: Using FirebaseService
      final lessons = await _firebaseService.fetchLessons();
      lessonsCount = lessons.length;
      lessonIds = lessons.map((l) => l.id).toList();

      _addLog('✅ Fetched $lessonsCount lessons via FirebaseService');
      _addLog('📋 Lesson IDs: ${lessonIds.join(", ")}');

      // Show lesson details
      for (var lesson in lessons) {
        _addLog('   • ${lesson.id}: ${lesson.title}');
        _addLog('     - SubTopics: ${lesson.subTopics.length}');
        _addLog('     - Questions: ${lesson.questions.length}');
      }

      // Method 2: Direct database read (to verify)
      _addLog('\n🔍 Verifying with direct database read...');
      final snapshot = await _database.child('lessons').get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        _addLog('✅ Direct read successful: ${data.keys.length} lessons');
        _addLog('📋 Keys in database: ${data.keys.join(", ")}');

        // Store raw data for inspection
        setState(() {
          rawData['lessons'] = data;
        });
      } else {
        _addLog('❌ No lessons found in database!');
      }

    } catch (e) {
      _addLog('❌ Error reading lessons: $e');
    }

    setState(() => isLoading = false);
  }

  /// Test 3: Read Final Quiz Questions
  Future<void> _testReadFinalQuiz() async {
    _addLog('\n🔍 TEST 3: Reading final quiz questions...');
    setState(() => isLoading = true);

    try {
      final questions = await _firebaseService.fetchFinalQuizQuestions();
      finalQuizCount = questions.length;

      _addLog('✅ Fetched $finalQuizCount final quiz questions');

      // Show first 3 questions as sample
      for (var i = 0; i < (questions.length > 3 ? 3 : questions.length); i++) {
        _addLog('   ${i + 1}. ${questions[i].question}');
        _addLog('      Type: ${questions[i].type}');
      }

      if (questions.length > 3) {
        _addLog('   ... and ${questions.length - 3} more questions');
      }

    } catch (e) {
      _addLog('❌ Error reading final quiz: $e');
    }

    setState(() => isLoading = false);
  }

  /// Test 4: Check Database Structure
  Future<void> _testDatabaseStructure() async {
    _addLog('\n🔍 TEST 4: Checking database structure...');
    setState(() => isLoading = true);

    try {
      final snapshot = await _database.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;

        _addLog('📊 Database Structure:');
        data.forEach((key, value) {
          _addLog('   • $key: ${value is Map ? '${(value as Map).keys.length} items' : value.runtimeType}');
        });

        // Check lessons structure
        if (data.containsKey('lessons')) {
          _addLog('\n📖 Lessons node found:');
          final lessons = data['lessons'] as Map<dynamic, dynamic>;
          lessons.forEach((lessonId, lessonData) {
            if (lessonData is Map) {
              final lesson = lessonData as Map<dynamic, dynamic>;
              _addLog('   • $lessonId:');
              _addLog('     - title: ${lesson['title'] ?? 'MISSING'}');
              _addLog('     - description: ${lesson['description'] ?? 'MISSING'}');
              _addLog('     - subTopics: ${lesson['subTopics'] != null ? (lesson['subTopics'] as Map).length : 'MISSING'}');
              _addLog('     - questions: ${lesson['questions'] != null ? (lesson['questions'] as Map).length : 'MISSING'}');
            }
          });
        } else {
          _addLog('❌ No "lessons" node found in database!');
        }

        // Check finalQuiz structure
        if (data.containsKey('finalQuiz')) {
          _addLog('\n🎯 Final Quiz node found:');
          final finalQuiz = data['finalQuiz'] as Map<dynamic, dynamic>;
          if (finalQuiz.containsKey('questions')) {
            final questions = finalQuiz['questions'] as Map<dynamic, dynamic>;
            _addLog('   ✅ ${questions.length} questions found');
          } else {
            _addLog('   ❌ No questions found in finalQuiz!');
          }
        } else {
          _addLog('❌ No "finalQuiz" node found in database!');
        }

      } else {
        _addLog('❌ Database is empty!');
      }

    } catch (e) {
      _addLog('❌ Error checking structure: $e');
    }

    setState(() => isLoading = false);
  }

  /// Test 5: Test User Data (Read/Write)
  Future<void> _testUserData() async {
    _addLog('\n🔍 TEST 5: Testing user data operations...');
    setState(() => isLoading = true);

    try {
      const testUserId = 'test_user_debug';

      // Write test data
      _addLog('📝 Writing test user data...');
      await _firebaseService.updateUserProfile(
        testUserId,
        'TestUser123',
        'Testing Firebase',
        '',
      );
      _addLog('✅ Profile data written');

      await _firebaseService.markLessonComplete(testUserId, 'java_001');
      _addLog('✅ Lesson completion written');

      await _firebaseService.saveQuizScore(testUserId, 'java_001', 4.5);
      _addLog('✅ Quiz score written');

      // Read test data back
      _addLog('\n📖 Reading test user data...');
      final profile = await _firebaseService.getUserProfile(testUserId);
      _addLog('✅ Profile: ${profile['username']}');

      final completedLessons = await _firebaseService.getCompletedLessons(testUserId);
      _addLog('✅ Completed lessons: ${completedLessons.join(", ")}');

      final score = await _firebaseService.getQuizScore(testUserId, 'java_001');
      _addLog('✅ Quiz score: $score');

      _addLog('\n🎉 All user data operations successful!');

    } catch (e) {
      _addLog('❌ Error with user data: $e');
    }

    setState(() => isLoading = false);
  }

  /// Run all tests
  Future<void> _runAllTests() async {
    setState(() {
      debugLog = '';
      lessonsCount = 0;
      finalQuizCount = 0;
      lessonIds = [];
    });

    _addLog('🚀 Starting comprehensive Firebase test...\n');

    await _testConnection();
    await _testDatabaseStructure();
    await _testReadLessons();
    await _testReadFinalQuiz();
    await _testUserData();

    _addLog('\n✨ All tests complete!');
    _addLog('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    _addLog('📊 SUMMARY:');
    _addLog('   • Lessons: $lessonsCount');
    _addLog('   • Final Quiz Questions: $finalQuizCount');
    _addLog('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Debug'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                debugLog = '';
                lessonsCount = 0;
                finalQuizCount = 0;
                lessonIds = [];
              });
            },
            tooltip: 'Clear Log',
          ),
        ],
      ),
      body: Column(
        children: [
          // Status Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: isLoading ? Colors.orange.shade100 : Colors.green.shade100,
            child: Row(
              children: [
                if (isLoading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.orange.shade700,
                    ),
                  )
                else
                  Icon(Icons.check_circle, color: Colors.green.shade700),
                const SizedBox(width: 12),
                Text(
                  isLoading ? 'Running tests...' : 'Ready',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isLoading ? Colors.orange.shade700 : Colors.green.shade700,
                  ),
                ),
                const Spacer(),
                if (lessonsCount > 0)
                  Text(
                    '$lessonsCount lessons • $finalQuizCount quiz questions',
                    style: const TextStyle(fontSize: 12),
                  ),
              ],
            ),
          ),

          // Test Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: isLoading ? null : _runAllTests,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Run All Tests'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: isLoading ? null : _testConnection,
                  icon: const Icon(Icons.wifi),
                  label: const Text('Test Connection'),
                ),
                ElevatedButton.icon(
                  onPressed: isLoading ? null : _testReadLessons,
                  icon: const Icon(Icons.book),
                  label: const Text('Read Lessons'),
                ),
                ElevatedButton.icon(
                  onPressed: isLoading ? null : _testReadFinalQuiz,
                  icon: const Icon(Icons.quiz),
                  label: const Text('Read Quiz'),
                ),
                ElevatedButton.icon(
                  onPressed: isLoading ? null : _testDatabaseStructure,
                  icon: const Icon(Icons.account_tree),
                  label: const Text('Check Structure'),
                ),
                ElevatedButton.icon(
                  onPressed: isLoading ? null : _testUserData,
                  icon: const Icon(Icons.person),
                  label: const Text('Test User Data'),
                ),
              ],
            ),
          ),

          const Divider(),

          // Debug Log
          Expanded(
            child: Container(
              color: Colors.black,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  debugLog.isEmpty ? 'Press "Run All Tests" to start...' : debugLog,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.greenAccent,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}