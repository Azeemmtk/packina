part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {
  const SignInState();
}

final class SignInInitial extends SignInState {
  const SignInInitial();
}

final class SignInSubmitting extends SignInState {
  const SignInSubmitting();
}

final class SignInSuccess extends SignInState {
  const SignInSuccess();
}

final class SignInError extends SignInState {
  final String? emailError;
  final String? passwordError;

  const SignInError({this.emailError, this.passwordError});
}