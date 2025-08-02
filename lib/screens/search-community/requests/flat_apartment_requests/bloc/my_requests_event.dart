part of 'my_requests_bloc.dart';

sealed class MyRequestsEvent extends Equatable {
  const MyRequestsEvent();

  @override
  List<Object> get props => [];
}

final class FetchMyRequestsEvent extends MyRequestsEvent {
  final String type; 

  const FetchMyRequestsEvent(this.type);

  @override
  List<Object> get props => [type];
}

class RemaindRequestCallEvent extends MyRequestsEvent {
  final String apartmentId;
  final String flatId;
  final String onboardingId;

  const RemaindRequestCallEvent({
    required this.apartmentId,
    required this.flatId,
    required this.onboardingId,
  });

  @override
  List<Object> get props => [apartmentId, flatId, onboardingId];
}
