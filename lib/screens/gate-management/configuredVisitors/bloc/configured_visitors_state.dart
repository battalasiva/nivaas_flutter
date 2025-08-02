part of 'configured_visitors_bloc.dart';

sealed class ConfiguredVisitorsState extends Equatable {
  const ConfiguredVisitorsState();
  
  @override
  List<Object> get props => [];
}

final class ConfiguredVisitorsInitial extends ConfiguredVisitorsState {}
class ConfiguredVisitorsLoading extends ConfiguredVisitorsState {}
class ConfiguredVisitorsLoaded extends ConfiguredVisitorsState {
  final ConfiguredVisitorInvitesModel details;

  const ConfiguredVisitorsLoaded({required this.details});
}
class ConfiguredVisitorsFailure extends ConfiguredVisitorsState {
  final String message;

  const ConfiguredVisitorsFailure({required this.message});
}
