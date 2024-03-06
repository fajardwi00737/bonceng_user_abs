part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSucces extends LoginState{
  const LoginSucces();
// LoginSucces(this.userInfo);
//
// final DataUserModel userInfo;
//
// @override
// List<Object> get props => [userInfo];
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginFailed extends LoginState {
  final String? msg;

  LoginFailed(this.msg);
}

class LoginError extends LoginState {
  final String? msg;

  LoginError({this.msg});
}
