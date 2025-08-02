import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/complaints/owners_list_model.dart';
import 'package:nivaas/domain/repositories/complaints/reassign_complaint_repository.dart';
import 'package:nivaas/domain/repositories/complaints/owners_list_repository.dart';
part 'view_complaints_event.dart';
part 'view_complaints_state.dart';

class ViewComplaintsBloc
    extends Bloc<ViewComplaintsEvent, ViewComplaintsState> {
  final ReassignComplaintRepository complaintsRepository;
  final OwnersRepository ownersRepository;

  ViewComplaintsBloc({
    required this.complaintsRepository,
    required this.ownersRepository,
  }) : super(ViewComplaintsInitial()) {
    on<ReassignComplaintEvent>((event, emit) async {
      emit(ReassignComplaintLoading());
      try {
        final success = await complaintsRepository.reassignComplaint(
          id: event.id,
          status: event.status,
          assignedTo: event.assignedTo,
          isAdmin: event.isAdmin,
        );
        if (success) {
          emit(ReassignComplaintSuccess());
        } else {
          emit(ReassignComplaintFailure("Failed to reassign complaint."));
        }
      } catch (e) {
        emit(ReassignComplaintFailure(e.toString()));
      }
    });
    on<FetchOwnersListEvent>((event, emit) async {
      emit(OwnersListLoading());
      try {
        final owners = await ownersRepository.getOwnersList(
            event.apartmentId, event.pageNo, event.pageSize);
        emit(OwnersListLoaded(owners));
      } catch (e) {
        emit(OwnersListError(e.toString()));
      }
    });
  }
}
