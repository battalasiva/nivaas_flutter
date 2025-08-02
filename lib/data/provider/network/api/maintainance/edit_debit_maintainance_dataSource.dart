import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class EditDebitMaintainanceDataSource {
  final ApiClient apiClient;

  EditDebitMaintainanceDataSource({required this.apiClient});

  Future<void> editDebitMaintainance(
      int itemId, Map<String, dynamic> payload) async {
    try {
      final endpoint = "${ApiUrls.editDebitMaintainance}/$itemId";
    final response = await apiClient.put(endpoint, payload);
    print(payload);
    print(itemId);
    print('Debit_EDIT :  ${response.body}');
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
