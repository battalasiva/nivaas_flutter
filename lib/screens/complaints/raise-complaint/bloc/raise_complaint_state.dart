part of 'raise_complaint_bloc.dart';

sealed class RaiseComplaintState extends Equatable {
  const RaiseComplaintState();

  @override
  List<Object> get props => [];
}

final class RaiseComplaintInitial extends RaiseComplaintState {}

final class RaiseComplaintLoading extends RaiseComplaintState {}

final class RaiseComplaintSuccess extends RaiseComplaintState {
  final String response;

  const RaiseComplaintSuccess(this.response);

  @override
  List<Object> get props => [response];
}

final class RaiseComplaintError extends RaiseComplaintState {
  final String message;

  const RaiseComplaintError(this.message);

  @override
  List<Object> get props => [message];
}

class AdminsListLoading extends RaiseComplaintState {}

class AdminsListLoaded extends RaiseComplaintState {
  final List<AdminsListModal> admins;

  const AdminsListLoaded(this.admins);

  @override
  List<Object> get props => [admins];
}

class AdminsListError extends RaiseComplaintState {
  final String message;

  AdminsListError(this.message);

  @override
  List<Object> get props => [message];
}
