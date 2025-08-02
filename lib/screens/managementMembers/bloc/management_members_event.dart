part of 'management_members_bloc.dart';

sealed class ManagementMembersEvent extends Equatable {
  const ManagementMembersEvent();

  @override
  List<Object> get props => [];
}

class FetchSecuritiesListEvent extends ManagementMembersEvent {
  final int apartmentId;

  const FetchSecuritiesListEvent({required this.apartmentId});
}