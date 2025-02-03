import 'package:flutter/material.dart';
import 'package:todos/core/theme/app_palette.dart';
import 'package:todos/features/auth/presentation/widgets/auth_button.dart';
import 'package:todos/features/auth/presentation/widgets/auth_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign Up.",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const AuthField(hintText: "Name"),
            const SizedBox(
              height: 15,
            ),
            const AuthField(hintText: "Email"),
            const SizedBox(
              height: 15,
            ),
            const AuthField(hintText: "Password"),
            const SizedBox(
              height: 20,
            ),
            const AuthButton(),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: "Sign In",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppPalette.gradient2,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
