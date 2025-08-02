part of 'add_management_members_bloc.dart';

sealed class AddManagementMembersEvent extends Equatable {
  const AddManagementMembersEvent();

  @override
  List<Object> get props => [];
}

class AddCoAdminEvent extends AddManagementMembersEvent {
  final AddCoAdminModel details;

  const AddCoAdminEvent({required this.details});
}

class FetchOwnersListEvent extends AddManagementMembersEvent {
  final int apartmentID;

  const FetchOwnersListEvent({required this.apartmentID});
}

class AddSecurityEvent extends AddManagementMembersEvent {
  final AddSecurityModel details;

  const AddSecurityEvent({required this.details});
}