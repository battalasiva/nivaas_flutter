part of 'gate_activities_bloc.dart';

sealed class GateActivitiesState extends Equatable {
  const GateActivitiesState();
  
  @override
  List<Object> get props => [];
}

final class GateActivitiesInitial extends GateActivitiesState {}
class GateActivitiesLoading extends GateActivitiesState {}
class GateActivitiesLoaded extends GateActivitiesState {
  final GuestInviteEntriesModel details;

  const GateActivitiesLoaded({required this.details});
}
class GateActivitiesFailure extends GateActivitiesState {
  final String message;

  const GateActivitiesFailure({required this.message});
}
