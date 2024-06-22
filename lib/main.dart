import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/data/data%20source/cacheNetwork.dart';

import 'presentation/cubit/authentication_cubit.dart';
import 'presentation/cubit/delivery_orders_cubit.dart';
import 'presentation/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cachInstialization();
  accessToken= (await CacheNetwork.getCacheData(key: "access_token"))!;
  publicKey=(await CacheNetwork.getCacheData(key: "publicKey"))!;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(420, 960),
      child: MultiBlocProvider(
        providers: [
    BlocProvider(
                  create: (context) => AuthenticationCubit()
                ),
                BlocProvider(
                  create: (context) => DeliveryOrdersCubit(),
                ),


        ],
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
              secondary: const Color(0xFFF6F6F6),
              onSecondary: const Color(0xFF6AB187),
              tertiary: const Color(0xFFF6806E),

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
      ),
    );
  }
}
