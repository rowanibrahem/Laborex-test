import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laborex_distribution_app/data/Repositories/local_repo.dart';
import 'package:secure_shared_preferences/secure_shared_preferences.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit.loggedIn(
    this.secureSharedPreferences,
    this.token,
  )   : localRepo = LocalRepo(secureSharedPreferences: secureSharedPreferences),
        super(LoggedIn(
          token: token,
        ));

  AuthenticationCubit.loggedOut(
    this.secureSharedPreferences,
  )   : localRepo = LocalRepo(secureSharedPreferences: secureSharedPreferences),
        super(
          LoggedOut(),
        );

  SecureSharedPref secureSharedPreferences;
  LocalRepo localRepo;

  String token = '';

  Future<bool> isUserLoggedIn() async {
    if (token != '' && token.isNotEmpty) {
      return true;
    }

    final isUserLoggedIn =
        await secureSharedPreferences.getBool('isUserLoggedIn');
    if (isUserLoggedIn != null && isUserLoggedIn) {
      localRepo.getToken().then((value) {
        token = value!;
      });
      emit(LoggedIn(token: token));
      return true;
    } else {
      emit(LoggedOut());
      return false;
    }
  }

  Future<void> logUserIn(
    String email,
    String password,
  ) async {
    //TODO: Implement login logic

    emit(
      const LoggedIn(
        token:
            'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiRFJJVkVSIiwidXNlcl9pZCI6MywidXNlcm5hbWUiOiJkcml2ZXIgMSIsImlzcyI6IkRNU19BUFAiLCJhdWQiOiJETVNfQURNSU5JU1RSQVRJT04iLCJzdWIiOiIwNDQ0NDQ0NDQ0NCIsImlhdCI6MTcwOTU1NzY4MSwiZXhwIjoxNzEyMTQ5NjgxfQ.6Vd8IBY3tJZZhbofzbM-4rMQ5KtZ8JLAJNMQrcnXzGI',
      ),
    );
  }

  Future<void> logUserOut() async {
    localRepo.deleteToken();
    emit(LoggedOut());
  }
}
