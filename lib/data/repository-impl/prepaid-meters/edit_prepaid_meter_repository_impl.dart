import 'package:nivaas/data/provider/network/api/prepaid-meters/edit_prepaid_meter_dataSource.dart';
import 'package:nivaas/domain/repositories/prepaid-meters/edit_prepaid_meter_repoasitory.dart';

class EditPrepaidMeterRepositoryImpl
    implements EditPrepaidMeterRepoasitory {
  final EditPrepaidMeterDatasource dataSource;

  EditPrepaidMeterRepositoryImpl({required this.dataSource});

  @override
  Future<String> editPrepaidMeter(Map<String, dynamic> payload) {
    return dataSource.editPrepaidMeter(payload);
  }
}
