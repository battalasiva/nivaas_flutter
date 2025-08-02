import 'package:nivaas/domain/repositories/prepaid-meters/add_consumption_repository.dart';

class AddConsumptionUseCase {
  final AddConsumptionRepository repository;

  AddConsumptionUseCase({required this.repository});

  Future<String> call(Map<String, dynamic> payload) {
    return repository.submitConsumptionData(payload);
  }
}
