part of 'my_requests_bloc.dart';

sealed class MyRequestsState extends Equatable {
  const MyRequestsState();

  @override
  List<Object> get props => [];
}

final class MyRequestsInitial extends MyRequestsState {}

final class MyRequestsLoading extends MyRequestsState {}

final class MyRequestsLoaded extends MyRequestsState {
  final List<MyRequestModal> myRequests;

  const MyRequestsLoaded(this.myRequests);

  @override
  List<Object> get props => [myRequests];
}

final class MyRequestsError extends MyRequestsState {
  final String message;

  const MyRequestsError(this.message);

  @override
  List<Object> get props => [message];
}

class RemaindRequestInitial extends MyRequestsState {}
class RemaindRequestLoading extends MyRequestsState {
  final String? flatId;
  const RemaindRequestLoading({required this.flatId});
}
class RemaindRequestSuccess extends MyRequestsState {
  final String message;

  const RemaindRequestSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class RemaindRequestFailure extends MyRequestsState {
  final String error;

  const RemaindRequestFailure({required this.error});

  @override
  List<Object> get props => [error];
}