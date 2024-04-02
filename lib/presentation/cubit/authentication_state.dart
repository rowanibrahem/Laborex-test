part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  final String? token;
 const AuthenticationState({this.token});

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class LoggedIn extends AuthenticationState {
  const LoggedIn({
    required String newToken,
  }) : super(token: newToken);

  @override
  List<Object> get props => [token!];
}

final class LoggedOut extends AuthenticationState {}

final class LoadingState extends AuthenticationState {}
