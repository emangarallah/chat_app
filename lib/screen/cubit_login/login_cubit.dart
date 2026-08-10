import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(const LoginLoading());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // Pass the user email into LoginSuccess state
      emit(LoginSuccess(email: email.trim()));
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(const LoginFailure(errorMessage: 'User not found.'));
      } else if (ex.code == 'wrong-password') {
        emit(const LoginFailure(errorMessage: 'Wrong password.'));
      } else if (ex.code == 'invalid-credential') {
        emit(const LoginFailure(errorMessage: 'Invalid email or password.'));
      } else if (ex.code == 'invalid-email') {
        emit(const LoginFailure(errorMessage: 'Invalid email address format.'));
      } else if (ex.code == 'user-disabled') {
        emit(const LoginFailure(errorMessage: 'This account has been disabled.'));
      } else {
        emit(LoginFailure(errorMessage: ex.message ?? 'Authentication failed.'));
      }
    } catch (e) {
      emit(const LoginFailure(errorMessage: 'Something went wrong. Please try again.'));
    }
  }
}