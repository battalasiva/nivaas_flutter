import 'package:nivaas/domain/repositories/coins-subscription/purchase_plan_repository.dart';

class PurchasePlanUseCase {
  final PurchasePlanRepository repository;

  PurchasePlanUseCase(this.repository);

  Future<Map<String, dynamic>> execute(String apartmentId, int months) async {
    return await repository.purchasePlan(apartmentId, months);
  }
}