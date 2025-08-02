import 'package:nivaas/data/models/Maintainance/Transaction_history_modal.dart';
import 'package:nivaas/domain/repositories/maintainance/filter_transaction_history_repository.dart';

class FilterTransactionHistoryUseCase {
  final FilterTransactionHistoryRepository repository;

  FilterTransactionHistoryUseCase({required this.repository});

  Future<TransactionHistoryModal> execute({
    required int apartmentId,
    required int page,
    required int size,
    required String transactionDate,
  }) async {
    return await repository.fetchTransactionHistory(
      apartmentId: apartmentId,
      page: page,
      size: size,
      transactionDate: transactionDate,
    );
  }
}
