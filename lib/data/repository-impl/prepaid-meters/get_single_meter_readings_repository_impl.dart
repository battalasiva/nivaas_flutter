import 'package:nivaas/data/models/prepaid-meters/GetSingleMeterReadings.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/get_single_meter_readings_datasource.dart';
import 'package:nivaas/domain/repositories/prepaid-meters/get_single_meter_readings_repository.dart';

class GetSingleMeterReadingsRepositoryImpl
    implements GetSingleMeterReadingsRepository {
  final GetSingleMeterReadingsDataSource dataSource;

  GetSingleMeterReadingsRepositoryImpl(this.dataSource);

  @override
  Future<GetSingleFlatReadingsModal> getSingleFlatReadings({
    required int apartmentId,
    required int prepaidMeterId,
    required int flatId,
  }) {
    return dataSource.fetchSingleFlatReadings(
        apartmentId: apartmentId,
        prepaidMeterId: prepaidMeterId,
        flatId: flatId);
  }
}
