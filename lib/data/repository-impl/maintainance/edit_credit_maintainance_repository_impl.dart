import 'package:nivaas/data/provider/network/api/maintainance/edit_credit_maintainance_datasource.dart';
import 'package:nivaas/domain/repositories/maintainance/edit_credit_maintainance_repository.dart';

class EditCreditMaintainanceRepositoryImpl
    implements EditCreditMaintainanceRepository {
  final EditCreditMaintainanceDataSource dataSource;

  EditCreditMaintainanceRepositoryImpl({required this.dataSource});

  @override
  Future<void> editCreditMaintainance(
      int itemId, Map<String, dynamic> payload) {
    return dataSource.editCreditMaintainance(itemId, payload);
  }
}
