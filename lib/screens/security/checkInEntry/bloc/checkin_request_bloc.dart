import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/security/checkin_request_usecase.dart';

part 'checkin_request_event.dart';
part 'checkin_request_state.dart';

class CheckinRequestBloc extends Bloc<CheckinRequestEvent, CheckinRequestState> {
  final CheckinRequestUsecase checkinRequestUsecase;
  CheckinRequestBloc(this.checkinRequestUsecase) : super(CheckinRequestInitial()) {
    on<SendCheckinRequestEvent>((event, emit) async{
      emit(CheckinRequestLoading());
      try {
        final response = await checkinRequestUsecase.call(
          event.apartmentId, event.flatId, event.type, event.name, event.mobileNumber
        );
        emit(CheckinRequestSuccess());
      } catch (e) {
        emit(CheckinRequestFailure(message: e.toString()));
      }
    });
  }
}
