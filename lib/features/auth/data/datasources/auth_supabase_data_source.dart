import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todos/core/error/exception.dart';
import 'package:todos/features/auth/data/models/user_model.dart';

abstract interface class AuthSupabaseDataSource {
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
}

class AuthSupabaseDataSourceImp implements AuthSupabaseDataSource {
  final SupabaseClient supabaseClient;
  const AuthSupabaseDataSourceImp(this.supabaseClient);

  @override
  Future<UserModel> signUpWithEmailPassword({
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
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signInWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }
}
