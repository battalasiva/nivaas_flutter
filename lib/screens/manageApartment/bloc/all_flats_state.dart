part of 'all_flats_bloc.dart';

sealed class AllFlatsState extends Equatable {
  const AllFlatsState();
  
  @override
  List<Object> get props => [];
}

final class AllFlatsInitial extends AllFlatsState {}
final class AllFlatsLoading extends AllFlatsState {}
final class FlatDetailsLoaded extends AllFlatsState {
  final List<FlatsModel> flats;

  const FlatDetailsLoaded({required this.flats});
}
final class FlatWithoutDetailsLoaded extends AllFlatsState {
  final FlatsWithoutDetailsModel flatsWithoutDetails;

  const FlatWithoutDetailsLoaded({required this.flatsWithoutDetails});
}
final class FlatMembersLoaded extends AllFlatsState {
  final List<FlatsModel> flats;

  const FlatMembersLoaded({required this.flats});
}
final class AllFlatsError extends AllFlatsState {
  final String message;

  const AllFlatsError({required this.message});
}