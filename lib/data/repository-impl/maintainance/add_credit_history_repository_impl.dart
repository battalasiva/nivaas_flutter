import 'package:nivaas/data/provider/network/api/maintainance/add_credit_history_dataSource.dart';
import 'package:nivaas/domain/repositories/maintainance/add_credit_history_repository.dart';

class AddCreditMaintainanceRepositoryImpl
    implements AddCreditMaintainanceRepository {
  final AddCreditMaintainanceDataSource dataSource;

  AddCreditMaintainanceRepositoryImpl({required this.dataSource});

  @override
  Future<String> postAddCreditMaintainance(Map<String, dynamic> payload) async {
    return await dataSource.postAddCreditMaintainance(payload);
  }
}
