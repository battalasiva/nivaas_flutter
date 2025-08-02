import 'package:nivaas/data/models/coins-subscription/subscription_plans_model.dart';
import 'package:nivaas/data/provider/network/api/coins-subscription/subscription_data_source.dart';
import 'package:nivaas/domain/repositories/coins-subscription/subscription_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionDataSource _dataSource;

  SubscriptionRepositoryImpl({required SubscriptionDataSource dataSource})
      : _dataSource = dataSource;
  @override
  Future<SubscriptionPlansModal> getSubscriptionPlans(int customerId) async {
    return await _dataSource.fetchSubscriptionPlans(customerId);
  }
}
