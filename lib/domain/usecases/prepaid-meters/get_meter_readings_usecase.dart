import 'package:nivaas/data/models/prepaid-meters/GetMeterReadingsModal.dart';

import '../../repositories/prepaid-meters/get_meter_readings_repository.dart';

class GetMeterReadingsUseCase {
  final GetMeterReadingsRepository repository;

  GetMeterReadingsUseCase({required this.repository});

  Future<List<GetMeterReadingsModal>> execute(int apartmentId, int prepaidMeterId) {
    return repository.getMeterReadings(apartmentId, prepaidMeterId);
  }
}
