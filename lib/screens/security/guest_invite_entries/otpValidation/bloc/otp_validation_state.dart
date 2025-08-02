part of 'otp_validation_bloc.dart';

sealed class OtpValidationState extends Equatable {
  const OtpValidationState();
  
  @override
  List<Object> get props => [];
}

final class OtpValidationInitial extends OtpValidationState {}
class OtpValidationLoading extends OtpValidationState{}
class OtpValidationLoaded extends OtpValidationState{}
class OtpValidationFailure extends OtpValidationState{
  final String message;

  const OtpValidationFailure({required this.message});
}
