import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../app_state.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  String _email = '';
  String _password = '';

  void updateEmail(String email) {
    _email = email;
    emit(SignInInitial());
  }

  void updatePassword(String password) {
    _password = password;
    emit(SignInInitial());
  }

  void submit(BuildContext context) async {
    emit(SignInSubmitting());
    try {
      // Hardcoded admin credentials check
      const String hardcodedUsername = "admin";
      const String hardcodedPassword = "admin123";

      if (_email == hardcodedUsername && _password == hardcodedPassword) {
        emit(SignInSuccess());
      } else {
        emit(SignInError(
          emailError: _email != hardcodedUsername ? "Invalid username" : null,
          passwordError: _password != hardcodedPassword ? "Invalid password" : null,
        ));
      }
    } catch (e) {
      emit(SignInError(emailError: null, passwordError: e.toString()));
    }
  }
}