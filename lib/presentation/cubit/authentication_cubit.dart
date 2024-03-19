import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laborex_distribution_app/data/data%20source/local_repo.dart';
import 'package:laborex_distribution_app/data/data%20source/remote_repo.dart';

part 'authentication_state.dart';

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

  void setDependencies(LocalRepo lRepo ,RemoteRepo rRepo) {
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
    emit(LoadingState());

    // const hardcodedToken =
    //     "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiRFJJVkVSIiwidXNlcl9pZCI6MywidXNlcm5hbWUiOiJkcml2ZXIgMSIsImlzcyI6IkRNU19BUFAiLCJhdWQiOiJETVNfQURNSU5JU1RSQVRJT04iLCJzdWIiOiIwNDQ0NDQ0NDQ0NCIsImlhdCI6MTcwOTk3NjA1MSwiZXhwIjoxNzEyNTY4MDUxfQ.73L1cbcvXPsU8uccwBDP6qgOV-8VYi6yz3ZWfcrbdqs";
    // //   "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiRFJJVkVSIiwidXNlcl9pZCI6MywidXNlcm5hbWUiOiJkcml2ZXIgMSIsImlzcyI6IkRNU19BUFAiLCJhdWQiOiJETVNfQURNSU5JU1RSQVRJT04iLCJzdWIiOiIwNDQ0NDQ0NDQ0NCIsImlhdCI6MTcwOTU1NzY4MSwiZXhwIjoxNzEyMTQ5NjgxfQ.6Vd8IBY3tJZZhbofzbM-4rMQ5KtZ8JLAJNMQrcnXzGI";
    //TODO: Implement login logic

    final newToken = await remoteRepo!.login(
      phoneNumber,
      password,
    );

    await localRepo!.addToken(
      newToken,
    );

    token = newToken;

    emit(
      LoggedIn(
        newToken: newToken,
      ),
    );
  }

  Future<void> logOut() async {
    token = '';
    emit(LoggedOut());
    await localRepo?.deleteToken();
  }
}
