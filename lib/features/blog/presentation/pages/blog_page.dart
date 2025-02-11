import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/core/common/widgets/loader.dart';
import 'package:todos/core/extension/flushbar_extension.dart';
import 'package:todos/core/theme/app_palette.dart';
import 'package:todos/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:todos/features/blog/presentation/pages/add_post_screen.dart';
import 'package:todos/features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetch());
  }

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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            context.flushBarErrorMessage(message: state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogFetchSuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(
                  blog: blog,
                  color: index % 2 == 0
                      ? AppPalette.gradient1
                      : AppPalette.gradient2,
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
