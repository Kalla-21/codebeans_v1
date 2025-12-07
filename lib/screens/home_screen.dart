import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/lesson.dart';
import '../services/firebase_service.dart';
import '../data/user_data.dart'; // Import to access initialTestUsers

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  User? _currentUser;
  String _username = "Loading...";
  String _userBio = "Java Learner";
  String? _photoUrl;

  List<Lesson> lessons = [];
  bool isLoading = true;
  bool allLessonsCompleted = false;
  bool progressiveMode = true;
  bool _hasInitialized = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    setState(() => isLoading = true);

    try {
      _currentUser = FirebaseAuth.instance.currentUser;

      if (_currentUser == null) {
        setState(() => isLoading = false);
        return;
      }

      // 1. Fetch User Profile
      DataSnapshot userSnapshot = await _dbRef.child('users/${_currentUser!.uid}').get();

      // --- AUTO-REPAIR & UPLOAD LOGIC ---
      if (!userSnapshot.exists) {
        print("⚠️ Profile missing. Attempting to load data from user_data.dart...");
        try {
          // Find the matching test user by email
          final matchingUser = initialTestUsers.firstWhere(
                (u) => u.email.toLowerCase() == _currentUser!.email?.toLowerCase(),
            orElse: () => const TestUser(
                uid: '', email: '', password: '', username: 'New User', bio: 'Java Enthusiast', photoUrl: '', progress: {}),
          );

          if (matchingUser.username.isNotEmpty) {
            // Upload Profile Data
            await _dbRef.child('users/${_currentUser!.uid}').set({
              'username': matchingUser.username,
              'bio': matchingUser.bio,
              'email': matchingUser.email,
              'photoUrl': matchingUser.photoUrl,
            });

            // Upload Progress (Mark lessons as complete)
            if (matchingUser.progress.isNotEmpty) {
              await _dbRef.child('users/${_currentUser!.uid}/completedLessons').set(matchingUser.progress);
            }

            // Fetch fresh data
            userSnapshot = await _dbRef.child('users/${_currentUser!.uid}').get();
            print("✅ Auto-repair successful!");
          }
        } catch (e) {
          print("❌ Auto-repair failed: $e");
        }
      }
      // ----------------------------------

      if (userSnapshot.exists) {
        final userData = userSnapshot.value as Map<dynamic, dynamic>;
        setState(() {
          _username = userData['username'] ?? 'Learner';
          _userBio = userData['bio'] ?? 'Java Learner';
          _photoUrl = userData['photoUrl'];
        });
      } else {
        setState(() {
          _username = _currentUser!.displayName ?? 'Learner';
          _userBio = 'Ready to code!';
        });
      }

      // 2. Fetch Lessons & Progress
      //
      final fetchedLessons = await _firebaseService.fetchLessons();
      final completedLessonIds = await _firebaseService.getCompletedLessons(_currentUser!.uid);

      // --- CRITICAL FIX HERE ---
      // We use .map() to create a NEW list with the updated 'isCompleted' status.
      // The previous loop was modifying a local variable, not the list itself.
      final mergedLessons = fetchedLessons.map((lesson) {
        if (completedLessonIds.contains(lesson.id)) {
          return lesson.copyWith(isCompleted: true);
        }
        return lesson;
      }).toList();

      if (mounted) {
        setState(() {
          lessons = mergedLessons; // Use the updated list
          allLessonsCompleted = lessons.every((l) => l.isCompleted);
          isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Error initializing data: $e');
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args.containsKey('progressiveMode')) {
        progressiveMode = args['progressiveMode'] as bool;
      }
      _hasInitialized = true;
    }
  }

  Future<void> _markLessonComplete(int index) async {
    if (_currentUser == null) return;
    final lesson = lessons[index];

    // Save to Firebase
    await _firebaseService.markLessonComplete(_currentUser!.uid, lesson.id);

    // Update local UI immediately
    setState(() {
      lessons[index] = lesson.copyWith(isCompleted: true);
      allLessonsCompleted = lessons.every((l) => l.isCompleted);
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ ${lesson.title} completed!'), backgroundColor: Colors.green),
      );
    }
  }

  bool _isLessonAccessible(int index) {
    if (!progressiveMode) return true;
    if (index == 0) return true;
    return lessons[index - 1].isCompleted;
  }

  Future<void> _handleSignOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('CodeBeans'), backgroundColor: Colors.brown.shade700),
        body: Center(child: CircularProgressIndicator(color: Colors.brown.shade700)),
      );
    }

    final String initial = _username.isNotEmpty ? _username[0].toUpperCase() : 'U';

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Row(
          children: [Icon(Icons.coffee, size: 24), SizedBox(width: 8), Text('CodeBeans')],
        ),
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // --- HEADER ---
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
                      backgroundImage: (_photoUrl != null && _photoUrl!.isNotEmpty)
                          ? NetworkImage(_photoUrl!)
                          : null,
                      child: (_photoUrl == null || _photoUrl!.isEmpty)
                          ? Text(
                        initial,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade800,
                        ),
                      )
                          : null,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _currentUser?.email ?? '',
                      style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _userBio,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- DRAWER ITEMS ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.brown.shade200),
                ),
                child: SwitchListTile(
                  secondary: Icon(Icons.lock_clock, color: Colors.brown.shade700),
                  title: const Text('Progressive Mode', style: TextStyle(fontWeight: FontWeight.bold)),
                  value: progressiveMode,
                  activeColor: Colors.brown.shade700,
                  onChanged: (val) => setState(() => progressiveMode = val),
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings coming soon!')));
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
                  applicationIcon: const Icon(Icons.coffee, size: 50, color: Colors.brown),
                  children: const [Text('Brew your Java skills one bean at a time!')],
                );
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sign Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              onTap: _handleSignOut,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      body: Column(
        children: [
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
                  progressiveMode ? 'Progressive Mode On' : 'Full Access Mode',
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
            child: RefreshIndicator(
              onRefresh: _initializeData,
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
                        title: Text(lesson.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          lesson.isCompleted ? 'Completed' : lesson.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Icon(
                          isLocked ? Icons.lock : Icons.arrow_forward_ios,
                          size: 16,
                          color: isLocked ? Colors.grey : Colors.brown.shade700,
                        ),
                        onTap: isAccessible
                            ? () async {
                          final result = await Navigator.of(context).pushNamed(
                            '/lesson_detail',
                            arguments: {
                              'lesson': lesson,
                              'index': index,
                              'userId': _currentUser?.uid,
                            },
                          );
                          if (result == true) {
                            await _markLessonComplete(index);
                          }
                        }
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (allLessonsCompleted)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/final_quiz',
                    arguments: {'userId': _currentUser?.uid},
                  );
                },
                icon: const Icon(Icons.quiz, size: 28),
                label: const Text('Take Final Quiz', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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