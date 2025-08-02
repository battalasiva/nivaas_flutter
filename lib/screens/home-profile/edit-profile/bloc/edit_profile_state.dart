part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {}

class EditProfileFailure extends EditProfileState {
  final String error;

  EditProfileFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ProfileUploadLoading extends EditProfileState {}

class ProfileUploadSuccess extends EditProfileState {}

class ProfileUploadFailure extends EditProfileState {
  final String error;

  ProfileUploadFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class LogoutInitial extends EditProfileState {}

class LogoutLoading extends EditProfileState {}

class LogoutSuccess extends EditProfileState {
  final String message;

  LogoutSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class LogoutFailure extends EditProfileState {
  final String error;

  LogoutFailure(this.error);

  @override
  List<Object> get props => [error];
}