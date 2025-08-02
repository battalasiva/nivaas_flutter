part of 'add_consumption_bloc.dart';

abstract class AddConsumptionState extends Equatable {
  const AddConsumptionState();

  @override
  List<Object> get props => [];
}

class AddConsumptionInitial extends AddConsumptionState {}

class AddConsumptionLoading extends AddConsumptionState {}

class AddConsumptionSuccess extends AddConsumptionState {
  final String message;

  const AddConsumptionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddConsumptionFailure extends AddConsumptionState {
  final String error;

  const AddConsumptionFailure(this.error);

  @override
  List<Object> get props => [error];
}

class ConsumptionInitial extends AddConsumptionState {}

class ConsumptionLoading extends AddConsumptionState {}

class ConsumptionLoaded extends AddConsumptionState {
  final List<LastAddedConsumptionModal> consumptionData;

  const ConsumptionLoaded(this.consumptionData);
}

class ConsumptionError extends AddConsumptionState {
  final String message;

  const ConsumptionError(this.message);
}

class SingleFlatConsumptionInitial extends AddConsumptionState {}

class SingleFlatConsumptionLoading extends AddConsumptionState {}

class SingleFlatConsumptionLoaded extends AddConsumptionState {
  final GetSingleFlatLastAddedConsumptionUnitsModal singleFlatconsumptionData;

  const SingleFlatConsumptionLoaded(this.singleFlatconsumptionData);
}

class SingleFlatConsumptionError extends AddConsumptionState {
  final String errorMessage;

  SingleFlatConsumptionError(this.errorMessage);
}