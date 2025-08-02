part of 'add_prepaid_meter_bloc.dart';

abstract class AddPrepaidMeterEvent extends Equatable {
  const AddPrepaidMeterEvent();

  @override
  List<Object> get props => [];
}

class SubmitPrepaidMeterData extends AddPrepaidMeterEvent {
  final Map<String, dynamic> payload;

  const SubmitPrepaidMeterData(this.payload);

  @override
  List<Object> get props => [payload];
}

class EditPrepaidMeterData extends AddPrepaidMeterEvent {
  final Map<String, dynamic> payload;

  const EditPrepaidMeterData(this.payload);

  @override
  List<Object> get props => [payload];
}
