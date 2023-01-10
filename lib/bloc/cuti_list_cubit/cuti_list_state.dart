part of 'cuti_list_cubit.dart';

abstract class CutiListState extends Equatable {
  const CutiListState();

  @override
  List<Object> get props => [];
}

class CutiListInitial extends CutiListState {}

class CutiListSucces extends CutiListState{
  // const PresenceListSucces();
  CutiListSucces(this.userInfo);

  final List<dynamic> userInfo;

  @override
  List<Object> get props => [userInfo];
}

class CutiListLoading extends CutiListState {
  const CutiListLoading();
}

class CutiListFailed extends CutiListState {
  const CutiListFailed();
}

class CutiListError extends CutiListState {
  final String msg;

  CutiListError({this.msg});
}
