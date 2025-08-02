part of 'flat_details_bloc.dart';

sealed class FlatDetailsEvent extends Equatable {
  const FlatDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchFlatDetailsEvent extends FlatDetailsEvent {
  final int flatid;

  FetchFlatDetailsEvent(this.flatid);
}

class UpdateFlatDetailsEvent extends FlatDetailsEvent {
  final FlatDetailsModel flatDetails;
  final int flatId;

  UpdateFlatDetailsEvent({required this.flatDetails, required this.flatId});
}