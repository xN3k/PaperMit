import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todos/core/error/exception.dart';
import 'package:todos/features/auth/data/models/user_model.dart';

abstract interface class AuthSupabaseDataSource {
  Session? get currentUserSession;
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentData();
}

class AuthSupabaseDataSourceImp implements AuthSupabaseDataSource {
  final SupabaseClient supabaseClient;
  const AuthSupabaseDataSourceImp(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  // login
  @override
  Future<UserModel> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerException("User is null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  // sign up
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
    } on AuthException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  // get user
  @override
  Future<UserModel?> getCurrentData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
        );
      }
      return null;
    } on PostgrestException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
