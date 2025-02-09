import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:todos/core/theme/app_palette.dart';
import 'package:todos/features/blog/presentation/widgets/blog_editor.dart';

class AddPostScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddPostScreen(),
      );
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _blogTitle = TextEditingController();
  final _blogContent = TextEditingController();
  List<String> selectedTopic = [];

  @override
  void dispose() {
    super.dispose();
    _blogTitle.dispose();
    _blogContent.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.done,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 20,
          children: [
            DottedBorder(
              color: AppPalette.borderColor,
              dashPattern: [10, 4],
              radius: const Radius.circular(10),
              borderType: BorderType.RRect,
              strokeCap: StrokeCap.round,
              child: Container(
                height: 140,
                width: double.infinity,
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: 50,
                    ),
                    Text(
                      "Select your image",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'Technology',
                  'Business',
                  'Programming',
                  'Arts',
                  'Flutter',
                ]
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (selectedTopic.contains(e)) {
                                selectedTopic.remove(e);
                              } else {
                                selectedTopic.add(e);
                              }
                              setState(() {});
                            },
                            child: Chip(
                              label: Text(e),
                              color: selectedTopic.contains(e)
                                  ? const WidgetStatePropertyAll(
                                      AppPalette.gradient1,
                                    )
                                  : null,
                              side: selectedTopic.contains(e)
                                  ? null
                                  : const BorderSide(
                                      color: AppPalette.borderColor,
                                    ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            BlogEditor(
              controller: _blogTitle,
              hintText: "Title",
            ),
            BlogEditor(
              controller: _blogContent,
              hintText: "Description",
            ),
          ],
        ),
      ),
    );
  }
}
