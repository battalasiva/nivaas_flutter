import 'package:nivaas/data/models/Maintainance/Transaction_history_modal.dart';
import 'package:nivaas/domain/repositories/maintainance/transaction_history_repositoty.dart';

class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase({required this.repository});

  Future<List<Content>> execute({
    required int apartmentId,
    required int page,
    required int size,
    required Map<String, dynamic> appliedFilters,
  }) {
    return repository.getTransactions(
        apartmentId: apartmentId,
        page: page,
        size: size,
        appliedFilters: appliedFilters);
  }
}
