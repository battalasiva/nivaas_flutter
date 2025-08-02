import 'package:nivaas/data/models/Maintainance/Transaction_history_modal.dart';

abstract class FilterTransactionHistoryRepository {
  Future<TransactionHistoryModal> fetchTransactionHistory({
    required int apartmentId,
    required int page,
    required int size,
    required String transactionDate,
  });
}
