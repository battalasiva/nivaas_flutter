import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class DeleteDebitHistoryDataSource {
  final ApiClient apiClient;

  DeleteDebitHistoryDataSource({required this.apiClient});

  Future<void> deleteDebitHistory(int apartmentId, int itemId) async {
    final endpoint =
        '${ApiUrls.deleteDebitMaintainance}/$apartmentId/debit/$itemId';

    try {
      final response = await apiClient.delete(endpoint);
      print('RESPONSE: ${response.body} $endpoint');

      if (response.statusCode == 200) {
        print('Debit history deleted successfully.');
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
