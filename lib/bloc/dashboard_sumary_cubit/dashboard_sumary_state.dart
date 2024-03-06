part of 'dashboard_sumary_cubit.dart';

abstract class DashboardSumaryState extends Equatable{
  const DashboardSumaryState();

  @override
  List<Object> get props => [];
}

class DashboardSumaryInitial extends DashboardSumaryState {}

class DashboardSumaryLoading extends DashboardSumaryState{}

class DashboardSumarySuccess extends DashboardSumaryState{
  DashboardSumarySuccess(this.dashboardInfo);

  final dynamic dashboardInfo;

  @override
  List<Object> get props => [dashboardInfo];
}

class DashboardSumaryFailed extends DashboardSumaryState {
  const DashboardSumaryFailed();
}

class DashboardSumaryError extends DashboardSumaryState {
  final String? msg;

  DashboardSumaryError({this.msg});
}