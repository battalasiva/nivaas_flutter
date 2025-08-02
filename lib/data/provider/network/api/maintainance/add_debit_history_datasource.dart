import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class AddDebitMaintainanceDataSource {
  final ApiClient apiClient;

  AddDebitMaintainanceDataSource({required this.apiClient});

  Future<String> postAddDebitMaintainance(int apartmentId, String amount,
      String description, String transactionDate, String type) async {
    try {
      final response = await apiClient.post(ApiUrls.addDebitMaintainance, {
      "apartmentId": apartmentId,
      "amount": amount,
      "description": description,
      "transactionDate": transactionDate,
      "type": type  
    });
    print('RESPONCE : ${response.body}');
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
