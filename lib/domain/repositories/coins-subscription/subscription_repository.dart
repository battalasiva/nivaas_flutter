import 'package:nivaas/data/models/coins-subscription/subscription_plans_model.dart';

abstract class SubscriptionRepository {
  Future<SubscriptionPlansModal> getSubscriptionPlans(int customerId);
}
