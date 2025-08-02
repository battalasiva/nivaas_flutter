import 'package:nivaas/data/models/Maintainance/Transaction_history_modal.dart';
import 'package:nivaas/data/provider/network/api/maintainance/transaction_history_datasource.dart';
import 'package:nivaas/domain/repositories/maintainance/transaction_history_repositoty.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDataSource dataSource;

  TransactionRepositoryImpl({required this.dataSource});

  @override
  Future<List<Content>> getTransactions(
      {required int apartmentId,
      required int page,
      required int size,
      required Map<String, dynamic> appliedFilters}) async {
    final response = await dataSource.fetchTransactions(
        apartmentId: apartmentId,
        page: page,
        size: size,
        appliedFilters: appliedFilters);
    print('REPOSITORY_IMPL${response.content}');
    return response.content ?? [];
  }
}
