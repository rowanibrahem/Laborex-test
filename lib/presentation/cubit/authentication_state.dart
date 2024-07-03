part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  final String? token;
  final String? tenantUUID;
  final CustomError? customError;

  const AuthenticationState({this.token,this.customError,this.tenantUUID,
  });

  @override
  List<Object> get props => [token??"" , customError??"",tenantUUID??0];
}

final class AuthenticationInitial extends AuthenticationState {}

final class LoggedIn extends AuthenticationState {
  const LoggedIn({
    required String newToken,
    required String tenantUUID,
    required int expiredAt,
  }) : super(token: newToken,tenantUUID: tenantUUID);

  @override
  List<Object> get props => [token!,tenantUUID!];
}

final class LoggedOut extends AuthenticationState {}

final class LoadingState extends AuthenticationState {}

class ErrorOccurredState extends AuthenticationState {
  const ErrorOccurredState({required super.customError});
}
