import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../data/final_quiz_data.dart';

class FinalQuizScreen extends StatefulWidget {
  const FinalQuizScreen({super.key});

  @override
  State<FinalQuizScreen> createState() => _FinalQuizScreenState();
}

class _FinalQuizScreenState extends State<FinalQuizScreen> {
  final Map<String, String> userAnswers = {};
  bool quizSubmitted = false;
  double score = 0;
  final List<Question> allQuestions = [];

  @override
  void initState() {
    super.initState();
    // Flatten all lessons’ questions
    allQuestions.addAll(finalQuizQuestions);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Final Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (quizSubmitted)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Score: $score / ${allQuestions.length}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            if (quizSubmitted)
              Expanded(
                child: ListView.builder(
                  itemCount: allQuestions.length,
                  itemBuilder: (context, index) {
                    final question = allQuestions[index];
                    final isMatching = question.type == QuestionType.matching;
                    final matchingPairs = question.matchingPairs ?? {};

                    // Build list of user/answer pairs for matching
                    final userMatchingList = <Widget>[];
                    if (isMatching) {
                      matchingPairs.forEach((left, right) {
                        final userVal =
                            userAnswers['${index}_$left'] ?? 'Not answered';
                        userMatchingList.add(
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                                  TextSpan(
                                    text: '$left',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  const TextSpan(
                                      text: ' → ',
                                      style:
                                      TextStyle(fontStyle: FontStyle.normal)),
                                  TextSpan(
                                    text: userVal,
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                  TextSpan(
                                    text: '   (Correct: $right)',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    }

                    final userAnswer =
                        userAnswers[index.toString()] ?? 'Not answered';
                    final isCorrect = isMatching
                        ? matchingPairs.entries.every((entry) =>
                    (userAnswers['${index}_${entry.key}'] ?? '')
                        .toLowerCase()
                        .trim() ==
                        entry.value.toLowerCase().trim())
                        : userAnswer.toLowerCase().trim() ==
                        question.correctAnswer.toLowerCase().trim();

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      color: isCorrect
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  isCorrect
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: isCorrect
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Question ${index + 1}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(question.question,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const Divider(height: 20),
                            if (isMatching) ...userMatchingList,
                            if (!isMatching)
                              Text('Your answer: $userAnswer',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic)),
                            const SizedBox(height: 4),
                            if (!isMatching)
                              Text(
                                'Correct answer: ${question.correctAnswer}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            const SizedBox(height: 8),
                            if (question.explanation.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.blue.shade200),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.lightbulb_outline,
                                        color: Colors.blue.shade700, size: 20),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        question.explanation,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.blue.shade900),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (!quizSubmitted)
              Expanded(
                child: ListView.builder(
                  itemCount: allQuestions.length,
                  itemBuilder: (context, index) =>
                      _buildQuestionWidget(allQuestions[index], index),
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: quizSubmitted ? null : _submitQuiz,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitQuiz() {
    double totalScore = 0;
    for (int i = 0; i < allQuestions.length; i++) {
      final question = allQuestions[i];
      if (question.type == QuestionType.matching && question.matchingPairs != null) {
        int totalPairs = question.matchingPairs!.length;
        int correctPairs = 0;
        for (var entry in question.matchingPairs!.entries) {
          final userVal = userAnswers['${i}_${entry.key}'] ?? '';
          final correctVal = entry.value;
          if (userVal.toLowerCase().trim() == correctVal.toLowerCase().trim()) {
            correctPairs++;
          }
        }
        Text('Correct pairs: $correctPairs / $totalPairs');

    } else {
        final userAnswer = userAnswers[i.toString()]?.toLowerCase().trim() ?? '';
        final correctAnswer = question.correctAnswer.toLowerCase().trim();
        if (userAnswer == correctAnswer) {
          totalScore += 1;
        }
      }
    }
    setState(() {
      score = totalScore;
      quizSubmitted = true;
    });
  }


  Widget _buildQuestionWidget(Question question, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question ${index + 1} of ${allQuestions.length}'),
            Text(question.question),
            const SizedBox(height: 16),

            // Multiple Choice
            if (question.type == QuestionType.multipleChoice)
              ...question.options!.map((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: userAnswers[index.toString()],
                  onChanged: (value) =>
                      setState(() => userAnswers[index.toString()] = value!),
                );
              }).toList()

            // Fill in the Blank AND Identification
            else if (question.type == QuestionType.fillBlank ||
                question.type == QuestionType.identification)
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Type your answer here',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => userAnswers[index.toString()] = value,
              )

            // True or False
            else if (question.type == QuestionType.trueFalse)
                Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text('True'),
                      value: 'true',
                      groupValue: userAnswers[index.toString()],
                      onChanged: (value) =>
                          setState(() => userAnswers[index.toString()] = value!),
                    ),
                    RadioListTile<String>(
                      title: const Text('False'),
                      value: 'false',
                      groupValue: userAnswers[index.toString()],
                      onChanged: (value) =>
                          setState(() => userAnswers[index.toString()] = value!),
                    ),
                  ],
                )

              // Matching Type
              else if (question.type == QuestionType.matching)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (question.matchingPairs != null)
                        ...question.matchingPairs!.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(entry.key,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                    ),
                                    hint: const Text('Select answer'),
                                    value: userAnswers['${index}_${entry.key}'],
                                    items: (question.options ?? [])
                                        .map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        userAnswers['${index}_${entry.key}'] =
                                        value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
