import 'package:fpdart/src/either.dart';
import 'package:todos/core/error/exception.dart';
import 'package:todos/core/error/failure.dart';
import 'package:todos/features/auth/data/datasources/auth_supabase_data_source_repository.dart';
import 'package:todos/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthSupabaseDataSourceRepository remoteDataSource;

  const AuthRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final userId = await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
