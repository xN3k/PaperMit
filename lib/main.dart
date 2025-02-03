import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todos/core/secrets/supabase_secret.dart';
import 'package:todos/core/theme/theme.dart';
import 'package:todos/features/auth/data/datasources/auth_supabase_data_source_repository.dart';
import 'package:todos/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:todos/features/auth/domain/usecases/user_sign_up.dart';
import 'package:todos/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:todos/features/auth/presentation/pages/signin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: SupabaseSecret.supabaseUrl,
    anonKey: SupabaseSecret.supabaseKey,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignUp: UserSignUp(
            AuthRepositoryImp(
              AuthSupabaseDataSourceRepositoryImp(
                supabase.client,
              ),
            ),
          ),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodyList',
      theme: AppTheme.darkThemeMode,
      home: const SigninPage(),
    );
  }
}
