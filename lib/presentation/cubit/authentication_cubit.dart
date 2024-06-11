import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laborex_distribution_app/data/data%20source/cacheNetwork.dart';
import 'package:laborex_distribution_app/data/data%20source/local_repo.dart';
import 'package:laborex_distribution_app/data/data%20source/remote_repo.dart';

import '../../core/errors/custom_error.dart';

part 'authentication_state.dart';


late String accessToken;
late String publicKey;
class AuthenticationCubit extends Cubit<AuthenticationState> {
  LocalRepo? localRepo;
  RemoteRepo? remoteRepo;
  AuthenticationCubit()
      : super(
          AuthenticationInitial(),
        );

  AuthenticationCubit.loggedIn({
    required this.token,
    required this.localRepo,
  }) : super(LoggedIn(
          newToken: token,
        ));

  AuthenticationCubit.loggedOut({
    required this.localRepo,
  }) : super(
          LoggedOut(),
        );

  String token = '';


  void errorHandled() {
    emit(
        LoggedOut(),
    );
  }

  void setDependencies(LocalRepo lRepo, RemoteRepo rRepo) {
    localRepo = lRepo;
    remoteRepo = rRepo;
  }

  Future<bool> isUserLoggedIn() async {
    if (token != '' && token.isNotEmpty) {
      return true;
    }

    token = await localRepo?.getToken() ?? '';
    if (token.isNotEmpty) {
      emit(LoggedIn(newToken: token));
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
    try
    {
      emit(LoadingState());

      final loginData=await remoteRepo!.login(
        phoneNumber,
        password,
      );
      await localRepo!.addToken(
        loginData['token'],
      );
      await CacheNetwork.insertToCashe(key: 'access_token', value: loginData['token']);
      await CacheNetwork.insertToCashe(key: 'publicKey', value: loginData['publicKey']);
      token = loginData['token'];
      accessToken = loginData['token'];
      publicKey = loginData['publicKey'];

      emit(
        LoggedIn(
          newToken:loginData['token'],

        ),
      );
    }
    catch (e) {
      if (e is CustomError) {

        emit(ErrorOccurredState(customError: e));

      }
        else{    emit(LoggedOut());

      rethrow;}
    }
  }

  Future<void> logOut() async {
    token = '';
    emit(LoggedOut());
    await localRepo?.deleteToken();
    accessToken='';
  }
}
