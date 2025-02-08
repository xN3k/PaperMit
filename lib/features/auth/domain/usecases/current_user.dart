import 'package:fpdart/fpdart.dart';
import 'package:todos/core/error/failure.dart';
import 'package:todos/core/usecase/usecase.dart';
import 'package:todos/features/auth/domain/entities/user.dart';
import 'package:todos/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  const CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
