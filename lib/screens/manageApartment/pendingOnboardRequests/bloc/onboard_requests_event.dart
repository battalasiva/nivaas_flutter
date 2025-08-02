part of 'onboard_requests_bloc.dart';

sealed class OnboardRequestsEvent extends Equatable {
  const OnboardRequestsEvent();

  @override
  List<Object> get props => [];
}
class ApproveRequestEvent extends OnboardRequestsEvent{
  final int id;
  final String? type;
  final String role;
  final String? relatedType;
  final int? relatedRequestId;
  final int flatId, userId;

  ApproveRequestEvent({
    required this.id, this.type, required this.role, this.relatedType, this.relatedRequestId,
    required this.flatId, required this.userId
  });
}

class RejectOnboardRequestEvent extends OnboardRequestsEvent {
  final int id;
  final int userId;
  final int flatId;

  RejectOnboardRequestEvent({required this.id, required this.userId, required this.flatId});
}