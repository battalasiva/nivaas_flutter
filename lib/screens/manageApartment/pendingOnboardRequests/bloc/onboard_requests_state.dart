part of 'onboard_requests_bloc.dart';

sealed class OnboardRequestsState extends Equatable {
  const OnboardRequestsState();
  
  @override
  List<Object> get props => [];
}

final class OnboardRequestsInitial extends OnboardRequestsState {}
class OnboardRequestsLoading extends OnboardRequestsState {}
class ApproveOnboardRequestsSuccess extends OnboardRequestsState {
  final int flatId, userId;

  ApproveOnboardRequestsSuccess({required this.flatId, required this.userId});
}
class RejectOnboardRequestsSuccess extends OnboardRequestsState {
  final int flatId, userId;

  RejectOnboardRequestsSuccess({required this.flatId, required this.userId});
}
class OnboardRequestsFailure extends OnboardRequestsState {
  final String errorMessage;

  OnboardRequestsFailure({required this.errorMessage});
}
