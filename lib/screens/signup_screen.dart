import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();

  // preset avatars – same as ProfileScreen
  final List<String> _avatarPaths = const [
    'assets/avatars/avatar1.png',
    'assets/avatars/avatar2.png',
    'assets/avatars/avatar3.png',
    'assets/avatars/avatar4.png',
    'assets/avatars/avatar5.png',
    'assets/avatars/avatar6.png',
  ];

  String? _selectedAvatar;

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _selectedAvatar = _avatarPaths.first; // default avatar
  }

  // --- REUSED: Mode Selection Dialog ---
  void _showModeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Welcome to CodeBeans!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Account created successfully!'),
              const SizedBox(height: 10),
              const Text(
                'How would you like to learn?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Progressive
              ListTile(
                leading: Icon(Icons.lock_clock, color: Colors.brown.shade700),
                title: const Text('Progressive Mode'),
                subtitle: const Text('Unlock lessons in order'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/lessons_list',
                        (route) => false,
                    arguments: {'progressiveMode': true},
                  );
                },
              ),

              // Full Access
              ListTile(
                leading: Icon(Icons.lock_open, color: Colors.brown.shade700),
                title: const Text('Full Access Mode'),
                subtitle: const Text('Everything open immediately'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/lessons_list',
                        (route) => false,
                    arguments: {'progressiveMode': false},
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _signUp() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _firebaseService.createUserAndProfile(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _usernameController.text.trim(),
        _bioController.text.trim().isEmpty
            ? 'Ready to code!'
            : _bioController.text.trim(),
        photoUrl: _selectedAvatar ?? _avatarPaths.first, // ← send avatar
      );

      if (mounted) {
        _showModeSelectionDialog(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.person_add, size: 60, color: Colors.brown),
            const SizedBox(height: 20),

            //Profile Picture
            const SizedBox(height: 16),
            const Text(
              'Choose profile picture',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: _avatarPaths.length,
              itemBuilder: (context, index) {
                final path = _avatarPaths[index];
                final isSelected = path == _selectedAvatar;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAvatar = path;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.brown.shade700 : Colors.grey.shade300,
                        width: isSelected ? 3 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(path, fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),

            // Username
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username (Required)',
                prefixIcon: const Icon(Icons.person),
                border: const OutlineInputBorder(),
                hintText: 'e.g. JavaMaster99',
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
              ),
            ),
            const SizedBox(height: 16),

            // Bio
            TextField(
              controller: _bioController,
              decoration: InputDecoration(
                labelText: 'Bio (Optional)',
                prefixIcon: const Icon(Icons.info_outline),
                border: const OutlineInputBorder(),
                hintText: 'Tell us about yourself...',
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
              ),
            ),
            const SizedBox(height: 16),

            // Email
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email (Required)',
                prefixIcon: const Icon(Icons.email),
                border: const OutlineInputBorder(),
                hintText: 'user@example.com',
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
              ),
            ),
            const SizedBox(height: 16),

            // Password
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password (Required)',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                hintText: 'Min. 6 characters',
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Sign Up Button
            ElevatedButton(
              onPressed: _isLoading ? null : _signUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const SizedBox(
                  height: 20, width: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text("Sign Up", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}