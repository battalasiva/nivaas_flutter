import 'package:nivaas/domain/repositories/coins-subscription/create_payment_order_repository.dart';

class CreatePaymentOrderUseCase {
  final CreatePaymentOrderRepository repository;

  CreatePaymentOrderUseCase(this.repository);

  Future<Map<String, dynamic>> call({
    required int apartmentId,
    required String months,
    required String coinsToUse,
  }) {
    return repository.createPaymentOrder(
      apartmentId: apartmentId,
      months: months,
      coinsToUse: coinsToUse,
    );
  }
}
