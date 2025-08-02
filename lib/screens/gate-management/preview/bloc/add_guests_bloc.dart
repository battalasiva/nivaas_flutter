import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/gate-management/ApproveDeclineGuestModel.dart';
import 'package:nivaas/data/models/gate-management/CreateInviteModel.dart';
import 'package:nivaas/domain/usecases/gate-management/add_guests_usecase.dart';
import 'package:nivaas/domain/usecases/gate-management/handle_guest_status_usecase.dart';
import 'package:nivaas/domain/usecases/gate-management/update_guest_status_usecase.dart';

part 'add_guests_event.dart';
part 'add_guests_state.dart';

class AddGuestsBloc extends Bloc<AddGuestsEvent, AddGuestsState> {
  final AddGuestsUseCase addGuestsUseCase;
  final HandleGuestStatusUsecase handleGuestStatusUsecase;
  final UpdateGuestStatusUseCase updateGuestStatusUseCase;
  
  AddGuestsBloc(this.addGuestsUseCase,this.handleGuestStatusUsecase,this.updateGuestStatusUseCase) : super(AddGuestsInitial()) {
    on<AddGuestsRequestEvent>((event, emit) async {
      emit(AddGuestsLoading());

      try {
        final response = await addGuestsUseCase.call(event.payload);
        emit(AddGuestsSuccess(response));
      } catch (e) {
        emit(AddGuestsFailure(e.toString())); // Proper error handling
      }
    });
    on<FetchGuestStatus>((event, emit) async {
      emit(GuestStatusLoading());
      try {
        final result = await handleGuestStatusUsecase(
          apartmentId: event.apartmentId,
          flatId: event.flatId,
          status: event.status,
        );
        emit(GuestStatusSuccess(result));
      } catch (e) {
        emit(GuestStatusFailure(e.toString()));
      }
    });
    on<UpdateGuestStatusRequested>((event, emit) async {
      emit(UpdateGuestStatusLoading());
      try {
        final result = await updateGuestStatusUseCase(event.id, event.status);
        emit(UpdateGuestStatusSuccess(result));
      } catch (e) {
        emit(UpdateGuestStatusFailure(e.toString()));
      }
    });
  }
}
