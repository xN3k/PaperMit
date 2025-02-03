import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todos/core/secrets/supabase_secret.dart';
import 'package:todos/features/auth/data/datasources/auth_supabase_data_source.dart';
import 'package:todos/features/auth/domain/repository/auth_repository.dart';
import 'package:todos/features/auth/domain/usecases/user_sign_up.dart';
import 'package:todos/features/auth/presentation/bloc/auth_bloc.dart';

import 'features/auth/data/repositories/auth_repository_imp.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: SupabaseSecret.supabaseUrl,
    anonKey: SupabaseSecret.supabaseKey,
  );

  // supabase client
  serviceLocator.registerLazySingleton(
    () => supabase.client,
  );
}

void _initAuth() {
  // auth data source
  serviceLocator.registerFactory<AuthSupabaseDataSource>(
    () => AuthSupabaseDataSourceImp(
      serviceLocator(),
    ),
  );

  // auth repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImp(
      serviceLocator(),
    ),
  );

  // user signup usecase
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

  // auth bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
    ),
  );
}
