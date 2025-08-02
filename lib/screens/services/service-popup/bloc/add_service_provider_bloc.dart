import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/services/GetServicesPartnersListmodal.dart';
import 'package:nivaas/domain/usecases/services/add_service_provider_usecase.dart';
import 'package:nivaas/domain/usecases/services/get_service_providers_list_usecase.dart';

part 'add_service_provider_event.dart';
part 'add_service_provider_state.dart';

class AddServiceProviderBloc extends Bloc<AddServiceProviderEvent, AddServiceProviderState> {
  final AddServiceProviderUseCase useCase;
  final GetServiceProvidersListUseCase getServiceProvidersListUseCase;

  AddServiceProviderBloc(this.useCase,this.getServiceProvidersListUseCase) : super(AddServiceProviderInitial()) {
    on<AddServiceProviderRequested>((event, emit) async {
      emit(AddServiceProviderLoading());
      try {
        await useCase(event.payload);
        emit(AddServiceProviderSuccess("Service Provider added Successfully"));
      } catch (e) {
        emit(AddServiceProviderFailure(e.toString()));
      }
    });
     on<FetchServiceProviders>((event, emit) async {
      emit(ServiceProvidersLoading());
      try {
        final serviceProviders = await getServiceProvidersListUseCase(event.apartmentId, event.categoryId);
        emit(ServiceProvidersLoaded(serviceProviders: serviceProviders));
      } catch (e) {
        emit(ServiceProvidersError(message: e.toString()));
      }
    });
  }
}
