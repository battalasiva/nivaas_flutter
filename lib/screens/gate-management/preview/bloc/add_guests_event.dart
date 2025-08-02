part of 'add_guests_bloc.dart';

sealed class AddGuestsEvent extends Equatable {
  const AddGuestsEvent();

  @override
  List<Object> get props => [];
}

class AddGuestsRequestEvent extends AddGuestsEvent {
  final Map<String, dynamic> payload;

  const AddGuestsRequestEvent(this.payload);

  @override
  List<Object> get props => [payload];
}
class FetchGuestStatus extends AddGuestsEvent {
  final int apartmentId;
  final int flatId;
  final String status;

  const FetchGuestStatus({
    required this.apartmentId,
    required this.flatId,
    required this.status,
  });

  @override
  List<Object> get props => [apartmentId, flatId, status];
}

class UpdateGuestStatusRequested extends AddGuestsEvent {
  final int id;
  final String status;

  const UpdateGuestStatusRequested({required this.id, required this.status});

  @override
  List<Object> get props => [id, status];
}