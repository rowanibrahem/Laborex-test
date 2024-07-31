import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laborex_distribution_app/presentation/cubit/authentication_cubit.dart';
import 'package:laborex_distribution_app/presentation/cubit/delivery_orders_cubit.dart';
import 'package:laborex_distribution_app/presentation/helpers/build_navigation_after_splash.dart';
import '../../data/data source/remote_repo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  //animation related variables
  late AnimationController _animationController;
  late Animation<double> _circleScaleAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  bool isAnimationFinished = false;
  var animationDuration = 3000;

  //*
  late RemoteRepo remoteRepo;

  // late LocalRepo _localRepo;
  late Dio dio;

  @override
  void initState() {
    super.initState();

    animationsImplementation();

    // _initLocalRepo();
  }

  // void _initLocalRepo() async {
  //   _prefs = await SecureSharedPref.getInstance();
  //   _localRepo = LocalRepo(
  //     secureSharedPreferences: _prefs,
  //   );
  // }

  void animationsImplementation() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: animationDuration),
      vsync: this,
    );

    _circleScaleAnimation = Tween<double>(begin: 0.0, end: 3.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceIn,
      ),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 0.7).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInExpo,
      ),
    );
    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInExpo,
      ),
    );

    // Start the animation instantly
    Timer(
      const Duration(milliseconds: 0),
      () => _animationController.forward(),
    );

    // Navigate to the next screen after the animation finishes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isAnimationFinished = true;
        // setState(() {});
        // TODO make sure doesn't navigate until animation finish
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> setDependencies(BuildContext ctx) async {
    // _localRepo = LocalRepo(secureSharedPreferences: _prefs);
    dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
    remoteRepo = RemoteRepo(
      dio,
    );
    if (ctx.mounted) {
      BlocProvider.of<AuthenticationCubit>(ctx).setDependencies(
          // _localRepo,
          remoteRepo);
      BlocProvider.of<DeliveryOrdersCubit>(ctx).setDependencies(remoteRepo);
    }
  }

  Future<bool> isLogged(BuildContext ctx) async {
//TODO Need revidsion
    final isLoggedIn =
        await BlocProvider.of<AuthenticationCubit>(ctx).isUserLoggedIn();

    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setDependencies(context).then(
        (value) => isLogged(context),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return _buildSplashScreen();
        } else {
          Future.delayed(Duration(milliseconds: animationDuration))
              .then((value) {
            buildNavigationAfterSplash(snapshot, context, animationDuration);
          });
        }
        return _buildSplashScreen();
      },
    );
  }

  Widget _buildSplashScreen() => Scaffold(
        backgroundColor: Colors.white, // Replace with your background color
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ScaleTransition(
                scale: _circleScaleAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(
                      context,
                    ).colorScheme.primary, // Replace with your circle color
                  ),
                ),
              ),
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _logoOpacityAnimation,
                  child: Image.asset(
                    'assets/splashPhoto.png',
                  ), // Replace with your logo image path
                ),
              ),
            ],
          ),
        ),
      );
}
