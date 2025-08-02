import 'package:nivaas/domain/repositories/maintainance/add_debit_history_repository.dart';

class PostDebitHistoryUseCase {
  final AddDebitMaintainanceRepository repository;

  PostDebitHistoryUseCase({required this.repository});

  Future<String> call(int apartmentId, String amount, String description,
      String transactionDate, String type) async {
    return await repository.postAddDebitMaintainance(
        apartmentId, amount, description, transactionDate, type);
  }
}
