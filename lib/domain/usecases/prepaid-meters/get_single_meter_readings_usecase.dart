import 'package:nivaas/data/models/prepaid-meters/GetSingleMeterReadings.dart';
import 'package:nivaas/domain/repositories/prepaid-meters/get_single_meter_readings_repository.dart';


class GetSingleMeterReadingsUseCase {
  final GetSingleMeterReadingsRepository repository;

  GetSingleMeterReadingsUseCase(this.repository);

  Future<GetSingleFlatReadingsModal> call({
    required int apartmentId,
    required int prepaidMeterId,
    required int flatId,
  }) {
    return repository.getSingleFlatReadings(
        apartmentId: apartmentId,
        prepaidMeterId: prepaidMeterId,
        flatId: flatId);
  }
}
