import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../widget/styling.dart';
import 'package:confetti/confetti.dart';

class LessonDetailScreen extends StatelessWidget {
  const LessonDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final lesson = data['lesson'] as Lesson;
    final index = data['index'] as int;

    // FIX: Calculate total tabs dynamically (Subtopics + 1 for Quiz)
    final int tabCount = lesson.subTopics.length + 1;

    return DefaultTabController(
      length: tabCount,
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
              // 1. Dynamically create a Tab for each subtopic
              ...lesson.subTopics.map((subTopic) => Tab(text: subTopic.title)),
              // 2. Add the Quiz Tab at the end
              const Tab(icon: Icon(Icons.quiz), text: 'Quiz'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 1. Dynamically create content for each subtopic
            ...lesson.subTopics.map((subTopic) => _buildSubTopicContent(context, subTopic)),
            // 2. Add the Quiz Tab View
            _QuizTab(lesson: lesson, lessonIndex: index),
          ],
        ),
      ),
    );
  }

  Widget _buildSubTopicContent(BuildContext context, SubTopic subTopic) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subTopic.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 20),
          buildStyledText(
            subTopic.content,
            defaultStyle: TextStyle(
              color: colorScheme.onBackground,
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 30),
          if (subTopic.runnableCode != null) ...[
            const Divider(),
            Text(
              "Try it out:",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 10),
            _CodeEditorWidget(
              code: subTopic.runnableCode!,
              expectedOutput: subTopic.expectedOutput,
            ),
          ],
        ],
      ),
    );
  }
}

// =========================================================
// WIDGET: Simple Online Compiler Simulation
// =========================================================
class _CodeEditorWidget extends StatefulWidget {
  final String code;
  final String? expectedOutput;

  const _CodeEditorWidget({required this.code, this.expectedOutput});

  @override
  State<_CodeEditorWidget> createState() => _CodeEditorWidgetState();
}

class _CodeEditorWidgetState extends State<_CodeEditorWidget> {
  String _output = "";
  bool _isRunning = false;

  void _runCode() async {
    setState(() {
      _isRunning = true;
      _output = "";
    });

    // Simulate network/compilation delay (1.5 seconds)
    await Future.delayed(const Duration(milliseconds: 1500));

    if (mounted) {
      setState(() {
        _isRunning = false;
        // Since we don't have a real backend, we show the expected output
        // defined in the lesson data.
        _output = widget.expectedOutput ?? "Code Executed Successfully.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // Dark editor background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header (File Name)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF252526),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: const Row(
              children: [
                Icon(Icons.code, color: Colors.blueAccent, size: 16),
                SizedBox(width: 8),
                Text("Main.java", style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),

          // Code Area
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.code,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Color(0xFFD4D4D4), // VS Code default text color
                fontSize: 14,
              ),
            ),
          ),

          // Run Button Area
          Container(
            padding: const EdgeInsets.all(8.0),
            color: const Color(0xFF252526),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _isRunning ? null : _runCode,
                icon: _isRunning
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.play_arrow, size: 18),
                label: Text(_isRunning ? "Compiling..." : "Run Code"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ),

          // Output Console
          if (_output.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Output:", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    _output,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: Colors.lightGreenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// =========================================================
// WIDGET: Quiz Tab (Existing Logic)
// =========================================================
class _QuizTab extends StatefulWidget {
  final Lesson lesson;
  final int lessonIndex;

  const _QuizTab({required this.lesson, required this.lessonIndex});

  @override
  State<_QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<_QuizTab> {
  late ConfettiController _confettiController;
  Map<String, String> userAnswers = {};
  bool quizSubmitted = false;
  double score = 0;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2), // Let the confetti fall for 2 seconds
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }
  void _submitQuiz() {
    double totalScore = 0;
    for (int i = 0; i < widget.lesson.questions.length; i++) {
      final question = widget.lesson.questions[i];
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
        totalScore += correctPairs / totalPairs; // fraction
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
      _confettiController.play();
    });
  }

  void _returnToLessons() {
    Navigator.of(context).pop(true); // Mark lesson as complete
  }

  @override
  Widget build(BuildContext context) {
    if (quizSubmitted) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
      SingleChildScrollView(
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
    'Score: ${score.toStringAsFixed(1)} / ${widget.lesson.questions.length}',
    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: 30),

    // Show all answers logic
    ...List.generate(widget.lesson.questions.length, (index) {
    final question = widget.lesson.questions[index];
    bool isMatching = question.type == QuestionType.matching;
    final matchingPairs = question.matchingPairs ?? {};

    final userMatchingList = <Widget>[];
    if (isMatching) {
    matchingPairs.forEach((left, right) {
    final userVal = userAnswers['${index}_$left'] ?? 'Not answered';
    userMatchingList.add(Row(
    children: [
    const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
    Expanded(child: Text('$left → $userVal', style: const TextStyle(fontStyle: FontStyle.italic))),
    ],
    ));
    userMatchingList.add(Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Text('Correct: $right', style: const TextStyle(color: Colors.green)),
    ));
    userMatchingList.add(const SizedBox(height: 8));
    });
    }
    final userAnswer = userAnswers[index.toString()] ?? 'Not answered';
    final isCorrect = isMatching
    ? matchingPairs.entries.every((entry) =>
    (userAnswers['${index}_${entry.key}'] ?? '').toLowerCase().trim() ==
    entry.value.toLowerCase().trim())
        : userAnswer.toLowerCase().trim() == question.correctAnswer.toLowerCase().trim();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
    margin: const EdgeInsets.only(bottom: 16),
    color: isCorrect
    ? (isDark
    ? colorScheme.surfaceVariant.withOpacity(0.4)
        : Colors.green.shade50)
        : (isDark
    ? colorScheme.errorContainer.withOpacity(0.45)
        : Colors.red.shade50),
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    Icon(
    isCorrect ? Icons.check_circle : Icons.cancel,
    color: isCorrect
    ? (isDark ? colorScheme.onSurface : Colors.green)
        : (isDark ? colorScheme.onErrorContainer : Colors.red),
    ),
    const SizedBox(width: 8),
    Expanded(
    child: Text(
    'Question ${index + 1}',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    color: colorScheme.onSurface,
    ),
    ),
    ),
    ],
    ),
    const SizedBox(height: 8),
    Text(
    question.question,
    style: TextStyle(
    fontWeight: FontWeight.bold,
    color: colorScheme.onSurface,
    ),
    ),
    const Divider(height: 20),
    if (isMatching) ...userMatchingList,
    if (!isMatching)
    Text(
    'Your answer: $userAnswer',
    style: TextStyle(
    fontStyle: FontStyle.italic,
    color: colorScheme.onSurfaceVariant,
    ),
    ),
    const SizedBox(height: 4),
    if (!isMatching)
    Text(
    'Correct answer: ${question.correctAnswer}',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    color: isDark ? colorScheme.tertiary : Colors.green,
    ),
    ),
    const SizedBox(height: 12),
    Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
    color: isDark
    ? colorScheme.surfaceVariant.withOpacity(0.7)
        : Colors.blue.shade50,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
    color: isDark
    ? colorScheme.outlineVariant
        : Colors.blue.shade200,
    ),
    ),
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Icon(
    Icons.lightbulb_outline,
    color: isDark ? colorScheme.primary : Colors.blue.shade700,
    size: 20,
    ),
    const SizedBox(width: 8),
    Expanded(
    child: Text(
    question.explanation,
    style: TextStyle(
    fontSize: 13,
    color: isDark
    ? colorScheme.onSurface
        : Colors.blue.shade900,
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
    ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive, // Fun explosion effect
            shouldLoop: false,
            numberOfParticles: 30, // More particles for a bigger celebration
            gravity: 0.1,
            emissionFrequency: 0.05,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
              Colors.yellow,
            ],
          ),
        ],
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      // Card background adapts to dark mode
      color: theme.brightness == Brightness.dark
          ? colorScheme.surfaceVariant
          : null,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress text uses onSurfaceVariant
            Text(
              'Question ${index + 1} of ${widget.lesson.questions.length}',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            // Question text uses onSurface + bold
            Text(
              question.question,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),

            // Question Type Logic (unchanged)
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
            else if (question.type == QuestionType.fillBlank ||
                question.type == QuestionType.identification)
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Type your answer here',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => userAnswers[index.toString()] = value,
              )
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
                                    items: (question.options ?? []).map((option) {
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