import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packina/features/app/pages/home/presentation/screen/home_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../../core/widgets/custom_green_button_widget.dart';
import '../provider/cubit/sign_in_cubit.dart';
import '../widgets/curved_container_widget.dart';
import '../widgets/custom_auth_input_widget.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: Scaffold(
        backgroundColor: Color(0xFFE5F6F4),
        body: SingleChildScrollView(
          child: Center(
            child: kIsWeb
                ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 300, vertical: 60),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _buildSignInScreen(context),
              ),
            )
                : _buildSignInScreen(context),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInScreen(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CurvedContainerWidget(height: kIsWeb ? 200 : 400, title: 'Sign In'),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              BlocBuilder<SignInCubit, SignInState>(
                builder: (context, state) {
                  return CustomAuthInputWidget(
                    title: 'User name',
                    hint: 'Enter User name',
                    icon: CupertinoIcons.mail,
                    controller: _usernameController,
                    errorText: state is SignInError ? state.emailError : null,
                    onChanged: (value) {
                      context.read<SignInCubit>().updateEmail(value);
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<SignInCubit, SignInState>(
                builder: (context, state) {
                  return CustomAuthInputWidget(
                    title: 'Password',
                    hint: 'Enter password',
                    isSecure: true,
                    icon: CupertinoIcons.lock,
                    controller: _passwordController,
                    errorText: state is SignInError ? state.passwordError : null,
                    onChanged: (value) {
                      context.read<SignInCubit>().updatePassword(value);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocConsumer<SignInCubit, SignInState>(
                listener: (context, state) {
                  if (state is SignInSuccess) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                          (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  return CustomGreenButtonWidget(
                    name: 'Login',
                    onPressed: state is SignInSubmitting
                        ? null
                        : () => context.read<SignInCubit>().submit(context),
                    isLoading: state is SignInSubmitting,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}