import 'package:flutter/material.dart';
import '../data/lesson_data.dart';
import '../models/lesson.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Lesson> lessons = List.from(initialLessons);
  bool allLessonsCompleted = false;
  bool progressiveMode = true;
  bool _hasInitialized = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get the mode from navigation arguments (only on first load)
    if (!_hasInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args.containsKey('progressiveMode')) {
        progressiveMode = args['progressiveMode'] as bool;
      }
      _hasInitialized = true;
    }
  }

  void _markLessonComplete(int index) {
    setState(() {
      lessons[index] = lessons[index].copyWith(isCompleted: true);

      // Check if all 5 lessons are completed
      allLessonsCompleted = lessons.every((lesson) => lesson.isCompleted);
    });
  }

  bool _isLessonAccessible(int index) {
    if (!progressiveMode) return true; // All unlocked in full access mode
    if (index == 0) return true;
    return lessons[index - 1].isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Row(
          children: [
            Icon(Icons.coffee, size: 24),
            SizedBox(width: 8),
            Text('CodeBeans - Course Map'),
          ],
        ),
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Drawer Header with User Profile
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.brown.shade700, Colors.brown.shade900],
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/icon/app_icon.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'NoobMaster69',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Java Learner',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Progressive Mode Toggle
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.brown.shade200),
                ),
                child: SwitchListTile(
                  secondary: Icon(
                    progressiveMode ? Icons.lock_clock : Icons.lock_open,
                    color: Colors.brown.shade700,
                  ),
                  title: const Text(
                    'Progressive Mode',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    progressiveMode
                        ? 'Lessons unlock sequentially'
                        : 'All lessons unlocked',
                    style: const TextStyle(fontSize: 12),
                  ),
                  value: progressiveMode,
                  activeColor: Colors.brown.shade700,
                  onChanged: (bool value) {
                    setState(() {
                      progressiveMode = value;
                    });
                  },
                ),
              ),
            ),

            const Divider(),

            // Menu Items
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings coming soon!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: 'CodeBeans',
                  applicationVersion: '1.0.0',
                  applicationIcon: Image.asset(
                    'assets/icon/app_icon.png',
                    width: 50,
                    height: 50,
                  ),
                  children: const [
                    Text('Brew your Java skills one bean at a time!'),
                  ],
                );
              },
            ),

            const Spacer(),

            // Progress Summary
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.analytics, color: Colors.green.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Progress',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${lessons.where((l) => l.isCompleted).length} / ${lessons.length} lessons',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Mode Indicator Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: progressiveMode ? Colors.orange.shade100 : Colors.green.shade100,
            child: Row(
              children: [
                Icon(
                  progressiveMode ? Icons.lock_clock : Icons.lock_open,
                  size: 16,
                  color: progressiveMode ? Colors.orange.shade700 : Colors.green.shade700,
                ),
                const SizedBox(width: 8),
                Text(
                  progressiveMode
                      ? 'Progressive Mode: Complete lessons in order'
                      : 'Full Access Mode: All lessons available',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: progressiveMode ? Colors.orange.shade700 : Colors.green.shade700,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                final lesson = lessons[index];
                final isAccessible = _isLessonAccessible(index);
                final isLocked = !isAccessible;

                return Opacity(
                  opacity: isLocked ? 0.5 : 1.0,
                  child: Card(
                    elevation: isLocked ? 1 : 3,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    color: lesson.isCompleted ? Colors.green.shade50 : null,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      leading: CircleAvatar(
                        backgroundColor: lesson.isCompleted
                            ? Colors.green.shade200
                            : isLocked
                            ? Colors.grey.shade300
                            : Colors.brown.shade200,
                        child: lesson.isCompleted
                            ? const Icon(Icons.check, color: Colors.green)
                            : isLocked
                            ? const Icon(Icons.lock, color: Colors.grey)
                            : Text('${index + 1}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown.shade700)),
                      ),
                      title: Text(
                        lesson.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 18,
                          color: isLocked ? Colors.grey : null,
                        ),
                      ),
                      subtitle: Text(
                        lesson.isCompleted
                            ? 'Completed ✓'
                            : isLocked
                            ? 'Complete previous lesson to unlock'
                            : lesson.description,
                        style: TextStyle(
                          color: lesson.isCompleted ? Colors.green : Colors.grey,
                        ),
                      ),
                      trailing: Icon(
                        isLocked ? Icons.lock : Icons.arrow_forward_ios,
                        size: 16,
                        color: isLocked ? Colors.grey : Colors.brown.shade700,
                      ),
                      onTap: isAccessible ? () async {
                        final result = await Navigator.of(context).pushNamed(
                          '/lesson_detail',
                          arguments: {'lesson': lesson, 'index': index},
                        );

                        if (result == true) {
                          _markLessonComplete(index);
                        }
                      } : null,
                    ),
                  ),
                );
              },
            ),
          ),

          // Final Quiz Button
          if (allLessonsCompleted)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/final_quiz');
                },
                icon: const Icon(Icons.quiz, size: 28),
                label: const Text(
                  'Take Final Quiz (25 Questions)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                  elevation: 8,
                ),
              ),
            ),
        ],
      ),
    );
  }
}