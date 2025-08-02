import 'package:nivaas/domain/repositories/services/add_service_provider_repository.dart';

class AddServiceProviderUseCase {
  final AddServiceProviderRepository repository;

  AddServiceProviderUseCase(this.repository);

  Future<void> call(Map<String, dynamic> payload) async {
    return await repository.addServiceProvider(payload);
  }
}
