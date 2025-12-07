// ============================================
// FILE: lib/services/firebase_service.dart
// ============================================

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/lesson.dart';
import '../data/lesson_data.dart';
import '../data/final_quiz_data.dart';
import '../data/user_data.dart'; // 💡 New Import for users

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  // ====================================
  // 🔑 AUTHENTICATION OPERATIONS
  // ====================================

  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  Future<User?> signUp(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('✅ User signed up: ${userCredential.user?.uid}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('❌ Sign-up error: ${e.code} - ${e.message}');
      throw Exception(_getAuthErrorMessage(e.code));
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('✅ User signed in: ${userCredential.user?.uid}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('❌ Sign-in error: ${e.code} - ${e.message}');
      throw Exception(_getAuthErrorMessage(e.code));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    print('✅ User signed out');
  }

  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'The password provided is too weak (min 6 characters).';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'user-not-found':
      case 'wrong-password':
        return 'Invalid email or password.';
      default:
        return 'An unknown authentication error occurred.';
    }
  }

  /// 💡 UPDATED: Create a user in Auth and initialize their profile in DB
  /// Now accepts photoUrl and writes to the root user node (users/$uid)
  Future<void> createUserAndProfile(
      String email,
      String password,
      String username,
      String bio, {
        String photoUrl = '', // Added optional parameter
      }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = userCredential.user!.uid;

      // 1. Sanitize the user ID (safety check)
      final sanitizedUserId = _sanitizeKey(userId);

      // 2. Initialize the user's profile in the Realtime Database
      // REMOVED '/profile' subpath to match HomeScreen expectations
      await _database.child('users/$sanitizedUserId').set({
        'username': username,
        'bio': bio,
        'photoUrl': photoUrl, // Use the passed photoUrl
        'email': email,
      });

      print('✅ Created user and profile: $email');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('⚠️ User already exists, skipping: $email');
      } else {
        print('❌ Auth error creating user $email: ${e.code} - ${e.message}');
        rethrow;
      }
    } catch (e) {
      print('❌ DB error initializing profile for $email: $e');
      rethrow;
    }
  }

  // ====================================
  // LESSON OPERATIONS
  // ====================================

  /// Fetch all lessons from Firebase
  Future<List<Lesson>> fetchLessons() async {
    try {
      final snapshot = await _database.child('lessons').get();
      if (!snapshot.exists) {
        print('⚠️ No lessons found in Firebase!');
        return [];
      }

      final lessonsData = snapshot.value;
      final List<Lesson> lessons = [];

      if (lessonsData is List) {
        print('📊 Lessons stored as LIST format');
        for (var item in lessonsData) {
          if (item != null) {
            try {
              final lessonMap = Map<String, dynamic>.from(item as Map);
              lessons.add(Lesson.fromMap(lessonMap)); // Uses Lesson.fromMap
            } catch (e) {
              print('❌ Error parsing lesson: $e');
            }
          }
        }
      } else if (lessonsData is Map) {
        print('📊 Lessons stored as MAP format');
        lessonsData.forEach((key, value) {
          try {
            final lessonMap = Map<String, dynamic>.from(value as Map);
            lessons.add(Lesson.fromMap(lessonMap)); // Uses Lesson.fromMap
          } catch (e) {
            print('❌ Error parsing lesson $key: $e');
          }
        });
      }

      lessons.sort((a, b) => a.id.compareTo(b.id));
      print('✅ Fetched ${lessons.length} lessons from Firebase');
      return lessons;
    } catch (e) {
      print('❌ Error fetching lessons: $e');
      return [];
    }
  }

  // ====================================
  // FINAL QUIZ OPERATIONS
  // ====================================

  /// Fetch all final quiz questions
  Future<List<Question>> fetchFinalQuizQuestions() async {
    try {
      final snapshot = await _database.child('finalQuiz/questions').get();
      if (!snapshot.exists) {
        print('⚠️ No final quiz questions found!');
        return [];
      }

      final questionsData = snapshot.value;
      final List<Question> questions = [];

      if (questionsData is List) {
        print('📊 Final quiz stored as LIST format');
        for (var item in questionsData) {
          if (item != null) {
            try {
              final questionMap = Map<String, dynamic>.from(item as Map);
              questions.add(Question.fromMap(questionMap)); // Uses Question.fromMap
            } catch (e) {
              print('❌ Error parsing question: $e');
            }
          }
        }
      } else if (questionsData is Map) {
        print('📊 Final quiz stored as MAP format');
        questionsData.forEach((key, value) {
          try {
            final questionMap = Map<String, dynamic>.from(value as Map);
            questions.add(Question.fromMap(questionMap)); // Uses Question.fromMap
          } catch (e) {
            print('❌ Error parsing question $key: $e');
          }
        });
      }

      print('✅ Fetched ${questions.length} final quiz questions');
      return questions;
    } catch (e) {
      print('❌ Error fetching final quiz: $e');
      return [];
    }
  }

  // ====================================
  // USER PROFILE OPERATIONS
  // ====================================

  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      final sanitizedUserId = _sanitizeKey(userId);
      // UPDATED: Look at root 'users/$uid', removed /profile nesting
      final snapshot = await _database.child('users/$sanitizedUserId').get();

      if (!snapshot.exists) {
        return {
          'username': 'Default User',
          'bio': 'Java Learner',
          'photoUrl': '',
        };
      }
      return Map<String, dynamic>.from(snapshot.value as Map);
    } catch (e) {
      print('❌ Error fetching user profile: $e');
      return {
        'username': 'Default User',
        'bio': 'Java Learner',
        'photoUrl': '',
      };
    }
  }

  Future<void> updateUserProfile(
      String userId,
      String username,
      String bio,
      String photoUrl, // Changed from avatarUrl to match model
      ) async {
    try {
      final sanitizedUserId = _sanitizeKey(userId);
      // UPDATED: Update root 'users/$uid'
      await _database.child('users/$sanitizedUserId').update({
        'username': username,
        'bio': bio,
        'photoUrl': photoUrl,
      });
      print('✅ Profile updated successfully');
    } catch (e) {
      print('❌ Error updating profile: $e');
    }
  }

  // ====================================
  // USER PROGRESS OPERATIONS
  // ====================================

  Future<List<String>> getCompletedLessons(String userId) async {
    try {
      final sanitizedUserId = _sanitizeKey(userId);
      final snapshot = await _database
          .child('users/$sanitizedUserId/completedLessons')
          .get();

      if (!snapshot.exists) {
        return [];
      }

      final data = snapshot.value;

      if (data is List) {
        return data.map((e) => e.toString()).toList();
      } else if (data is Map) {
        return data.keys.map((e) => e.toString()).toList();
      }
      return [];
    } catch (e) {
      print('❌ Error fetching completed lessons: $e');
      return [];
    }
  }

  Future<void> markLessonComplete(String userId, String lessonId) async {
    try {
      final sanitizedUserId = _sanitizeKey(userId);
      await _database
          .child('users/$sanitizedUserId/completedLessons/$lessonId')
          .set(true);

      print('✅ Lesson $lessonId marked as complete');
    } catch (e) {
      print('❌ Error marking lesson complete: $e');
    }
  }

  Future<void> saveQuizScore(
      String userId,
      String lessonId,
      double score,
      ) async {
    try {
      final sanitizedUserId = _sanitizeKey(userId);
      await _database
          .child('users/$sanitizedUserId/lessonScores/$lessonId')
          .set(score);
      print('✅ Quiz score saved: $score');
    } catch (e) {
      print('❌ Error saving quiz score: $e');
    }
  }

  Future<double> getQuizScore(String userId, String lessonId) async {
    try {
      final sanitizedUserId = _sanitizeKey(userId);
      final snapshot = await _database
          .child('users/$sanitizedUserId/lessonScores/$lessonId')
          .get();

      if (!snapshot.exists) {
        return 0.0;
      }
      return (snapshot.value as num).toDouble();
    } catch (e) {
      print('❌ Error fetching quiz score: $e');
      return 0.0;
    }
  }

  Future<void> saveFinalQuizScore(String userId, double score) async {
    try {
      final sanitizedUserId = _sanitizeKey(userId);
      await _database
          .child('users/$sanitizedUserId/finalQuizScore')
          .set(score);
      print('✅ Final quiz score saved: $score');
    } catch (e) {
      print('❌ Error saving final quiz score: $e');
    }
  }

  Future<double> getFinalQuizScore(String userId) async {
    try {
      final sanitizedUserId = _sanitizeKey(userId);
      final snapshot = await _database
          .child('users/$sanitizedUserId/finalQuizScore')
          .get();

      if (!snapshot.exists) {
        return 0.0;
      }
      return (snapshot.value as num).toDouble();
    } catch (e) {
      print('❌ Error fetching final quiz score: $e');
      return 0.0;
    }
  }

  // ====================================
  // UTILITY METHODS
  // ====================================

  String _sanitizeKey(String key) {
    return key
        .replaceAll('.', '_')
        .replaceAll('#', '_')
        .replaceAll('\$', '_')
        .replaceAll('[', '_')
        .replaceAll(']', '_');
  }

  Future<void> resetUserProgress(String userId) async {
    try {
      final sanitizedUserId = _sanitizeKey(userId);
      await _database.child('users/$sanitizedUserId').remove();
      print('✅ User progress reset');
    } catch (e) {
      print('❌ Error resetting progress: $e');
    }
  }

  Future<void> deleteUserAccount(String userId) async {
    try {
      final sanitizedUserId = _sanitizeKey(userId);
      await _database.child('users/$sanitizedUserId').remove();
      print('✅ User account deleted');
    } catch (e) {
      print('❌ Error deleting account: $e');
    }
  }

  // ====================================
  // DATA UPLOAD HELPER (UPDATED)
  // ====================================

  /// ⚠️ USE THIS ONCE to upload your hardcoded data to Firebase
  Future<void> uploadInitialData() async {
    try {
      print('📤 Starting data upload to Firebase...');

      // --- 1. UPLOAD USERS ---
      print('👤 Starting user creation...');
      for (var testUser in initialTestUsers) {
        UserCredential? credential;

        // Try creating Auth User
        try {
          credential = await _auth.createUserWithEmailAndPassword(
            email: testUser.email,
            password: testUser.password,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            print('⚠️ User ${testUser.email} already exists in Auth. (Skipping Auth create)');
            // Note: If user exists, we skip Auth creation.
            // The DB update will happen in HomeScreen's auto-repair if strictly needed,
            // or we could sign in here to get UID, but that complicates the uploader.
          } else {
            print('❌ Auth error for ${testUser.email}: $e');
          }
        }

        // If we created a NEW user, write their DB data immediately
        if (credential != null) {
          final uid = credential.user!.uid;

          // Write Profile
          await _database.child('users/$uid').set({
            'username': testUser.username,
            'bio': testUser.bio,
            'email': testUser.email,
            'photoUrl': testUser.photoUrl,
          });

          // Write Progress
          if (testUser.progress.isNotEmpty) {
            await _database.child('users/$uid/completedLessons').set(testUser.progress);
          }
          print('✅ DB Profile created for ${testUser.username}');
        }
      }
      print('✅ User processing complete.');

      // --- 2. UPLOAD LESSONS ---
      for (var lesson in initialLessons) {
        final lessonData = {
          'id': lesson.id,
          'title': lesson.title,
          'description': lesson.description,
          'subTopics': lesson.subTopics.map((s) => {
            'title': s.title,
            'content': s.content,
            'runnableCode': s.runnableCode,
            'expectedOutput': s.expectedOutput,
          }).toList(),
          'questions': lesson.questions.map((q) => _questionToMap(q)).toList(),
        };

        await _database.child('lessons/${lesson.id}').set(lessonData);
      }
      print('✅ Uploaded ${initialLessons.length} lessons.');

      // --- 3. UPLOAD FINAL QUIZ ---
      final finalQuizData = finalQuizQuestions.map((q) => _questionToMap(q)).toList();
      await _database.child('finalQuiz/questions').set(finalQuizData);
      print('✅ Uploaded ${finalQuizQuestions.length} final quiz questions');

      print('🎉 Data upload complete!');
    } catch (e) {
      print('❌ Error uploading data: $e');
      rethrow;
    }
  }

  /// Helper to convert Question to Map for Firebase
  Map<String, dynamic> _questionToMap(Question question) {
    final map = <String, dynamic>{
      'question': question.question,
      'type': question.type.toString().split('.').last,
      'correctAnswer': question.correctAnswer,
      'explanation': question.explanation,
    };

    if (question.options != null) {
      map['options'] = question.options;
    }

    if (question.matchingPairs != null) {
      map['matchingPairs'] = question.matchingPairs;
    }

    return map;
  }
}