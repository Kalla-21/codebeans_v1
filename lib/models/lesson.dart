// ============================================
// FILE: lib/models/lesson.dart
// ============================================

import 'package:flutter/foundation.dart';

/// --- Question Type Enum ---
enum QuestionType {
  multipleChoice,
  fillBlank,
  identification,
  trueFalse,
  matching,
}

/// --- Lesson Model ---
class Lesson {
  final String id;
  final String title;
  final String description;
  final List<SubTopic> subTopics;
  final List<Question> questions;
  final bool isCompleted;

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.subTopics,
    required this.questions,
    this.isCompleted = false,
  });

  // ---------------------------------------------------------------------------
  // FACTORY: Creates a Lesson object from Firebase Data (Map)
  // ---------------------------------------------------------------------------
  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      subTopics: _parseSubTopics(map['subTopics']),
      questions: _parseQuestions(map['questions']),
      isCompleted: false, // Default false, updated by user progress later
    );
  }

  // Helper to parse SubTopics (handles List or Map format from Firebase)
  static List<SubTopic> _parseSubTopics(dynamic data) {
    if (data == null) return [];
    List<SubTopic> list = [];

    if (data is List) {
      for (var item in data) {
        if (item != null) list.add(SubTopic.fromMap(Map<String, dynamic>.from(item)));
      }
    } else if (data is Map) {
      data.forEach((k, v) {
        list.add(SubTopic.fromMap(Map<String, dynamic>.from(v)));
      });
    }
    return list;
  }

  // Helper to parse Questions (handles List or Map format from Firebase)
  static List<Question> _parseQuestions(dynamic data) {
    if (data == null) return [];
    List<Question> list = [];

    if (data is List) {
      for (var item in data) {
        if (item != null) list.add(Question.fromMap(Map<String, dynamic>.from(item)));
      }
    } else if (data is Map) {
      data.forEach((k, v) {
        list.add(Question.fromMap(Map<String, dynamic>.from(v)));
      });
    }
    return list;
  }

  // ---------------------------------------------------------------------------
  // TO MAP: Converts Lesson object to Map for Uploading
  // ---------------------------------------------------------------------------
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'subTopics': subTopics.map((x) => x.toMap()).toList(),
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  /// Method to create a new Lesson with updated fields
  Lesson copyWith({bool? isCompleted}) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      subTopics: subTopics,
      questions: questions,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

/// --- SubTopic Model ---
class SubTopic {
  final String title;
  final String content;
  final String? runnableCode;
  final String? expectedOutput;

  const SubTopic({
    required this.title,
    required this.content,
    this.runnableCode,
    this.expectedOutput,
  });

  factory SubTopic.fromMap(Map<String, dynamic> map) {
    return SubTopic(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      runnableCode: map['runnableCode'],
      expectedOutput: map['expectedOutput'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'runnableCode': runnableCode,
      'expectedOutput': expectedOutput,
    };
  }
}

/// --- Question Model ---
class Question {
  final String question;
  final QuestionType type;
  final List<String>? options;
  final String correctAnswer;
  final String explanation;
  final Map<String, String>? matchingPairs;

  const Question({
    required this.question,
    required this.type,
    this.options,
    required this.correctAnswer,
    required this.explanation,
    this.matchingPairs,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    // Handle Enum parsing from String
    QuestionType parsedType = QuestionType.multipleChoice;
    if (map['type'] != null) {
      try {
        parsedType = QuestionType.values.firstWhere(
                (e) => e.toString().split('.').last == map['type']
        );
      } catch (_) {}
    }

    return Question(
      question: map['question'] ?? '',
      type: parsedType,
      options: map['options'] != null ? List<String>.from(map['options']) : null,
      correctAnswer: map['correctAnswer'] ?? '',
      explanation: map['explanation'] ?? '',
      matchingPairs: map['matchingPairs'] != null
          ? Map<String, String>.from(map['matchingPairs'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'type': type.toString().split('.').last, // Store Enum as String
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'matchingPairs': matchingPairs,
    };
  }
}