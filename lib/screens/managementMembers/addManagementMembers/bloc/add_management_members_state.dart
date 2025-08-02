part of 'add_management_members_bloc.dart';

sealed class AddManagementMembersState extends Equatable {
  const AddManagementMembersState();
  
  @override
  List<Object> get props => [];
}

final class CoAdminInitial extends AddManagementMembersState {}
class AddCoAdminLoading extends AddManagementMembersState {}
class AddCoAdminSuccess extends AddManagementMembersState {}
class OwnersListLoading extends AddManagementMembersState{}
class OwnersListLoaded extends AddManagementMembersState{
  final OwnersListModel details;

  const OwnersListLoaded({required this.details});
}
class CoAdminFailure extends AddManagementMembersState {
  final String message;

  const CoAdminFailure({required this.message});
}
class AddSecurityLoading extends AddManagementMembersState {}
class AddSecuritySuccess extends AddManagementMembersState {}
class AddSecurityFailure extends AddManagementMembersState {
  final String message;

  const AddSecurityFailure({required this.message});
}