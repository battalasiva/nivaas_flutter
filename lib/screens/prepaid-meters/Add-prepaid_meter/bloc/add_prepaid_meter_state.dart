part of 'add_prepaid_meter_bloc.dart';

abstract class AddPrepaidMeterState extends Equatable {
  const AddPrepaidMeterState();

  @override
  List<Object> get props => [];
}

class AddPrepaidMeterInitial extends AddPrepaidMeterState {}

class AddPrepaidMeterLoading extends AddPrepaidMeterState {}

class AddPrepaidMeterSuccess extends AddPrepaidMeterState {
  final String message;

  const AddPrepaidMeterSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddPrepaidMeterFailure extends AddPrepaidMeterState {
  final String error;

  const AddPrepaidMeterFailure(this.error);

  @override
  List<Object> get props => [error];
}


class EditPrepaidMeterInitial extends AddPrepaidMeterState {}

class EditPrepaidMeterLoading extends AddPrepaidMeterState {}

class EditPrepaidMeterSuccess extends AddPrepaidMeterState {
  final String message;

  const EditPrepaidMeterSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class EditPrepaidMeterFailure extends AddPrepaidMeterState {
  final String error;

  const EditPrepaidMeterFailure(this.error);

  @override
  List<Object> get props => [error];
}
