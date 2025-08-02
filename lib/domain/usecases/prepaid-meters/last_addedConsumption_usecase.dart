import 'package:nivaas/data/models/prepaid-meters/last_added_Consumption_model.dart';
import 'package:nivaas/domain/repositories/prepaid-meters/last_added_consumption_repository.dart';

class LastAddedConsumptionUseCase {
  final ConsumptionRepository repository;

  LastAddedConsumptionUseCase({required this.repository});

  Future<List<LastAddedConsumptionModal>> call(
      {required int apartmentId, required int prepaidId}) {
    return repository.getConsumptionData(
        apartmentId: apartmentId, prepaidId: prepaidId);
  }
}
