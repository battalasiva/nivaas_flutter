abstract class PurchasePlanRepository {
  Future<Map<String, dynamic>> purchasePlan(String apartmentId, int months);
}
