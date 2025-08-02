part of 'flat_details_bloc.dart';

sealed class FlatDetailsState extends Equatable {
  const FlatDetailsState();
  
  @override
  List<Object> get props => [];
}

final class FlatDetailsInitial extends FlatDetailsState {}
final class FlatDetailsLoading extends FlatDetailsState {}
final class FlatDetailsLoaded extends FlatDetailsState {
  final FlatDetailsModel flatDetails;

  FlatDetailsLoaded({required this.flatDetails});
}
class FlatDetailsUpdating extends FlatDetailsState {}

class FlatDetailsUpdated extends FlatDetailsState {}

final class FlatDetailsFailure extends FlatDetailsState {
  final String message;

  FlatDetailsFailure({required this.message});
}
