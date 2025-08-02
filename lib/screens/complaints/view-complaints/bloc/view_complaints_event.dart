part of 'view_complaints_bloc.dart';

sealed class ViewComplaintsEvent extends Equatable {
  const ViewComplaintsEvent();

  @override
  List<Object?> get props => [];
}

final class ReassignComplaintEvent extends ViewComplaintsEvent {
  final int id;
  final String status;
  final String assignedTo;
  final bool? isAdmin;

  const ReassignComplaintEvent({
    required this.id,
    required this.status,
    required this.assignedTo,
    required this.isAdmin,
  });

  @override
  List<Object?> get props => [id, status, assignedTo, isAdmin];
}

final class FetchOwnersListEvent extends ViewComplaintsEvent {
  final int apartmentId;
  final int pageNo;
  final int pageSize;

  const FetchOwnersListEvent(this.apartmentId, this.pageNo, this.pageSize);

  @override
  List<Object?> get props => [apartmentId, pageNo, pageSize];
}
