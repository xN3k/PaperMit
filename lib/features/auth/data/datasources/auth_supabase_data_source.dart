import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todos/core/error/exception.dart';

abstract interface class AuthSupabaseDataSource {
  Future<String> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
}

class AuthSupabaseDataSourceImp implements AuthSupabaseDataSource {
  final SupabaseClient supabaseClient;
  const AuthSupabaseDataSourceImp(this.supabaseClient);

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );
      if (response.user == null) {
        throw ServerException("User is null");
      }
      return response.user!.id;
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signInWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }
}
