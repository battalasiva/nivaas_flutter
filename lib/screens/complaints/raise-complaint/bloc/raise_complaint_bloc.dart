import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/complaints/admins_list_model.dart';
import 'package:nivaas/domain/repositories/complaints/admins_list_repository.dart';
import 'package:nivaas/domain/repositories/complaints/raise_complaint_repository.dart';

part 'raise_complaint_event.dart';
part 'raise_complaint_state.dart';

class RaiseComplaintBloc
    extends Bloc<RaiseComplaintEvent, RaiseComplaintState> {
  final RaiseComplaintRepository repository;
  final AdminsRepository adminsRepository;

  // Updated constructor with a named parameter
  RaiseComplaintBloc({required this.repository, required this.adminsRepository})
      : super(RaiseComplaintInitial()) {
    on<SubmitRaiseComplaintEvent>((event, emit) async {
      emit(RaiseComplaintLoading());
      try {
        final response = await repository.raiseComplaint(event.payload);
        emit(RaiseComplaintSuccess(response));
      } catch (e) {
        emit(RaiseComplaintError(e.toString()));
      }
    });
    on<FetchAdminsEvent>((event, emit) async {
      emit(AdminsListLoading());
      try {
        final admins = await adminsRepository.getAdmins(
          apartmentId: event.apartmentId,
        );
        emit(AdminsListLoaded(admins));
      } catch (e) {
        emit(AdminsListError(e.toString()));
      }
    });
  }
}
