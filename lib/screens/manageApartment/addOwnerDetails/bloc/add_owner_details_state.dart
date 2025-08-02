part of 'add_owner_details_bloc.dart';

sealed class AddOwnerDetailsState extends Equatable {
  const AddOwnerDetailsState();
  
  @override
  List<Object> get props => [];
}

final class AddOwnerDetailsInitial extends AddOwnerDetailsState {}
class AddOwnerDetailsLoading extends AddOwnerDetailsState {}
class AddOwnerDetailsSuccess extends AddOwnerDetailsState {}
class AddOwnerDetailsFailure extends AddOwnerDetailsState {
  final String message;

  AddOwnerDetailsFailure({required this.message});
}
