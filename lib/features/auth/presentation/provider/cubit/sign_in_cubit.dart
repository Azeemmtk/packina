import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/validators.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInInitial());

  String _email = '';
  String _password = '';

  void updateEmail(String email) {
    _email = email;
    _validate();
  }

  void updatePassword(String password) {
    _password = password;
    _validate();
  }

  void _validate() {
    final emailError = Validation.validateName(_email);
    final passwordError = Validation.validatePassword(_password);
    emit(SignInError(emailError: emailError, passwordError: passwordError));
  }

  void submit(BuildContext context) {
    final emailError = Validation.validateName(_email);
    final passwordError = Validation.validatePassword(_password);

    if (emailError == null && passwordError == null) {
      if (_email == 'admin123' && _password == '123456') {
        emit(const SignInSubmitting());
        Future.delayed(const Duration(seconds: 1), () {
          emit(const SignInSuccess());
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email or password is incorrect'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
        emit(const SignInError(emailError: 'Invalid credentials', passwordError: 'Invalid credentials'));
      }
    } else {
      emit(SignInError(emailError: emailError, passwordError: passwordError));
    }
  }
}