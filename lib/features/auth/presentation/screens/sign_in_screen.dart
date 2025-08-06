import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_green_button_widget.dart';
import '../../../app/pages/home/presentation/screen/home_screen.dart';
import '../provider/cubit/sign_in_cubit.dart';
import '../widgets/curved_container_widget.dart';
import '../widgets/custom_auth_input_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurvedContainerWidget(height: 400, title: 'Sign In'),
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
                          controller: TextEditingController(),
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
                          controller: TextEditingController(),
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
          ),
        ),
      ),
    );
  }
}