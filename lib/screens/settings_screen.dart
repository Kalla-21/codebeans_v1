import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final bool initialProgressiveMode;
  final bool initialDarkMode;
  final void Function(bool isDark) onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.initialProgressiveMode,
    required this.initialDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _progressiveMode = true;
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _progressiveMode = widget.initialProgressiveMode;
    _darkMode = widget.initialDarkMode;
  }


  void _saveAndClose() {
    widget.onThemeChanged(_darkMode);  // apply theme based on final value
    Navigator.of(context).pop({
      'progressiveMode': _progressiveMode,
      'darkMode': _darkMode,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _saveAndClose,
            child: const Text('Save',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: ListView(
        children: [
          SwitchListTile(
            secondary: Icon(Icons.lock_clock, color: Colors.brown.shade700),
            title: const Text('Progressive Mode'),
            subtitle: const Text('Unlock lessons in order'),
            value: _progressiveMode,
            activeColor: Colors.brown.shade700,
            onChanged: (v) => setState(() => _progressiveMode = v),
          ),
          SwitchListTile(
            secondary: Icon(Icons.dark_mode, color: Colors.brown.shade700),
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme'),
            value: _darkMode,
            activeColor: Colors.brown.shade700,
            onChanged: (v) {
              setState(() => _darkMode = v);
            },
          ),
        ],
      ),
    );
  }
}
