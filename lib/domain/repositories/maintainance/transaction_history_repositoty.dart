import 'package:nivaas/data/models/Maintainance/Transaction_history_modal.dart';

abstract class TransactionRepository {
  Future<List<Content>> getTransactions(
      {required int apartmentId,
      required int page,
      required int size,
      required Map<String, dynamic> appliedFilters});
}
