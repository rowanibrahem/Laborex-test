import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laborex_distribution_app/data/data%20source/cacheNetwork.dart';
import 'package:laborex_distribution_app/data/data%20source/remote_repo.dart';

import '../../core/errors/custom_error.dart';

part 'authentication_state.dart';

late String accessToken;
late String publicKey;

class AuthenticationCubit extends Cubit<AuthenticationState> {
  // LocalRepo? localRepo;
  RemoteRepo? remoteRepo;

  AuthenticationCubit()
      : super(
          AuthenticationInitial(),
        );

  AuthenticationCubit.loggedIn({
    required this.tenantUUID,
    required this.expirationDateInMilliseconds,
    required this.token,
    // required this.localRepo,
  }) : super(LoggedIn(
          newToken: token,
          tenantUUID: tenantUUID,
          expiredAt: expirationDateInMilliseconds,
        ));

  AuthenticationCubit.loggedOut(// {
      // required this.localRepo,
      // }
      )
      : super(
          LoggedOut(),
        );

  String token = '';
  String tenantUUID = '';
  int expirationDateInMilliseconds = 0;

  void errorHandled() {
    emit(
      LoggedOut(),
    );
  }

  void setDependencies(
      // LocalRepo lRepo,
      RemoteRepo rRepo) {
    // localRepo = lRepo;
    remoteRepo = rRepo;
  }

  bool isUserExpired(int expirationDate) {
    return expirationDate==0 || expirationDate < DateTime.now().millisecond;
  }

  Future<bool> isUserLoggedIn() async {
    // if (token != '' && token.isNotEmpty) {
    //   return true;
    // }

    token = await CacheNetwork.getStringCacheData(key: 'access_token') ?? '';
    tenantUUID = await CacheNetwork.getStringCacheData(key: 'tenantUUID') ?? '';
    expirationDateInMilliseconds =
        await CacheNetwork.getIntCacheData(key: 'expiredAt') ?? 0;

    final bool isUserExpiredVal=isUserExpired(expirationDateInMilliseconds);
    if (token.isNotEmpty && token != ''&& !isUserExpiredVal) {
      emit(LoggedIn(
          newToken: token,
          tenantUUID: tenantUUID,
          expiredAt: expirationDateInMilliseconds));
      return true;
    } else {
      emit(LoggedOut());
      return false;
    }
  }

  Future<void> logUserIn(
    String phoneNumber,
    String password,
  ) async {
    try {
      emit(LoadingState());

      final loginData = await remoteRepo!.login(
        phoneNumber,
        password,
      );
      await CacheNetwork.insertStringToCache(
          key: 'access_token', value: loginData['token']);
      await CacheNetwork.insertStringToCache(
          key: 'publicKey', value: loginData['publicKey']);
      await CacheNetwork.insertStringToCache(
          key: 'tenantUUID', value: loginData['tenantUUID']);
      await CacheNetwork.insertIntToCache(
          key: 'expiredAt', value: loginData['expiredAt']);
      token = loginData['token'];
      accessToken = loginData['token'];
      publicKey = loginData['publicKey'];
      tenantUUID = loginData['tenantUUID'];
      expirationDateInMilliseconds = loginData['expiredAt'];

      isUserExpired(expirationDateInMilliseconds)
          ? emit(LoggedOut())
          : emit(
              LoggedIn(
                newToken: loginData['token'],
                tenantUUID: tenantUUID,
                expiredAt: expirationDateInMilliseconds,
              ),
            );
    } catch (e) {
      if (e is CustomError) {
        log(e.errorMessage);
        emit(ErrorOccurredState(customError: e));
      } else {
        emit(LoggedOut());

        rethrow;
      }
    }
  }

  Future<void> logOut() async {
    token = '';
    tenantUUID = '';
    expirationDateInMilliseconds = 0;
    emit(LoggedOut());
    await CacheNetwork.deleteCacheData(key: 'access_token');
    await CacheNetwork.deleteCacheData(key: 'publicKey');
    await CacheNetwork.deleteCacheData(key: 'tenantUUID');
    await CacheNetwork.deleteCacheData(key: 'expiredAt');
    accessToken = '';
    publicKey = '';
  }
}
