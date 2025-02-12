import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todos/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:todos/core/network/connection_checker.dart';
import 'package:todos/core/secrets/supabase_secret.dart';
import 'package:todos/features/auth/data/datasources/auth_supabase_data_source.dart';
import 'package:todos/features/auth/domain/repository/auth_repository.dart';
import 'package:todos/features/auth/domain/usecases/current_user.dart';
import 'package:todos/features/auth/domain/usecases/user_sign_in.dart';
import 'package:todos/features/auth/domain/usecases/user_sign_up.dart';
import 'package:todos/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:todos/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:todos/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:todos/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:todos/features/blog/domain/repositories/blog_repository.dart';
import 'package:todos/features/blog/domain/usecases/fetch_blog.dart';
import 'package:todos/features/blog/domain/usecases/upload_blog.dart';
import 'package:todos/features/blog/presentation/bloc/blog_bloc.dart';

import 'features/auth/data/repositories/auth_repository_imp.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: SupabaseSecret.supabaseUrl,
    anonKey: SupabaseSecret.supabaseKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  // supabase client
  serviceLocator.registerLazySingleton(
    () => supabase.client,
  );

  // Hive
  serviceLocator.registerLazySingleton(
    () => Hive.box(name: "blogs"),
  );

  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  // auth data source
  serviceLocator
    ..registerFactory<AuthSupabaseDataSource>(
      () => AuthSupabaseDataSourceImp(
        serviceLocator(),
      ),
    )

    // auth repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImp(
        serviceLocator(),
        serviceLocator(),
      ),
    )

    // usecase
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )

    // auth bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  // datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(
        serviceLocator(),
      ),
    )

    // repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )

    // usecase
    ..registerFactory(
      () => UploadBlog(serviceLocator()),
    )
    ..registerFactory(
      () => FetchBlog(
        serviceLocator(),
      ),
    )

    // bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        fetchBlog: serviceLocator(),
      ),
    );
}
