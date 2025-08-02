import 'package:nivaas/data/provider/network/api/maintainance/edit_debit_maintainance_dataSource.dart';
import 'package:nivaas/domain/repositories/maintainance/edit_debit_maintainance_repository.dart';

class EditDebitMaintainanceRepositoryImpl
    implements EditDebitMaintainanceRepository {
  final EditDebitMaintainanceDataSource dataSource;

  EditDebitMaintainanceRepositoryImpl({required this.dataSource});

  @override
  Future<void> editDebitMaintainance(int itemId, Map<String, dynamic> payload) {
    return dataSource.editDebitMaintainance(itemId, payload);
  }
}
