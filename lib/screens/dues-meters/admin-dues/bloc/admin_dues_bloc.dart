// AdminDuesBloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/dues/admin_due_model.dart';
import 'package:nivaas/domain/repositories/dues/admin_due_repository.dart';
import 'package:nivaas/domain/repositories/dues/updatedueStatus_repository.dart';

part 'admin_dues_event.dart';
part 'admin_dues_state.dart';

class AdminDuesBloc extends Bloc<AdminDuesEvent, AdminDuesState> {
  final AdminDuesRepository repository;
  final UpdateDueRepository updateDueRepository;

  AdminDuesBloc({
    required this.repository,
    required this.updateDueRepository,
  }) : super(AdminDuesInitial()) {
    on<FetchAdminDuesEvent>((event, emit) async {
      emit(AdminDuesLoading());
      try {
        final dues = await repository.fetchAdminDues(
            event.apartmentId, event.year, event.month);
        emit(AdminDuesLoaded(dues: dues));
      } catch (e) {
        emit(AdminDuesError(error: e.toString()));
      }
    });
    on<UpdateDueRequestEvent>((event, emit) async {
      emit(UpdateDueLoading());
      try {
        final result = await updateDueRepository.updateDue(
          apartmentId: event.apartmentId,
          status: event.status,
          societyDueIds: event.societyDueIds,
        );
        emit(UpdateDueSuccess(result));
      } catch (error) {
        emit(UpdateDueFailure(error.toString()));
      }
    });
  }
}
