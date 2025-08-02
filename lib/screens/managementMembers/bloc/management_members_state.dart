part of 'management_members_bloc.dart';

sealed class ManagementMembersState extends Equatable {
  const ManagementMembersState();
  
  @override
  List<Object> get props => [];
}

final class ManagementMembersInitial extends ManagementMembersState {}
class ListManagementMembersLoading extends ManagementMembersState{}
class ListManagementMembersLoaded extends ManagementMembersState{
  final ListManagementMembersModel details;

  const ListManagementMembersLoaded({required this.details});
}
class ListManagementMembersFailure extends ManagementMembersState{
  final String message;

  const ListManagementMembersFailure({required this.message});
}
