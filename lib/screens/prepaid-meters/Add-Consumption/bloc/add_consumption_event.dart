part of 'add_consumption_bloc.dart';

abstract class AddConsumptionEvent extends Equatable {
  const AddConsumptionEvent();

  @override
  List<Object> get props => [];
}

class SubmitConsumptionData extends AddConsumptionEvent {
  final Map<String, dynamic> payload;

  const SubmitConsumptionData(this.payload);

  @override
  List<Object> get props => [payload];
}

class FetchLastAddedConsumptionEvent extends AddConsumptionEvent {
  final int apartmentId;
  final int prepaidId;

  const FetchLastAddedConsumptionEvent(
      {required this.apartmentId, required this.prepaidId});
}

class FetchLastAddedSingleFlatConsumptionEvent extends AddConsumptionEvent {
  final int apartmentId;
  final int prepaidId;
  final String flatId;

  const FetchLastAddedSingleFlatConsumptionEvent({
    required this.apartmentId,
    required this.prepaidId,
    required this.flatId,
  });
}
