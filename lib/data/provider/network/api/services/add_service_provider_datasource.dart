import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class AddServiceProviderDataSource {
  final ApiClient apiClient;
  AddServiceProviderDataSource(this.apiClient);
  Future<void> addServiceProvider(Map<String, dynamic> payload) async {
    try {
      final response = await apiClient.post(
        ApiUrls.addServiceProvider,
        payload,
      );
      print('response: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return; 
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}