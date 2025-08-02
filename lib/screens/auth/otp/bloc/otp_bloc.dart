import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/domain/usecases/auth/login_send_otp_usecase.dart';
import 'package:nivaas/domain/usecases/auth/login_verify_otp_usecase.dart';
import 'package:nivaas/domain/usecases/auth/signup_send_otp_usecase.dart';
import 'package:nivaas/domain/usecases/auth/signup_verify_otp_usecase.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final LoginSendOtpUseCase loginSendOtpUseCase;
  final LoginVerifyOtpUseCase loginVerifyOtpUseCase;
  final SignupSendOtpUsecase signupSendOtpUsecase;
  final SignupVerifyOtpUseCase signupVerifyOtpUseCase;
  final ApiClient apiClient;

  OtpBloc(
      {required this.loginSendOtpUseCase,
      required this.loginVerifyOtpUseCase,
      required this.signupSendOtpUsecase,
      required this.signupVerifyOtpUseCase,
      required this.apiClient})
      : super(OtpInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    try {
      String otp;
      if (event.name != null) {
         otp = await signupSendOtpUsecase.call(event.mobileNumber);
      } else {
         otp = await loginSendOtpUseCase.call(event.mobileNumber);
      }
      emit(OtpSentSuccess(otp: otp ));
    } catch (e) {
      print("Caught Exception: $e, Type: ${e.runtimeType}");
      if (e is ApiException) {
        final errorMesg = e.message;
        print('---------- Raw error message: $errorMesg');
        try {
          final errorData = jsonDecode(errorMesg);
          if (errorData.containsKey('errorCode')) {
            final errorCode = errorData['errorCode'];
            if (errorCode == 1044) {
              emit(OtpErrorDialogState('User Already Exists'));
              return;
            }
            if (errorData['errorCode'] == 1000) {
              emit(LoginOtpErrorState('User Not Found'));
              return;
            }
          }
          emit(OtpErrorState(errorData['errorMessage']));
        } catch (parseError) {
          if (errorMesg.contains("Internal Server Exception")) {
            emit(OtpErrorState('Internal Server Error, please try again later.'));
          } else if (e is String){
            emit(OtpErrorState(e.message));
          } else {
            emit(OtpErrorState('Error parsing server response.'));
          }
        }
      } else {
        emit(OtpErrorState(e.toString()));
      }
    }
  }

  Future<void> _onVerifyOtp(
      VerifyOtpEvent event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    try {
      if (event.name != null) {
        await signupVerifyOtpUseCase.call(
            event.name!, event.mobileNumber, event.otp);
      } else {
        await loginVerifyOtpUseCase.call(event.mobileNumber, event.otp);
      }
      emit(OtpVerifiedSuccess());
    } catch (e) {
      print("Caught Exception: $e, Type: ${e.runtimeType}");
      if (e is ApiException) {
        final errorMesg = e.message;
        print('---------- Raw error message: $errorMesg');
        try {
          final errorData = jsonDecode(errorMesg);
          if (errorData.containsKey('errorCode')) {
            final errorCode = errorData['errorCode'];
            if (errorCode == 1043) {
              emit(VerifyOtpErrorState('User name not exist'));
              return;
            } else if (errorCode == 1055){
              emit(OtpErrorDialogState('The OTP you entered is incorrect. Please try again.'));
              return;
            }
          }
          emit(OtpErrorState(errorData['errorMessage']));
        } catch (parseError) {
          emit(OtpErrorState('Error parsing server response.'));
        }
      } else {
        emit(OtpErrorState(e.toString()));
      }
    }
  }
}
