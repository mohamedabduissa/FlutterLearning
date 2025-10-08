import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    // 3. Scaffold provides the basic screen structure.
    return Scaffold(
      backgroundColor: Colors.white,
      // 4. SafeArea ensures content is not blocked by system UI (status bar).
      body: SafeArea(
        // 5. This makes the content scrollable on small screens to prevent overflow.
        child: SingleChildScrollView(
          // 6. Padding adds space around all the content.
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              // 7. Align children to the center horizontally.
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(radius: 80, backgroundImage: NetworkImage('https://i.pravatar.cc/300')),
                const SizedBox(height: 24),
                const Text(
                  'Mohamed Abdu',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1a1a1a)),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Senior iOS Developer with a passion for creating clean, user-centric mobile applications. Currently exploring the world of Flutter & Dart.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5, // Line spacing
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
