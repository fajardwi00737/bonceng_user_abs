part of 'cuti_cubit.dart';

abstract class CutiState extends Equatable {
  const CutiState();

  @override
  List<Object> get props => [];
}

class CutiInitial extends CutiState {}

class CutiSucces extends CutiState{
  final String? msg;
  CutiSucces(this.msg);
// LoginSucces(this.userInfo);
//
// final DataUserModel userInfo;
//
// @override
// List<Object> get props => [userInfo];
}

class CutiLoading extends CutiState {
  const CutiLoading();
}

class CutiFailed extends CutiState {
  final String? msg;

  CutiFailed(this.msg);
}

class CutiError extends CutiState {
  final String? msg;

  CutiError({this.msg});
}
