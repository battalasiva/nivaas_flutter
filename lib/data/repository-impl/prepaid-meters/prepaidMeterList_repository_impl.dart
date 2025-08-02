import 'package:nivaas/data/models/prepaid-meters/PrepaidMetersList.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/prepaidMeter_list_data_source.dart';
import 'package:nivaas/domain/repositories/prepaid-meters/prepaidMeter_list_repository.dart';
class PrepaidMeterListRepositoryImpl implements PrepaidMeterListRepository {
  final PrepaidMeterListDataSource datasource;

  PrepaidMeterListRepositoryImpl({required this.datasource});

  @override
  Future<dynamic> getPrepaidMeters({
    required int apartmentId,
    required int pageNo,
    required int pageSize,
  }) {
    return datasource.fetchPrepaidMeters(
      apartmentId: apartmentId,
      pageNo: pageNo,
      pageSize: pageSize,
    );
  }
}
