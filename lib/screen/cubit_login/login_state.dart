import 'package:meta/meta.dart';

@immutable
sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginSuccess extends LoginState {
  final String email;
  const LoginSuccess({required this.email});
}

final class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure({required this.errorMessage});
}