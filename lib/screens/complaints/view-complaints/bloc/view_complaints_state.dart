part of 'view_complaints_bloc.dart';

sealed class ViewComplaintsState extends Equatable {
  const ViewComplaintsState();

  @override
  List<Object?> get props => [];
}

final class ViewComplaintsInitial extends ViewComplaintsState {}

final class ReassignComplaintLoading extends ViewComplaintsState {}

final class ReassignComplaintSuccess extends ViewComplaintsState {}

final class ReassignComplaintFailure extends ViewComplaintsState {
  final String error;

  const ReassignComplaintFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class OwnersListLoading extends ViewComplaintsState {}

class OwnersListLoaded extends ViewComplaintsState {
  final List<Data> owners;

  const OwnersListLoaded(this.owners);

  @override
  List<Object?> get props => [owners];
}

class OwnersListError extends ViewComplaintsState {
  final String error;

  const OwnersListError(this.error);
}
