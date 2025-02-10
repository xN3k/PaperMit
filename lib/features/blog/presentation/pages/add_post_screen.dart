import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:todos/core/common/widgets/loader.dart';
import 'package:todos/core/extension/flushbar_extension.dart';
import 'package:todos/core/theme/app_palette.dart';
import 'package:todos/core/utils/pick_image.dart';
import 'package:todos/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:todos/features/blog/presentation/pages/blog_page.dart';
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
  final blogTitle = TextEditingController();
  final blogContent = TextEditingController();
  List<String> selectedTopic = [];
  File? image;
  final formKey = GlobalKey<FormState>();

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadSubmit() {
    final posterId =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    if (formKey.currentState!.validate() &&
        selectedTopic.isNotEmpty &&
        image != null) {
      context.read<BlogBloc>().add(
            BlogUpload(
              posterId: posterId,
              title: blogTitle.text.trim(),
              content: blogContent.text.trim(),
              image: image!,
              topics: selectedTopic,
            ),
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    blogTitle.dispose();
    blogContent.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              uploadSubmit();
            },
            icon: Icon(
              Icons.done,
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            context.flushBarErrorMessage(message: state.error);
          } else if (state is BlogUploadSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              BlogPage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
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
                      controller: blogTitle,
                      hintText: "Title",
                    ),
                    BlogEditor(
                      controller: blogContent,
                      hintText: "Description",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
