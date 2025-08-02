part of 'configured_visitors_bloc.dart';

sealed class ConfiguredVisitorsEvent extends Equatable {
  const ConfiguredVisitorsEvent();

  @override
  List<Object> get props => [];
}

class FetchConfiguredVisitorsEvent extends ConfiguredVisitorsEvent {
  final int apartmentId, flatId, pageNo, pageSize;

  FetchConfiguredVisitorsEvent({required this.apartmentId, required this.flatId, required this.pageNo, required this.pageSize,});
}