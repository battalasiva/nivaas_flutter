import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/apartmentOnboarding/my_request_modal.dart';
import 'package:nivaas/domain/usecases/apartmentOnboarding/my_requests_usecase.dart';

import '../../../../../../domain/usecases/apartmentOnboarding/remaind_request_usecase.dart';

part 'my_requests_event.dart';
part 'my_requests_state.dart';

class MyRequestsBloc extends Bloc<MyRequestsEvent, MyRequestsState> {
  final MyRequestsUseCase useCase;
  final RemaindRequestUseCase remaindRequestUseCase;

  MyRequestsBloc(this.useCase,this.remaindRequestUseCase) : super(MyRequestsInitial()) {
    on<FetchMyRequestsEvent>((event, emit) async {
      emit(MyRequestsLoading());
      try {
        final myRequests = await useCase.fetchMyRequests(event.type);
        emit(MyRequestsLoaded(myRequests));
      } catch (error) {
        emit(MyRequestsError(error.toString()));
      }
    });
    on<RemaindRequestCallEvent>((event, emit) async {
      emit(RemaindRequestLoading(flatId : event.flatId));
      try {
        final message = await remaindRequestUseCase.call(
          event.apartmentId, 
          event.flatId, 
          event.onboardingId,
        );
        emit(RemaindRequestSuccess(message: message));
      } catch (error) {
        emit(RemaindRequestFailure(error: error.toString()));
      }
    });
  }
}
