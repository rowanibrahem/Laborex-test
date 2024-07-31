import 'package:flutter/material.dart';
import 'package:laborex_distribution_app/presentation/screens/home_screen.dart';
import 'package:laborex_distribution_app/presentation/screens/login_screen.dart';
import 'package:upgrader/upgrader.dart';

void buildNavigationAfterSplash(
  AsyncSnapshot<bool> snapshot,
  BuildContext context,
  int animationDuration,
) async {
  await Future.delayed(Duration.zero);

  if (snapshot.connectionState == ConnectionState.waiting) {
    await Future.delayed(Duration(milliseconds: animationDuration));
  }

  if (snapshot.data == false) {
    // if(accessToken.isEmpty || accessToken=='' || accessToken=='empty'){
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UpgradeAlert(
            showIgnore: false,
            showLater: false,
            upgrader: Upgrader(
                languageCode: "ar",
                messages: UpgraderMessages(code: 'ar'),
                countryCode: "EG"),
            child: const LoginScreen(),
          ),
        ),
      );
    }
  } else {
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UpgradeAlert(
            upgrader: Upgrader(
                languageCode: "ar",
                messages: UpgraderMessages(code: 'ar'),
                countryCode: "EG"),
            showIgnore: false,
            showLater: false,
            child: const HomeScreen(),
          ),
        ),
      );
    }
  }
}
