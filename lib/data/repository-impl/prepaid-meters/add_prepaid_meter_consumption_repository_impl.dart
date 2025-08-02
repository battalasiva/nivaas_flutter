import 'package:nivaas/data/provider/network/api/prepaid-meters/add_prepaid_meter_consumption_datasource.dart';
import 'package:nivaas/domain/repositories/prepaid-meters/add_prepaid_meter_consumption_repository.dart';

class AddPrepaidMeterConsumptionRepositoryImpl
    implements AddPrepaidMeterConsumptionRepository {
  final AddPrepaidMeterConsumptionDataSource dataSource;

  AddPrepaidMeterConsumptionRepositoryImpl({required this.dataSource});

  @override
  Future<String> savePrepaidMeter(Map<String, dynamic> payload) {
    return dataSource.savePrepaidMeter(payload);
  }
}
