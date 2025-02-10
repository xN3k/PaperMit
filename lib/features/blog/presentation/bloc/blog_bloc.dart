import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/core/usecase/usecase.dart';
import 'package:todos/features/blog/domain/entities/blog.dart';
import 'package:todos/features/blog/domain/usecases/fetch_blog.dart';
import 'package:todos/features/blog/domain/usecases/upload_blog.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final FetchBlog _fetchBlog;
  BlogBloc({
    required UploadBlog uploadBlog,
    required FetchBlog fetchBlog,
  })  : _uploadBlog = uploadBlog,
        _fetchBlog = fetchBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onPostUpload);
    on<BlogFetch>(_onBlogFetch);
  }

  void _onPostUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final response = await _uploadBlog(
      UploadBlogParams(
          posterId: event.posterId,
          title: event.title,
          content: event.content,
          image: event.image,
          topics: event.topics),
    );

    response.fold(
      (l) {
        print(l.message);
        emit(BlogFailure(l.message));
      },
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _onBlogFetch(BlogFetch event, Emitter<BlogState> emit) async {
    final response = await _fetchBlog(NoParams());

    response.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogFetchSuccess(r)),
    );
  }
}
