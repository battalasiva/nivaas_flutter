part of 'gate_activities_bloc.dart';

sealed class GateActivitiesEvent extends Equatable {
  const GateActivitiesEvent();

  @override
  List<Object> get props => [];
}

class FetchCheckinHistoryEvent extends GateActivitiesEvent {
  final int apartmentId, pageNo, pageSize;
  final String status;

  const FetchCheckinHistoryEvent({required this.apartmentId, required this.status,
    required this.pageNo, required this.pageSize
  });

}