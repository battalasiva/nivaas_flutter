part of 'switch_apartment_bloc.dart';

sealed class SwitchApartmentEvent extends Equatable {
  const SwitchApartmentEvent();

  @override
  List<Object> get props => [];
}

class SwitchApartmentOrFlatEvent extends SwitchApartmentEvent{}

class SetCurrentFlatEvent extends SwitchApartmentEvent {
  final int apartmentId;
  final int flatId;

  const SetCurrentFlatEvent({required this.apartmentId, required this.flatId});
}

class SetCurrentApartmentEvent extends SwitchApartmentEvent {
  final int apartmentId;
  final int userId;

  const SetCurrentApartmentEvent({required this.userId, required this.apartmentId});
}
