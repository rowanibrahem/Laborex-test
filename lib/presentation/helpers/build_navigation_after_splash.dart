import 'package:flutter/material.dart';
import 'package:laborex_distribution_app/presentation/cubit/authentication_cubit.dart';
import 'package:laborex_distribution_app/presentation/screens/home_screen.dart';
import 'package:laborex_distribution_app/presentation/screens/login_screen.dart';

void buildNavigationAfterSplash(
  AsyncSnapshot<bool> snapshot,
  BuildContext context,
  int animationDuration,
) async {
  await Future.delayed(Duration.zero);

  if (snapshot.connectionState == ConnectionState.waiting) {
    await Future.delayed(Duration(milliseconds: animationDuration));
  }

  // if (snapshot.data == false) {
  if(accessToken.isEmpty || accessToken=='' || accessToken=='empty'){
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  } else {
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }
}
