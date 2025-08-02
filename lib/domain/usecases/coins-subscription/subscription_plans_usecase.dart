import 'package:nivaas/data/models/coins-subscription/subscription_plans_model.dart';
import 'package:nivaas/domain/repositories/coins-subscription/subscription_repository.dart';

class GetSubscriptionPlansUseCase {
  final SubscriptionRepository _repository;

  GetSubscriptionPlansUseCase(this._repository);

  Future<SubscriptionPlansModal> call(int customerId) async {
    return await _repository.getSubscriptionPlans(customerId);
  }
}
