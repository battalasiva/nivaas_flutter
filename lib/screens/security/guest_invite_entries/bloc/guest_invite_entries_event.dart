part of 'guest_invite_entries_bloc.dart';

sealed class GuestInviteEntriesEvent extends Equatable {
  const GuestInviteEntriesEvent();

  @override
  List<Object> get props => [];
}

class FetchGuestInviteEntriesEvent extends GuestInviteEntriesEvent {
  final int apartmentId, pageNo, pageSize;

  const FetchGuestInviteEntriesEvent({required this.apartmentId, required this.pageNo, required this.pageSize});

}
