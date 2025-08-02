import 'package:nivaas/data/models/Maintainance/Transaction_history_modal.dart';
import 'package:nivaas/data/provider/network/api/maintainance/filter_transaction_history_datasource.dart';
import 'package:nivaas/domain/repositories/maintainance/filter_transaction_history_repository.dart';

class FilterTransactionHistoryRepositoryImpl
    implements FilterTransactionHistoryRepository {
  final FilterTransactionHistoryDatasource dataSource;

  FilterTransactionHistoryRepositoryImpl({required this.dataSource});

  @override
  Future<TransactionHistoryModal> fetchTransactionHistory({
    required int apartmentId,
    required int page,
    required int size,
    required String transactionDate,
  }) async {
    return await dataSource.fetchTransactionHistory(
      apartmentId: apartmentId,
      page: page,
      size: size,
      transactionDate: transactionDate,
    );
  }
}
