part of 'flatmember_details_bloc.dart';

sealed class FlatmemberDetailsState extends Equatable {
  const FlatmemberDetailsState();
  
  @override
  List<Object> get props => [];
}

final class FlatmemberDetailsInitial extends FlatmemberDetailsState {}
class FlatmemberDetailsLoading extends FlatmemberDetailsState {}
class UpdateFlatmemberDetailsSuccess extends FlatmemberDetailsState {}
class RemoveFlatmemberDetailsSuccess extends FlatmemberDetailsState {}
class FlatmemberDetailsFailure extends FlatmemberDetailsState {
  final String errorMessage;

  FlatmemberDetailsFailure({required this.errorMessage});
}
