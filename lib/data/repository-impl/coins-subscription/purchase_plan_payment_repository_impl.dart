import 'package:nivaas/data/provider/network/api/coins-subscription/purchase_plan_payment_datasource.dart';
import 'package:nivaas/domain/repositories/coins-subscription/purchase_plan_payment_repository.dart';

class PurchasePlanPaymentRepositoryImpl implements PurchasePlanPaymentRepository {
  final PurchasePlanPaymentDataSource dataSource;

  PurchasePlanPaymentRepositoryImpl({required this.dataSource});

  @override
  Future<Map<String, dynamic>> purchasePlanPayment(String apartmentId, int months,String paymentId) async {
    return await dataSource.purchasePlanPayment(apartmentId, months,paymentId);
  }
}