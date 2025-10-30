import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/app_user_provider.dart'; 
import 'UI/login_screen.dart';
import 'UI/home_screen.dart';

class Coordinator extends ConsumerWidget {
  const Coordinator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUserAsync = ref.watch(appUserProvider);

    return appUserAsync.when(
      data: (appUser) {
        if (appUser == null) {
          return LoginScreen();
        } else {
          return HomeScreen();
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}

