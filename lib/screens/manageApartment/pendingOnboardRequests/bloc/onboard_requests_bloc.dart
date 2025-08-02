import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/manageApartment/onboard_requests_model.dart';
import 'package:nivaas/domain/usecases/manageApartment/onboard_requests_usecase.dart';

part 'onboard_requests_event.dart';
part 'onboard_requests_state.dart';

class OnboardRequestsBloc extends Bloc<OnboardRequestsEvent, OnboardRequestsState> {
  final OnboardRequestsUsecase onboardRequestsUsecase;
  OnboardRequestsBloc(this.onboardRequestsUsecase) : super(OnboardRequestsInitial()) {
    on<ApproveRequestEvent>((event, emit) async{
      emit(OnboardRequestsLoading());
      try {
        if (event.role == 'FLAT_OWNER') {
          final details = OwnerOnboardRequestModel(id: event.id, type: 'FLAT');
          await onboardRequestsUsecase.executeOwnerOnboardRequest(details);
        } else {
          final details = TenantOnboardRequestModel(
            id: event.id, relatedType: event.relatedType!, relatedRequestId: event.relatedRequestId!
          );
          await onboardRequestsUsecase.executeTenantOnboardRequest(details);
        }
        emit(ApproveOnboardRequestsSuccess(flatId: event.flatId, userId: event.userId));
      } catch (e) {
        emit(OnboardRequestsFailure(errorMessage: e.toString()));
      }
    });

    on<RejectOnboardRequestEvent>((event, emit) async{
      emit(OnboardRequestsLoading());
      try {
        await onboardRequestsUsecase.executeRejectOnboardRequest(event.id, event.userId);
        emit(RejectOnboardRequestsSuccess(flatId: event.flatId, userId: event.userId));
      } catch (e) {
        emit(OnboardRequestsFailure(errorMessage: e.toString()));
      }
    });
  }
}
