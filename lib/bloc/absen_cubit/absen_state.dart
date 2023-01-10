part of 'absen_cubit.dart';

abstract class AbsenState extends Equatable {
  const AbsenState();

  @override
  List<Object> get props => [];
}

class AbsenInitial extends AbsenState {}

class AbsenSucces extends AbsenState{
  final String msg;
  AbsenSucces(this.msg);
// LoginSucces(this.userInfo);
//
// final DataUserModel userInfo;
//
// @override
// List<Object> get props => [userInfo];
}

class AbsenLoading extends AbsenState {
  const AbsenLoading();
}

class AbsenFailed extends AbsenState {
  final String msg;
  AbsenFailed(this.msg);
}

class AbsenError extends AbsenState {
  final String msg;

  AbsenError({this.msg});
}
