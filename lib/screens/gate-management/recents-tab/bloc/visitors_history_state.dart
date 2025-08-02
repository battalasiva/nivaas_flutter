part of 'visitors_history_bloc.dart';

sealed class VisitorsHistoryState extends Equatable {
  const VisitorsHistoryState();
  
  @override
  List<Object> get props => [];
}

final class VisitorsHistoryInitial extends VisitorsHistoryState {}
class VisitorsHistoryLoading extends VisitorsHistoryState{}
class VisitorsHistoryLoaded extends VisitorsHistoryState{
  final List<VisitorsHistoryModel> details;
  const VisitorsHistoryLoaded({required this.details});
}
class VisitorsHistoryFailure extends VisitorsHistoryState{
  final String message;

  const VisitorsHistoryFailure({required this.message});
}