import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/core/usecase/usecase.dart';
import 'package:todos/features/auth/domain/entities/user.dart';
import 'package:todos/features/auth/domain/usecases/current_user.dart';
import 'package:todos/features/auth/domain/usecases/user_sign_in.dart';
import 'package:todos/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_onIsUserLoggedIn);
  }

  void _onIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _currentUser(NoParams());

    response.fold((l) => emit(AuthFailure(l.message)), (r) {
      print(r.email);
      emit(AuthSuccess(r));
    });
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignIn(UserSignInParams(
      email: event.email,
      password: event.password,
    ));

    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSuccess(r)),
    );
  }
}
