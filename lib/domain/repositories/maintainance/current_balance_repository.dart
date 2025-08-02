import 'package:nivaas/data/models/Maintainance/current_balance_Modal.dart';

abstract class CurrentBalanceRepository {
  Future<CurrentBalanceModal> getCurrentBalance(int apartmentId);
}
