import 'package:nivaas/data/models/prepaid-meters/GetSingleFlatLastAddedConsumptionUnitsModal.dart';
import 'package:nivaas/domain/repositories/prepaid-meters/get_singleFlat_consumption_repository.dart';

class GetSingleFlatLastAddedConsumptionUseCase {
  final GetSingleFlatConsumptionRepository repository;

  GetSingleFlatLastAddedConsumptionUseCase(this.repository);

  Future<GetSingleFlatLastAddedConsumptionUnitsModal> call({
    required int apartmentId,
    required int prepaidId,
    required String flatId,
  }) {
    return repository.fetchLastAddedConsumption(
      apartmentId: apartmentId,
      prepaidId: prepaidId,
      flatId: flatId,
    );
  }
}
