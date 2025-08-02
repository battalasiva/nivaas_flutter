import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/security/guest_invite_entries_usecase.dart';

import '../../../../data/models/security/guest_invite_entries_model.dart';

part 'guest_invite_entries_event.dart';
part 'guest_invite_entries_state.dart';

class GuestInviteEntriesBloc extends Bloc<GuestInviteEntriesEvent, GuestInviteEntriesState> {
  final GuestInviteEntriesUsecase guestInviteEntriesUsecase;
  
  GuestInviteEntriesBloc(this.guestInviteEntriesUsecase) : super(GuestInviteEntriesInitial()) {
    on<FetchGuestInviteEntriesEvent>((event, emit) async{
      emit(GuestInviteEntriesLoading());
      try {
        final response = await guestInviteEntriesUsecase.call(event.apartmentId, event.pageNo, event.pageSize);
        emit(GuestInviteEntriesLoaded(details: response));
      } catch (e) {
        emit(GuestInviteEntriesFailure(message: e.toString()));
      }
    });
  }
}
