import 'package:fpdart/fpdart.dart';
import 'package:todos/core/error/failure.dart';
import 'package:todos/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
