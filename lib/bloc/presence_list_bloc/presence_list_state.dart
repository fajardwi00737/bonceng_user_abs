part of 'presence_list_cubit.dart';

abstract class PresenceListState extends Equatable {
  const PresenceListState();

  @override
  List<Object> get props => [];
}

class PresenceListInitial extends PresenceListState {}

class PresenceListSucces extends PresenceListState{
  // const PresenceListSucces();
  PresenceListSucces(this.userInfo);

final List<dynamic> userInfo;

@override
List<Object> get props => [userInfo];
}

class PresenceListLoading extends PresenceListState {
  const PresenceListLoading();
}

class PresenceListFailed extends PresenceListState {
  const PresenceListFailed();
}

class PresenceListError extends PresenceListState {
  final String? msg;

  PresenceListError({this.msg});
}
