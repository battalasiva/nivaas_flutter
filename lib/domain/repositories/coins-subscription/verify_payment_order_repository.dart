abstract class VerifyPaymentOrderRepository {
  Future<Map<String, dynamic>> verifyPaymentOrder({
    required String paymentId,
    required String orderId,
    required String signature,
  });
}
