part of 'add_service_provider_bloc.dart';

sealed class AddServiceProviderEvent extends Equatable {
  const AddServiceProviderEvent();

  @override
  List<Object> get props => [];
}

class AddServiceProviderRequested extends AddServiceProviderEvent {
  final Map<String, dynamic> payload;

  const AddServiceProviderRequested(this.payload);

  @override
  List<Object> get props => [payload];
}
class FetchServiceProviders extends AddServiceProviderEvent {
  final int apartmentId;
  final int categoryId;

  const FetchServiceProviders({required this.apartmentId, required this.categoryId});

  @override
  List<Object> get props => [apartmentId, categoryId];
}