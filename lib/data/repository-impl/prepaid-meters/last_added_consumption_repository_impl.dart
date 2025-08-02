import 'package:nivaas/data/models/prepaid-meters/last_added_Consumption_model.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/last_added_consumption_datasource.dart';
import 'package:nivaas/domain/repositories/prepaid-meters/last_added_consumption_repository.dart';

class LastAddedConsumptionRepositoryImpl implements ConsumptionRepository {
  final LastAddedConsumptionDatasource dataSource;

  LastAddedConsumptionRepositoryImpl({required this.dataSource});

  @override
  Future<List<LastAddedConsumptionModal>> getConsumptionData(
      {required int apartmentId, required int prepaidId}) {
    return dataSource.fetchConsumptionData(
        apartmentId: apartmentId, prepaidId: prepaidId);
  }
}
