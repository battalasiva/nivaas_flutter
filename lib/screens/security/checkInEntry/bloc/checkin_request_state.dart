part of 'checkin_request_bloc.dart';

sealed class CheckinRequestState extends Equatable {
  const CheckinRequestState();
  
  @override
  List<Object> get props => [];
}

final class CheckinRequestInitial extends CheckinRequestState {}
class CheckinRequestLoading extends CheckinRequestState {}
class CheckinRequestSuccess extends CheckinRequestState {}
class CheckinRequestFailure extends CheckinRequestState {
  final String message;

  const CheckinRequestFailure({required this.message});
}
