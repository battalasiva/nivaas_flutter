import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class RaiseComplaintDataSource {
  final ApiClient apiClient;

  RaiseComplaintDataSource({required this.apiClient});

  Future<String> raiseComplaint(Map<String, dynamic> payload) async {
    try {
      final response = await apiClient.post(ApiUrls.RaiseComplaint, payload);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
