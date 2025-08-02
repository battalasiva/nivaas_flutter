import 'package:nivaas/data/models/prepaid-meters/GetSingleFlatLastAddedConsumptionUnitsModal.dart';

abstract class GetSingleFlatConsumptionRepository {
  Future<GetSingleFlatLastAddedConsumptionUnitsModal> fetchLastAddedConsumption({
    required int apartmentId,
    required int prepaidId,
    required String flatId,
  });
}
