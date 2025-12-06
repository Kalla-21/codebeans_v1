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

class SubTopic {
  final String title;
  final String content;
  const SubTopic({required this.title, required this.content});
}

enum QuestionType { multipleChoice, fillBlank, identification, trueFalse, matching }

class Question {
  final String question;
  final List<String>? options;           // For MCQ and matching options
  final String correctAnswer;            // For non-matching questions
  final String explanation;
  final QuestionType type;
  final Map<String, String>? matchingPairs; // For matching type

  const Question({
    required this.question,
    this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.type,
    this.matchingPairs,
  });
}
