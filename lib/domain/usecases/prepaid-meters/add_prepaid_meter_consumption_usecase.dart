import 'package:nivaas/domain/repositories/prepaid-meters/add_prepaid_meter_consumption_repository.dart';

class AddPrepaidMeterConsumptionUseCase {
  final AddPrepaidMeterConsumptionRepository repository;

  AddPrepaidMeterConsumptionUseCase({required this.repository});

  Future<String> addPrepaidMeter(Map<String, dynamic> payload) {
    return repository.savePrepaidMeter(payload);
  }
}
