import 'package:flutter/material.dart';
import 'package:flutter_learning_1/UI/posts_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData.light(),
      themeMode: ThemeMode.system,
      home: const PostsListScreen(),
    );
  }
}
