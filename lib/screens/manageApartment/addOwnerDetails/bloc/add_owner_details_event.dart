part of 'add_owner_details_bloc.dart';

sealed class AddOwnerDetailsEvent extends Equatable {
  const AddOwnerDetailsEvent();

  @override
  List<Object> get props => [];
}

class AddDetailsEvent extends AddOwnerDetailsEvent{
  final AddOwnerdetailsModel flatDetails;
  final int apartmentId;

  AddDetailsEvent({required this.flatDetails,required this.apartmentId});
}