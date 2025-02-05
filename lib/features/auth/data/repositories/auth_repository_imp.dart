import 'package:fpdart/fpdart.dart';
import 'package:todos/core/error/exception.dart';
import 'package:todos/core/error/failure.dart';
import 'package:todos/features/auth/data/datasources/auth_supabase_data_source.dart';
import 'package:todos/features/auth/domain/entities/user.dart';
import 'package:todos/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthSupabaseDataSource remoteDataSource;

  const AuthRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
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
