import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firebaseService = FirebaseService();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();

  bool _isLoading = true;
  bool _isSaving = false;
  User? _currentUser;

  // New: preset avatars
  final List<String> _avatarPaths = const [
    'assets/avatars/avatar1.png',
    'assets/avatars/avatar2.png',
    'assets/avatars/avatar3.png',
    'assets/avatars/avatar4.png',
    'assets/avatars/avatar5.png',
    'assets/avatars/avatar6.png',
  ];

  String? _selectedAvatar; // stores chosen path

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final data = await _firebaseService.getUserProfile(_currentUser!.uid);
      setState(() {
        _usernameController.text =
            data['username'] ?? _currentUser!.displayName ?? '';
        _bioController.text = data['bio'] ?? 'Java Learner';
        final currentPhoto = data['photoUrl'] as String? ?? '';
        _selectedAvatar =
        currentPhoto.isNotEmpty ? currentPhoto : _avatarPaths.first;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load profile: $e')),
      );
    }
  }

  Future<void> _saveProfile() async {
    if (_currentUser == null) return;
    final username = _usernameController.text.trim();
    final bio = _bioController.text.trim();

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username cannot be empty.')),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      await _firebaseService.updateUserProfile(
        _currentUser!.uid,
        username,
        bio.isEmpty ? 'Java Learner' : bio,
        photoUrl: _selectedAvatar, // <-- add this
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated.')),
      );
      Navigator.of(context).pop(true); // tells HomeScreen to refresh
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving profile: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.brown.shade700,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final String initial = _usernameController.text.isNotEmpty
        ? _usernameController.text[0].toUpperCase()
        : 'U';

    final hasAvatar = _selectedAvatar != null && _selectedAvatar!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.brown.shade100,
                backgroundImage:
                hasAvatar ? AssetImage(_selectedAvatar!) as ImageProvider : null,
                child: !hasAvatar
                    ? Text(
                  initial,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade800,
                  ),
                )
                    : null,
              ),
            ),
            const SizedBox(height: 16),

            // ↓↓↓ AVATAR PICKER GOES HERE ↓↓↓
            const Text(
              'Choose profile picture',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

// Scrollable grid of avatars
            GridView.builder(
              shrinkWrap: true,                     // let it size itself inside the column
              physics: const ClampingScrollPhysics(), // enable scrolling
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
                        color: isSelected
                            ? Colors.brown.shade700
                            : Colors.grey.shade300,
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
            const SizedBox(height: 16),

            // ↑↑↑ AVATAR PICKER ENDS HERE ↑↑↑

            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bioController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.info_outline),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isSaving ? null : _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: _isSaving
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text(
                'Save changes',
                style:
                TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
