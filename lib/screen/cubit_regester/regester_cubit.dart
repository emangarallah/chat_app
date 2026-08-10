
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Regester_state.dart';



class RegesterCubit extends Cubit<RegesterState> {
  RegesterCubit() : super(const RegesterInitial());

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(const RegesterStateLoading());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // Pass the user email into LoginSuccess state
      emit(RegesterSuccess(email: email.trim()));
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(const RegesterFailure(errorMessage: 'User not found.'));
      } else if (ex.code == 'wrong-password') {
        emit(const RegesterFailure(errorMessage: 'Wrong password.'));
      } else if (ex.code == 'invalid-credential') {
        emit(const RegesterFailure(errorMessage: 'Invalid email or password.'));
      } else if (ex.code == 'invalid-email') {
        emit(const RegesterFailure(errorMessage: 'Invalid email address format.'));
      } else if (ex.code == 'user-disabled') {
        emit(const RegesterFailure(errorMessage: 'This account has been disabled.'));
      } else {
        emit(RegesterFailure(errorMessage: ex.message ?? 'Authentication failed.'));
      }
    } catch (e) {
      emit(const RegesterFailure(errorMessage: 'Something went wrong. Please try again.'));
    }
  }
}