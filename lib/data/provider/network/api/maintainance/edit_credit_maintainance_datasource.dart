import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class EditCreditMaintainanceDataSource {
  final ApiClient apiClient;

  EditCreditMaintainanceDataSource({required this.apiClient});

  Future<void> editCreditMaintainance(
      int itemId, Map<String, dynamic> payload) async {
    try {
      final endpoint = "${ApiUrls.editCreditMaintainence}/$itemId";
      final response = await apiClient.put(endpoint, payload);
      print(payload);
      print(itemId);
      print('CREDIT_EDIT :  ${response.body}');
      if (response.statusCode == 200) {
        print('Successfully updated');
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
