part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  final String? token;
  final CustomError? customError;

  const AuthenticationState({this.token,       this.customError,
  });

  @override
  List<Object> get props => [token??"" , customError??""];
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

class ErrorOccurredState extends AuthenticationState {
  const ErrorOccurredState({required super.customError});
}
