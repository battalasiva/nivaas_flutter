import 'package:nivaas/data/models/prepaid-meters/GetSingleMeterReadings.dart';

abstract class GetSingleMeterReadingsRepository {
  Future<GetSingleFlatReadingsModal> getSingleFlatReadings({
    required int apartmentId,
    required int prepaidMeterId,
    required int flatId,
  });
}
