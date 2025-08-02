part of 'otp_bloc.dart';

abstract class OtpEvent {}

class SendOtpEvent extends OtpEvent {
  final String mobileNumber;
  final String? name;

  SendOtpEvent({required this.mobileNumber, this.name});
}

class VerifyOtpEvent extends OtpEvent {
  final String otp;
  final String mobileNumber;
  final String? name;

  VerifyOtpEvent({this.name, required this.mobileNumber, required this.otp});
}
