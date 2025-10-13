import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                  child: Icon(Icons.person, size: 80, color: Theme.of(context).colorScheme.onPrimary),
                ),
                const SizedBox(height: 24),
                Text('Mohamed Abdu', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 12),
                Text(
                  'Senior iOS Developer with a passion for creating clean, user-centric mobile applications. Currently exploring the world of Flutter & Dart.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
