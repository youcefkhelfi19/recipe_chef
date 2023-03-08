part of 'auth_cubit.dart';

@immutable
abstract class AuthState { final bool isLoading;

const AuthState(this.isLoading);
}

class AuthInitial extends AuthState {
  const AuthInitial() : super(false);
}
class AuthLoading extends AuthState {
  const AuthLoading() : super(true);
}
class AuthSuccess extends AuthState {
  const AuthSuccess() : super(false);
}
class AuthFailed extends AuthState {
  final String errMsg;
  const AuthFailed({required this.errMsg}): super(false);
}