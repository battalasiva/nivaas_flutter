part of 'add_service_provider_bloc.dart';

sealed class AddServiceProviderState extends Equatable {
  const AddServiceProviderState();

  @override
  List<Object> get props => [];
}

final class AddServiceProviderInitial extends AddServiceProviderState {}

final class AddServiceProviderLoading extends AddServiceProviderState {}

final class AddServiceProviderSuccess extends AddServiceProviderState {
  final String message;

  const AddServiceProviderSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class AddServiceProviderFailure extends AddServiceProviderState {
  final String error;

  const AddServiceProviderFailure(this.error);

  @override
  List<Object> get props => [error];
}

class ServiceProvidersInitial extends AddServiceProviderState {}

class ServiceProvidersLoading extends AddServiceProviderState {}

class ServiceProvidersLoaded extends AddServiceProviderState {
  final List<GetServicePartnersListModel> serviceProviders;

  const ServiceProvidersLoaded({required this.serviceProviders});

  @override
  List<Object> get props => [serviceProviders];
}

class ServiceProvidersError extends AddServiceProviderState {
  final String message;

  const ServiceProvidersError({required this.message});

  @override
  List<Object> get props => [message];
}