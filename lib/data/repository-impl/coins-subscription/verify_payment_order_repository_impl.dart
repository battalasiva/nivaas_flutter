import 'package:nivaas/data/provider/network/api/coins-subscription/verify_payment_order_datasource.dart';
import 'package:nivaas/domain/repositories/coins-subscription/verify_payment_order_repository.dart';

class VerifyPaymentOrderRepositoryImpl implements VerifyPaymentOrderRepository {
  final VerifyPaymentOrderDataSource dataSource;

  VerifyPaymentOrderRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> verifyPaymentOrder({
    required String paymentId,
    required String orderId,
    required String signature,
  }) {
    return dataSource.verifyPaymentOrder(
      paymentId: paymentId,
      orderId: orderId,
      signature: signature,
    );
  }
}
