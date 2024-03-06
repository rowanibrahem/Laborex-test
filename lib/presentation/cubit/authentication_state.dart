part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class LoggedIn extends AuthenticationState {
  const LoggedIn({
    required this.token,
  });

  final String token;

  @override
  List<Object> get props => [token];
}

final class LoggedOut extends AuthenticationState {}

final class Loading extends AuthenticationState {}
