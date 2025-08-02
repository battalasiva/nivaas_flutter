import 'package:nivaas/data/provider/network/api/coins-subscription/create_payment_order_datasource.dart';
import 'package:nivaas/domain/repositories/coins-subscription/create_payment_order_repository.dart';


class CreatePaymentOrderRepositoryImpl implements CreatePaymentOrderRepository {
  final CreatePaymentOrderDataSource dataSource;

  CreatePaymentOrderRepositoryImpl({required this.dataSource});

  @override
  Future<Map<String, dynamic>> createPaymentOrder({
    required int apartmentId,
    required String months,
    required String coinsToUse,
  }) {
    return dataSource.createPaymentOrder(
      apartmentId: apartmentId,
      months: months,
      coinsToUse: coinsToUse,
    );
  }
}
