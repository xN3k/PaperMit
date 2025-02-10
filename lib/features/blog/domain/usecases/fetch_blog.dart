import 'package:fpdart/fpdart.dart';
import 'package:todos/core/error/failure.dart';
import 'package:todos/core/usecase/usecase.dart';
import 'package:todos/features/blog/domain/entities/blog.dart';
import 'package:todos/features/blog/domain/repositories/blog_repository.dart';

class FetchBlog implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  const FetchBlog(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.fetchBlog();
  }
}
