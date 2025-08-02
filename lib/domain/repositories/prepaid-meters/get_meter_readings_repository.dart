import 'package:nivaas/data/models/prepaid-meters/GetMeterReadingsModal.dart';

abstract class GetMeterReadingsRepository {
  Future<List<GetMeterReadingsModal>> getMeterReadings(int apartmentId, int prepaidMeterId);
}
