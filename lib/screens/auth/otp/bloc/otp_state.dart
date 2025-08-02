part of 'otp_bloc.dart';

abstract class OtpState extends Equatable {
  
  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpState {}
class OtpLoading extends OtpState {}
class OtpSentSuccess extends OtpState {
  final String otp;

  OtpSentSuccess({required this.otp});
  
}

class OtpVerifiedSuccess extends OtpState {}

class OtpErrorState extends OtpState {
  final String error;

  OtpErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class OtpErrorDialogState extends OtpState {
  final String message;

  OtpErrorDialogState(this.message);
}

class LoginOtpErrorState extends OtpState {
  final String message;

  LoginOtpErrorState(this.message);
}

class VerifyOtpErrorState extends OtpState {
  final String message;

  VerifyOtpErrorState(this.message);
}