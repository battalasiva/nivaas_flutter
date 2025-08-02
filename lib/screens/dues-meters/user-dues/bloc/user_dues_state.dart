import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/dues/userDue_model.dart';

abstract class UserDuesState extends Equatable {
  const UserDuesState();

  @override
  List<Object?> get props => [];
}

class UserDuesInitial extends UserDuesState {}

class UserDuesLoading extends UserDuesState {}

class UserDuesLoaded extends UserDuesState {
  final List<UserDuesModal> userDues;

  const UserDuesLoaded({required this.userDues});

  @override
  List<Object?> get props => [userDues];
}

class UserDuesError extends UserDuesState {
  final String message;

  const UserDuesError({required this.message});

  @override
  List<Object?> get props => [message];
}
