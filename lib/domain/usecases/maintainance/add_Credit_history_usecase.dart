import 'package:nivaas/domain/repositories/maintainance/add_credit_history_repository.dart';

class PostCreditHistoryUseCase {
  final AddCreditMaintainanceRepository repository;

  PostCreditHistoryUseCase(this.repository);

  Future<String> call(Map<String, dynamic> payload) async {
    return await repository.postAddCreditMaintainance(payload);
  }
}
