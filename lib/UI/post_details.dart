import 'package:flutter/material.dart';
import 'package:flutter_learning_1/models/post_model.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;

  const PostDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            Text(post.body, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
