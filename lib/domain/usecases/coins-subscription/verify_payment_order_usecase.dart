import 'package:nivaas/domain/repositories/coins-subscription/verify_payment_order_repository.dart';

class VerifyPaymentOrderUseCase {
  final VerifyPaymentOrderRepository repository;

  VerifyPaymentOrderUseCase(this.repository);

  Future<Map<String, dynamic>> call({
    required String paymentId,
    required String orderId,
    required String signature,
  }) {
    return repository.verifyPaymentOrder(
      paymentId: paymentId,
      orderId: orderId,
      signature: signature,
    );
  }
}
