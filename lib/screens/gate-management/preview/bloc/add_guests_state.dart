part of 'add_guests_bloc.dart';

sealed class AddGuestsState extends Equatable {
  const AddGuestsState();

  @override
  List<Object> get props => [];
}

class AddGuestsInitial extends AddGuestsState {}

class AddGuestsLoading extends AddGuestsState {}

class AddGuestsSuccess extends AddGuestsState {
  final CreateInviteModel inviteData;

  const AddGuestsSuccess(this.inviteData);

  @override
  List<Object> get props => [inviteData];
}

class AddGuestsFailure extends AddGuestsState {
  final String errorMessage;

  const AddGuestsFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}


class GuestStatusInitial extends AddGuestsState {}

class GuestStatusLoading extends AddGuestsState {}

class GuestStatusSuccess extends AddGuestsState {
  final ApproveDeclineGuestModel data;

  const GuestStatusSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class GuestStatusFailure extends AddGuestsState {
  final String error;

  const GuestStatusFailure(this.error);

  @override
  List<Object> get props => [error];
}
class UpdateGuestStatusInitial extends AddGuestsState {}

class UpdateGuestStatusLoading extends AddGuestsState {}

class UpdateGuestStatusSuccess extends AddGuestsState {
  final String message;

  const UpdateGuestStatusSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateGuestStatusFailure extends AddGuestsState {
  final String error;

  const UpdateGuestStatusFailure(this.error);

  @override
  List<Object> get props => [error];
}