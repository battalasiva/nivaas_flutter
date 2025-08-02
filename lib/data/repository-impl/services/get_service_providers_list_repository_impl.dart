import 'package:nivaas/data/models/services/GetServicesPartnersListmodal.dart';
import 'package:nivaas/data/provider/network/api/services/get_service_providers_list_datasource.dart';
import 'package:nivaas/domain/repositories/services/get_service_providers_list_repository.dart';


class GetServiceProvidersListRepositoryImpl implements GetServiceProvidersListRepository {
  final GetServiceProvidersListDataSource dataSource;

  GetServiceProvidersListRepositoryImpl(this.dataSource);

  @override
  Future<List<GetServicePartnersListModel>> getServiceProviders(int apartmentId, int categoryId) {
    return dataSource.fetchServiceProviders(apartmentId, categoryId);
  }
}
