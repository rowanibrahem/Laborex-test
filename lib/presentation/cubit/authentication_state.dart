part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  String? token;
  AuthenticationState({this.token});

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class LoggedIn extends AuthenticationState {
  LoggedIn({
    required String newToken,
  }) : super(token: newToken);

  @override
  List<Object> get props => [token!];
}

final class LoggedOut extends AuthenticationState {}

final class LoadingState extends AuthenticationState {}
