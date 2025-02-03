import 'package:flutter/material.dart';
import 'package:todos/core/theme/theme.dart';
import 'package:todos/features/auth/presentation/pages/signin_page.dart';
import 'package:todos/features/auth/presentation/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodyList',
      theme: AppTheme.darkThemeMode,
      home: const SigninPage(),
    );
  }
}
