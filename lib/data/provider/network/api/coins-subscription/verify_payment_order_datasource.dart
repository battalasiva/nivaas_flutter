import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class VerifyPaymentOrderDataSource {
  final ApiClient apiClient;

  VerifyPaymentOrderDataSource(this.apiClient);

  Future<Map<String, dynamic>> verifyPaymentOrder({
    required String paymentId,
    required String orderId,
    required String signature,
  }) async {
    final endpoint = ApiUrls.verifyPaymentOrderUrl(paymentId, orderId, signature);
    print('Endpoint: $endpoint');
    try {
      final response = await apiClient.post(endpoint, {});
      print('Response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        final data = response.body.isNotEmpty ? response.body : '{}';
        return {
          'success': true,
          'message': 'Verification successful',
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': 'Verification failed: ${response.reasonPhrase}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }
}
