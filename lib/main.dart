import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/core/theme/theme.dart';
import 'package:todos/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:todos/features/auth/presentation/pages/signin_page.dart';
import 'package:todos/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
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
