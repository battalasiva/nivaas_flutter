part of 'visitors_history_bloc.dart';

sealed class VisitorsHistoryEvent extends Equatable {
  const VisitorsHistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchVisitorsHistoryEvent extends VisitorsHistoryEvent {
  final int apartmentId, flatId, pageNo, pageSize;

  const FetchVisitorsHistoryEvent({required this.apartmentId, required this.flatId, required this.pageNo, required this.pageSize});

}