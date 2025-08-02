import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:nivaas/domain/usecases/security/otp_validation_usecase.dart';

part 'otp_validation_event.dart';
part 'otp_validation_state.dart';

class OtpValidationBloc extends Bloc<OtpValidationEvent, OtpValidationState> {
  final OtpValidationUsecase otpValidationUsecase;
  OtpValidationBloc(this.otpValidationUsecase) : super(OtpValidationInitial()) {
    on<OtpValidateEvent>((event, emit) async{
      emit(OtpValidationLoading());
      try {
        await otpValidationUsecase.execute(event.requestId, event.otp);
        emit(OtpValidationLoaded());
      } catch (e) {
        emit(OtpValidationFailure(message: e.toString()));
      }
    });
  }
}
