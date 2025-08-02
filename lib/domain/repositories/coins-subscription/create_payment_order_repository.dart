abstract class CreatePaymentOrderRepository {
  Future<Map<String, dynamic>> createPaymentOrder({
    required int apartmentId,
    required String months,
    required String coinsToUse,
  });
}
