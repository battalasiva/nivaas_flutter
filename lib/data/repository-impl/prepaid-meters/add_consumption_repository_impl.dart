import 'package:nivaas/data/provider/network/api/prepaid-meters/add_consumption_datasource.dart';
import 'package:nivaas/domain/repositories/prepaid-meters/add_consumption_repository.dart';

class AddConsumptionRepositoryImpl implements AddConsumptionRepository {
  final AddConsumptionDataSource dataSource;

  AddConsumptionRepositoryImpl({required this.dataSource});

  @override
  Future<String> submitConsumptionData(Map<String, dynamic> payload) {
    return dataSource.submitConsumptionData(payload);
  }
}
