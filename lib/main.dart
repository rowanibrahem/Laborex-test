import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_delivery_app/presentation/screens/home_screen.dart';
import 'package:laborex_delivery_app/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(420, 960),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'EG'),
        ],
        locale: const Locale('ar', 'EG'),
        theme: ThemeData(
          fontFamily: 'Cairo',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6AB187),
            primary: const Color(0xFF6AB187),
            onPrimary: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF6AB187),
            ),
          ),
          useMaterial3: true,
        ),
        // home: const LoginScreen(),
        // home: const HomeScreen(),
        home: const SplashScreen(),
      ),
    );
  }
}
