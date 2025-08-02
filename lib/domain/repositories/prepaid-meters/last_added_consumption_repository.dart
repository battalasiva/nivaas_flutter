import 'package:nivaas/data/models/prepaid-meters/last_added_Consumption_model.dart';

abstract class ConsumptionRepository {
  Future<List<LastAddedConsumptionModal>> getConsumptionData(
      {required int apartmentId, required int prepaidId});
}
