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
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',
          'Accept': 'application/json', // Tell the server we want JSON
    };

    print("Fetching data from $url with headers..."); // A print statement for debugging

    final response = await http.get(url, headers: headers);

    print("Received response with status code: ${response.statusCode}"); // Debugging


    if (response.statusCode == 200) {
      // 1. Check the Content-Type header from the server's response
      final contentType = response.headers['content-type'];
      
      // Using startsWith is robust, as it also matches 'application/json; charset=utf-8'
      if (contentType != null && contentType.startsWith('application/json')) {
        // 2. If it's JSON, parse it as usual
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((post) => Post.fromJson(post)).toList();
      } else {
        // 3. If it's not JSON, throw a specific error
        throw Exception('Invalid content type: Expected application/json but got ${contentType ?? 'none'}.');
      }
    } else {
      // Handle non-200 status codes as before
      throw Exception('Failed to load posts. Status code: ${response.statusCode}');
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
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.blue));
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load posts. Please try again.'));
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final isBookmarked = _bookmarkedPosts.contains(post.id);

                return ListTile(
                  title: Text(post.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailsScreen(post: post),
                      ),
                    );
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