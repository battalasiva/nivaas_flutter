part of 'add_meter_readings_bloc.dart';

sealed class AddMeterReadingsEvent extends Equatable {
  const AddMeterReadingsEvent();

  @override
  List<Object> get props => [];
}
class FetchMeterReadingsEvent extends AddMeterReadingsEvent {
  final int apartmentId;
  final int prepaidMeterId;

  FetchMeterReadingsEvent({required this.apartmentId, required this.prepaidMeterId});

  @override
  List<Object> get props => [apartmentId, prepaidMeterId];
}
class SubmitMeterReadingEvent extends AddMeterReadingsEvent {
  final Map<String, dynamic> payload;

  const SubmitMeterReadingEvent({required this.payload});
}

class FetchSingleMeterReadings extends AddMeterReadingsEvent {
  final int apartmentId;
  final int prepaidMeterId;
  final int flatId;

  const FetchSingleMeterReadings({
    required this.apartmentId,
    required this.prepaidMeterId,
    required this.flatId,
  });

  @override
  List<Object> get props => [apartmentId, prepaidMeterId, flatId];
}