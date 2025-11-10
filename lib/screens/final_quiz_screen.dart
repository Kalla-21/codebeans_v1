import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../data/lesson_data.dart';

class FinalQuizScreen extends StatefulWidget {
  const FinalQuizScreen({super.key});

  @override
  State<FinalQuizScreen> createState() => _FinalQuizScreenState();
}

class _FinalQuizScreenState extends State<FinalQuizScreen> {
  Map<int, String> userAnswers = {};
  bool quizSubmitted = false;
  int score = 0;
  List<Question> allQuestions = [];

  @override
  void initState() {
    super.initState();
    // Combine all questions from all 5 lessons
    for (var lesson in initialLessons) {
      allQuestions.addAll(lesson.questions);
    }
  }

  void _submitQuiz() {
    int correctCount = 0;
    for (int i = 0; i < allQuestions.length; i++) {
      final question = allQuestions[i];
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

  @override
  Widget build(BuildContext context) {
    if (quizSubmitted) {
      final percentage = (score / allQuestions.length * 100).toStringAsFixed(1);
      final passed = score >= 20; // 80% to pass

      return Scaffold(
        appBar: AppBar(
          title: const Text('Final Quiz - Results'),
          backgroundColor: Colors.amber.shade700,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Icon(
                passed ? Icons.emoji_events : Icons.trending_up,
                size: 120,
                color: passed ? Colors.amber : Colors.orange,
              ),
              const SizedBox(height: 20),
              Text(
                passed ? 'Congratulations!' : 'Keep Practicing!',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Final Score: $score / ${allQuestions.length}',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 24,
                  color: passed ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Show all answers
              ...List.generate(allQuestions.length, (index) {
                final question = allQuestions[index];
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
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Return to Course Map',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Quiz - 25 Questions'),
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.amber),
                      SizedBox(width: 8),
                      Text(
                        'Final Assessment',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This quiz covers all topics from the 5 lessons. Answer all 25 questions to complete your CodeBeans journey!',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            ...List.generate(allQuestions.length, (index) {
              final question = allQuestions[index];
              return _buildQuestionWidget(question, index);
            }),

            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _submitQuiz,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Submit Final Quiz',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
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
              'Question ${index + 1} of ${allQuestions.length}',
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