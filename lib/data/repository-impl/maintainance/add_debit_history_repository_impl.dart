import 'package:nivaas/data/provider/network/api/maintainance/add_debit_history_datasource.dart';
import 'package:nivaas/domain/repositories/maintainance/add_debit_history_repository.dart';

class AddDebitMaintainanceRepositoryImpl implements AddDebitMaintainanceRepository {
  final AddDebitMaintainanceDataSource dataSource;

  AddDebitMaintainanceRepositoryImpl({required this.dataSource});

  @override
  Future<String> postAddDebitMaintainance(int apartmentId, String amount,
      String description, String transactionDate, String type) async {
    return await dataSource.postAddDebitMaintainance(
        apartmentId, amount, description, transactionDate, type);
  }
}