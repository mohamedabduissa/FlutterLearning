import 'package:flutter/material.dart';
import 'package:flutter_learning_1/models/post_model.dart';
import 'package:flutter_learning_1/UI/post_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostsListScreen extends StatefulWidget {
  const PostsListScreen({super.key});

  @override
  State<PostsListScreen> createState() => _PostsListScreenState();
}

class _PostsListScreenState extends State<PostsListScreen> {
  late Future<List<Post>> _futurePosts;
  final Set<int> _bookmarkedPosts = {};

  Future<List<Post>> fetchPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    // Keep the User-Agent header to avoid 403 Forbidden errors
    final headers = {
      'Accept': 'application/json', // Tell the server we want JSON
    };
    try {
      final response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((post) => Post.fromJson(post)).toList();
      } else {
        // Handle non-200 status codes as before
        throw Exception('Failed to load posts. Status code: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Network client error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Posts')),
      body: FutureBuilder<List<Post>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).colorScheme.scrim));
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Failed to load posts. Please try again.'),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () => setState(() {
                      _futurePosts = fetchPosts();
                    }),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final isBookmarked = _bookmarkedPosts.contains(post.id);

                return ListTile(
                  title: Text(post.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(post.body, maxLines: 1, overflow: TextOverflow.ellipsis),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsScreen(post: post)));
                  },
                  trailing: IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? Colors.blue : null,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isBookmarked) {
                          _bookmarkedPosts.remove(post.id);
                        } else {
                          _bookmarkedPosts.add(post.id);
                        }
                      });
                    },
                  ),
                );
              },
            );
          }
          return Center(child: Text('No posts found.'));
        },
      ),
    );
  }
}
