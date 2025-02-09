import 'package:flutter/material.dart';
import 'package:todos/features/blog/presentation/pages/add_post_screen.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddPostScreen.route());
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
    );
  }
}
