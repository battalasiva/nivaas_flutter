import 'package:nivaas/data/provider/network/api/coins-subscription/purchase_plan_datasource.dart';
import 'package:nivaas/domain/repositories/coins-subscription/purchase_plan_repository.dart';

class PurchasePlanRepositoryImpl implements PurchasePlanRepository {
  final PurchasePlanDataSource dataSource;

  PurchasePlanRepositoryImpl({required this.dataSource});

  @override
  Future<Map<String, dynamic>> purchasePlan(String apartmentId, int months) async {
    return await dataSource.purchasePlan(apartmentId, months);
  }
}
