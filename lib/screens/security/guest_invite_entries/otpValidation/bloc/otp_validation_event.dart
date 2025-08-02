part of 'otp_validation_bloc.dart';

sealed class OtpValidationEvent extends Equatable {
  const OtpValidationEvent();

  @override
  List<Object> get props => [];
}

class OtpValidateEvent extends OtpValidationEvent {
  final int requestId;
  final String otp;

  const OtpValidateEvent({required this.requestId, required this.otp});
}