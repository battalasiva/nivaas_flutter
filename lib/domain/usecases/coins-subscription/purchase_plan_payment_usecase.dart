import 'package:nivaas/domain/repositories/coins-subscription/purchase_plan_payment_repository.dart';

class PurchasePlanPaymentUseCase {
  final PurchasePlanPaymentRepository repository;

  PurchasePlanPaymentUseCase(this.repository);

  Future<Map<String, dynamic>> execute(String apartmentId, int months,String paymentId) async {
    return await repository.purchasePlanPayment(apartmentId, months,paymentId);
  }
}