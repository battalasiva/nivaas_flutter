part of 'checkin_request_bloc.dart';

sealed class CheckinRequestEvent extends Equatable {
  const CheckinRequestEvent();

  @override
  List<Object> get props => [];
}
 class SendCheckinRequestEvent extends CheckinRequestEvent {
   final int apartmentId, flatId;
   final String type, name, mobileNumber;

  const SendCheckinRequestEvent({required this.apartmentId, required this.flatId, required this.type, required this.name, required this.mobileNumber});
 }