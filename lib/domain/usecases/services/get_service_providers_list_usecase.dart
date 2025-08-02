import 'package:nivaas/data/models/services/GetServicesPartnersListmodal.dart';
import 'package:nivaas/domain/repositories/services/get_service_providers_list_repository.dart';

class GetServiceProvidersListUseCase {
  final GetServiceProvidersListRepository repository;

  GetServiceProvidersListUseCase(this.repository);

  Future<List<GetServicePartnersListModel>> call(int apartmentId, int categoryId) {
    return repository.getServiceProviders(apartmentId, categoryId);
  }
}
