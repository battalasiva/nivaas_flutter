import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class CreatePaymentOrderDataSource {
  final ApiClient apiClient;

  CreatePaymentOrderDataSource({required this.apiClient});

  Future<Map<String, dynamic>> createPaymentOrder({
    required int apartmentId,
    required String months,
    required String coinsToUse,
  }) async {
    final endpoint = ApiUrls.createOrderUrl(apartmentId, months, coinsToUse);
    try {
      final response = await apiClient.post(endpoint, {});
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Order created successfully',
          'data': response.body,
        };
      } else {
        return {
          'success': false,
          'message': 'Order creation failed: ${response.reasonPhrase}',
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
