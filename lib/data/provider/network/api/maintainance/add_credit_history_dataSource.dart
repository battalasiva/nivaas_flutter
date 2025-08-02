import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class AddCreditMaintainanceDataSource {
  final ApiClient apiClient;

  AddCreditMaintainanceDataSource({required this.apiClient});

  Future<String> postAddCreditMaintainance(Map<String, dynamic> payload) async {
    try {
      final response =
        await apiClient.post(ApiUrls.addCreditMaintainance, payload);
    print('ApiUrls.addCreditMaintainance: ${ApiUrls.addCreditMaintainance}');
    print('payload: $payload');
    print('response: ${response.body}');
    if (response.statusCode == 200) {
      return 'Transaction Added successfully';
    } else {
     throw ExceptionHandler.handleHttpException(response);
    }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
