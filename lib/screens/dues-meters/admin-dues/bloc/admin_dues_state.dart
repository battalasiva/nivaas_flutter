part of 'admin_dues_bloc.dart';

sealed class AdminDuesState extends Equatable {
  const AdminDuesState();

  @override
  List<Object?> get props => [];
}

final class AdminDuesInitial extends AdminDuesState {}

final class AdminDuesLoading extends AdminDuesState {}

final class AdminDuesLoaded extends AdminDuesState {
  final List<AdminDuesModal> dues;

  AdminDuesLoaded({required this.dues});

  @override
  List<Object?> get props => [dues];
}

final class AdminDuesError extends AdminDuesState {
  final String error;

  AdminDuesError({required this.error});

  @override
  List<Object?> get props => [error];
}

class UpdateDueInitial extends AdminDuesState {}

class UpdateDueLoading extends AdminDuesState {}

class UpdateDueSuccess extends AdminDuesState {
  final String message;

  const UpdateDueSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateDueFailure extends AdminDuesState {
  final String error;

  const UpdateDueFailure(this.error);

  @override
  List<Object> get props => [error];
}
