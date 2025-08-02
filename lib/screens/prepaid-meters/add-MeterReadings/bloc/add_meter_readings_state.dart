part of 'add_meter_readings_bloc.dart';

sealed class AddMeterReadingsState extends Equatable {
  const AddMeterReadingsState();
  
  @override
  List<Object> get props => [];
}

final class AddMeterReadingsInitial extends AddMeterReadingsState {}

class GetMeterReadingsInitial extends AddMeterReadingsState {}

class GetMeterReadingsLoading extends AddMeterReadingsState {}

class GetMeterReadingsLoaded extends AddMeterReadingsState {
  final List<GetMeterReadingsModal> readings;

  const GetMeterReadingsLoaded(this.readings);

  @override
  List<Object> get props => [readings];
}

class GetMeterReadingsError extends AddMeterReadingsState {
  final String message;

  const GetMeterReadingsError(this.message);

  @override
  List<Object> get props => [message];
}

class PostMeterReadingsInitial extends AddMeterReadingsState {}

class PostMeterReadingsLoading extends AddMeterReadingsState {}

class PostMeterReadingsSuccess extends AddMeterReadingsState {
  final String message;

  const PostMeterReadingsSuccess({required this.message});
}

class PostMeterReadingsError extends AddMeterReadingsState {
  final String message;

  const PostMeterReadingsError({required this.message});
}

class GetSingleMeterReadingsInitial extends AddMeterReadingsState {}

class GetSingleMeterReadingsLoading extends AddMeterReadingsState {}

class GetSingleMeterReadingsLoaded extends AddMeterReadingsState {
  final GetSingleFlatReadingsModal reading;

  const GetSingleMeterReadingsLoaded(this.reading);

  @override
  List<Object> get props => [reading];
}

class GetSingleMeterReadingsError extends AddMeterReadingsState {
  final String message;

  const GetSingleMeterReadingsError(this.message);

  @override
  List<Object> get props => [message];
}