import 'package:nivaas/data/provider/network/api/services/add_service_provider_datasource.dart';
import 'package:nivaas/domain/repositories/services/add_service_provider_repository.dart';

class AddServiceProviderRepositoryImpl implements AddServiceProviderRepository {
  final AddServiceProviderDataSource dataSource;

  AddServiceProviderRepositoryImpl(this.dataSource);

  @override
  Future<void> addServiceProvider(Map<String, dynamic> payload) async {
    return await dataSource.addServiceProvider(payload);
  }
}
