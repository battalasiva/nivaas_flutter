abstract class PurchasePlanPaymentRepository {
  Future<Map<String, dynamic>> purchasePlanPayment(String apartmentId, int months,String paymentId);
}
