import 'package:nivaas/data/models/prepaid-meters/GetSingleFlatLastAddedConsumptionUnitsModal.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/get_singleFlat_consumption_datasource.dart';
import 'package:nivaas/domain/repositories/prepaid-meters/get_singleFlat_consumption_repository.dart';

class GetSingleFlatConsumptionRepositoryImpl implements GetSingleFlatConsumptionRepository {
  final GetSingleFlatConsumptionDataSource dataSource;

  GetSingleFlatConsumptionRepositoryImpl(this.dataSource);

  @override
  Future<GetSingleFlatLastAddedConsumptionUnitsModal> fetchLastAddedConsumption({
    required int apartmentId,
    required int prepaidId,
    required String flatId,
  }) async {
    return dataSource.fetchLastAddedConsumption(
      apartmentId: apartmentId,
      prepaidId: prepaidId,
      flatId: flatId,
    );
  }
}
