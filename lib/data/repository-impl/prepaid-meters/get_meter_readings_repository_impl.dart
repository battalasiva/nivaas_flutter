import 'package:nivaas/data/models/prepaid-meters/GetMeterReadingsModal.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/get_meter_readings_datasource.dart';

import '../../../domain/repositories/prepaid-meters/get_meter_readings_repository.dart';

class GetMeterReadingsRepositoryImpl implements GetMeterReadingsRepository {
  final GetMeterReadingsDataSource dataSource;

  GetMeterReadingsRepositoryImpl({required this.dataSource});

  @override
  Future<List<GetMeterReadingsModal>> getMeterReadings(int apartmentId, int prepaidMeterId) {
    return dataSource.fetchMeterReadings(apartmentId, prepaidMeterId);
  }
}
