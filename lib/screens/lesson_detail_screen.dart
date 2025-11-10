import 'package:flutter/material.dart';
import '../models/lesson.dart';

class LessonDetailScreen extends StatelessWidget {
  const LessonDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final lesson = data['lesson'] as Lesson;
    final index = data['index'] as int;

    return DefaultTabController(
      length: 4, // 3 subtopic tabs + 1 quiz tab
      child: Scaffold(
        appBar: AppBar(
          title: Text(lesson.title),
          backgroundColor: Colors.brown.shade700,
          foregroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: lesson.subTopics[0].title),
              Tab(text: lesson.subTopics[1].title),
              Tab(text: lesson.subTopics[2].title),
              const Tab(icon: Icon(Icons.quiz), text: 'Quiz'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Subtopic 1
            _buildSubTopicContent(lesson.subTopics[0]),
            // Subtopic 2
            _buildSubTopicContent(lesson.subTopics[1]),
            // Subtopic 3
            _buildSubTopicContent(lesson.subTopics[2]),
            // Quiz Tab
            _QuizTab(lesson: lesson, lessonIndex: index),
          ],
        ),
      ),
    );
  }

  Widget _buildSubTopicContent(SubTopic subTopic) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subTopic.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            subTopic.content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuizTab extends StatefulWidget {
  final Lesson lesson;
  final int lessonIndex;

  const _QuizTab({required this.lesson, required this.lessonIndex});

  @override
  State<_QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<_QuizTab> {
  Map<int, String> userAnswers = {};
  bool quizSubmitted = false;
  int score = 0;

  void _submitQuiz() {
    int correctCount = 0;
    for (int i = 0; i < widget.lesson.questions.length; i++) {
      final question = widget.lesson.questions[i];
      final userAnswer = userAnswers[i]?.toLowerCase().trim() ?? '';
      final correctAnswer = question.correctAnswer.toLowerCase().trim();

      if (userAnswer == correctAnswer) {
        correctCount++;
      }
    }

    setState(() {
      score = correctCount;
      quizSubmitted = true;
    });
  }

  void _returnToLessons() {
    Navigator.of(context).pop(true); // Mark lesson as complete
  }

  @override
  Widget build(BuildContext context) {
    if (quizSubmitted) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(
              score >= 4 ? Icons.emoji_events : Icons.thumbs_up_down,
              size: 100,
              color: score >= 4 ? Colors.amber : Colors.orange,
            ),
            const SizedBox(height: 20),
            Text(
              'Quiz Complete!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Score: $score / ${widget.lesson.questions.length}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Show all answers
            ...List.generate(widget.lesson.questions.length, (index) {
              final question = widget.lesson.questions[index];
              final userAnswer = userAnswers[index] ?? 'Not answered';
              final isCorrect = userAnswer.toLowerCase().trim() ==
                  question.correctAnswer.toLowerCase().trim();

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isCorrect ? Icons.check_circle : Icons.cancel,
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Question ${index + 1}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(question.question),
                      const Divider(height: 20),
                      Text(
                        'Your answer: $userAnswer',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Correct answer: ${question.correctAnswer}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.lightbulb_outline, color: Colors.blue.shade700, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                question.explanation,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _returnToLessons,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Complete Lesson',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Answer all ${widget.lesson.questions.length} questions',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          ...List.generate(widget.lesson.questions.length, (index) {
            final question = widget.lesson.questions[index];
            return _buildQuestionWidget(question, index);
          }),

          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: _submitQuiz,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Submit Quiz',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionWidget(Question question, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${index + 1}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              question.question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            if (question.type == QuestionType.multipleChoice)
              ...question.options!.map((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: userAnswers[index],
                  onChanged: (value) {
                    setState(() {
                      userAnswers[index] = value!;
                    });
                  },
                );
              }).toList()
            else if (question.type == QuestionType.fillBlank)
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Type your answer here',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  userAnswers[index] = value;
                },
              ),
          ],
        ),
      ),
    );
  }
}