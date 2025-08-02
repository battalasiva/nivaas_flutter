part of 'guest_invite_entries_bloc.dart';

sealed class GuestInviteEntriesState extends Equatable {
  const GuestInviteEntriesState();
  
  @override
  List<Object> get props => [];
}

final class GuestInviteEntriesInitial extends GuestInviteEntriesState {}
class GuestInviteEntriesLoading extends GuestInviteEntriesState {}
class GuestInviteEntriesLoaded extends GuestInviteEntriesState {
  final GuestInviteEntriesModel details;

  const GuestInviteEntriesLoaded({required this.details});
}
class GuestInviteEntriesFailure extends GuestInviteEntriesState {
  final String message;

  const GuestInviteEntriesFailure({required this.message});
}