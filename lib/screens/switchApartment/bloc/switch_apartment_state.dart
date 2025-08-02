part of 'switch_apartment_bloc.dart';

sealed class SwitchApartmentState extends Equatable {
  const SwitchApartmentState();
  
  @override
  List<Object> get props => [];
}

final class SwitchApartmentInitial extends SwitchApartmentState {}
final class SwitchApartmentLoading extends SwitchApartmentState {}
final class SwitchApartmentLoaded extends SwitchApartmentState {
  final List<ApartmentModel> apartments;

  const SwitchApartmentLoaded({required this.apartments});
}
final class SwitchApartmentError extends SwitchApartmentState {
  final String message;

  const SwitchApartmentError({required this.message});
}

class SwitchApartmentChangedSuccess extends SwitchApartmentState {}

class SwitchApartmentChangedFailure extends SwitchApartmentState {
  final String errorMessage;

  const SwitchApartmentChangedFailure({required this.errorMessage});
}

class NoFlatsState extends SwitchApartmentState{}
