part of 'inbox_cubit.dart';

abstract class InboxState extends Equatable{
  const InboxState();

  @override
  List<Object> get props => [];
}

class InboxInitial extends InboxState{}
class InboxLoading extends InboxState{}
class InboxSuccess extends InboxState{
  InboxSuccess(this.inboxList);

  final List<dynamic> inboxList;

  @override
  List<Object> get props => [inboxList];
}
class InboxFailed extends InboxState{
  const InboxFailed();

}
class InboxError extends InboxState{
  final String? msg;

  InboxError({this.msg});
}