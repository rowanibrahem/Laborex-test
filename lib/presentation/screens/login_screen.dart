import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laborex_distribution_app/presentation/screens/home_screen.dart';
import 'package:laborex_distribution_app/presentation/widgets/custom_form.dart';
import 'package:laborex_distribution_app/presentation/widgets/login_appbar.dart';

import '../cubit/authentication_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (listenerCtx, state) {
        if (state is LoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
        else if (state is ErrorOccurredState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.customError?.errorMessage ?? "حدث خطأ"),
            ),
          );
        }

      },
      child: const Scaffold(
        appBar: LoginAppBar(),
        body: Center(
          child: LoginForm(),
        ),
      ),
    );
  }
}




