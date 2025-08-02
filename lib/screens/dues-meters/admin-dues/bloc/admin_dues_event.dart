part of 'admin_dues_bloc.dart';

sealed class AdminDuesEvent extends Equatable {
  const AdminDuesEvent();

  @override
  List<Object?> get props => [];
}

final class FetchAdminDuesEvent extends AdminDuesEvent {
  final int apartmentId;
  final int year;
  final int month;

  FetchAdminDuesEvent(
      {required this.apartmentId, required this.year, required this.month});

  @override
  List<Object?> get props => [apartmentId, year, month];
}

class UpdateDueRequestEvent extends AdminDuesEvent {
  final String apartmentId;
  final String status;
  final String societyDueIds;

  const UpdateDueRequestEvent({
    required this.apartmentId,
    required this.status,
    required this.societyDueIds,
  });

  @override
  List<Object> get props => [apartmentId, status, societyDueIds];
}
