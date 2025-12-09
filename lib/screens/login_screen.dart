import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:confetti/confetti.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ConfettiController _confettiController;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  // A custom Path to paint stars.
  Path drawHeart(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (3.141592653589793 / 180.0);

    final path = Path();
    // Add heart shape path
    path.moveTo(0.5 * size.width, size.height * 0.35);
    path.cubicTo(0.2 * size.width, size.height * 0.1, -0.25 * size.width,
        size.height * 0.6, 0.5 * size.width, size.height);
    path.moveTo(0.5 * size.width, size.height * 0.35);
    path.cubicTo(0.8 * size.width, size.height * 0.1, 1.25 * size.width,
        size.height * 0.6, 0.5 * size.width, size.height);

    return path;
  }

  // New variable to track password visibility
  bool _obscurePassword = true;
  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1), // How long the confetti should fall
    );
  }

  @override
  void dispose() {
    _confettiController.dispose(); // <-- 3. Clean up the controller
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  // This function shows the dialog AFTER login succeeds
  void _showModeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must choose
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Choose Your Learning Path',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How would you like to learn today?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),

              // Progressive Mode Option
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(); // Close dialog
                  // Navigate to Home with Progressive Mode TRUE
                  Navigator.of(context).pushReplacementNamed(
                    '/lessons_list', // Matches your main.dart route
                    arguments: {'progressiveMode': true},
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.brown.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.lock_clock, color: Colors.brown.shade700, size: 32),
                    title: const Text(
                      'Progressive Mode',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                      'Unlock lessons in order.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Full Access Mode Option
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(); // Close dialog
                  // Navigate to Home with Progressive Mode FALSE
                  Navigator.of(context).pushReplacementNamed(
                    '/lessons_list',
                    arguments: {'progressiveMode': false},
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.brown.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.lock_open, color: Colors.brown.shade700, size: 32),
                    title: const Text(
                      'Full Access Mode',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                      'Access everything immediately.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _login() async {
    // Basic validation
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in both fields")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Attempt Firebase Login
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 1. Play the confetti animation!
      _confettiController.play();

      // 2. Wait for the animation to finish before navigating
      await Future.delayed(const Duration(seconds: 1));
      // 2. If successful, show the mode selection
      if (mounted) {
        _showModeSelectionDialog(context);
      }

    } on FirebaseAuthException catch (e) {
      String message = "Login failed";
      if (e.code == 'user-not-found') {
        message = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password provided.";
      } else if (e.code == 'invalid-email') {
        message = "The email address is badly formatted.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
            backgroundColor: Colors.brown.shade700,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView( // Added scroll view for smaller screens
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                const Icon(Icons.coffee, size: 80, color: Colors.brown),
                const SizedBox(height: 30),

                // Email Input
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  ),
                ),
                const SizedBox(height: 16),

                // Password Input (With Eye Icon)
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword, // Toggles visibility
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    // The Eye Icon Button
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Forgot Password Button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Enter your email first!")),
                        );
                      } else {
                        FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Password reset email sent!")),
                        );
                      }
                    },
                    child: const Text("Forgot Password?"),
                  ),
                ),

                const SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                  )
                      : const Text("Login", style: TextStyle(fontSize: 18)),
                ),

                const SizedBox(height: 20),

                // // Google Sign In (Placeholder)
                // OutlinedButton.icon(
                //   onPressed: () {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text("Google Sign-In requires extra setup (SHA-1).")),
                //     );
                //   },
                //   icon: const Icon(Icons.g_mobiledata, size: 28),
                //   label: const Text("Sign in with Google"),
                //   style: OutlinedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(vertical: 12),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Confetti Widget - this is invisible until we play it
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive, // Fun effect
          shouldLoop: false,
          colors: const [
            Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple
          ],
          emissionFrequency: 0.05,
          numberOfParticles: 20,
          gravity: 0.1,
        ),
      ]
    );

  }
}