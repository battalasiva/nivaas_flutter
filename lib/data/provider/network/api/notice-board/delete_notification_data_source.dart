import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class DeleteNotificationDatasource {
  final ApiClient apiClient;

  DeleteNotificationDatasource({required this.apiClient});

  Future<void> clearAllNotifications() async {
    try {
      final response = await apiClient.delete(ApiUrls.clearallNotifications);
      print("DELETE NOTIFICATIONS : ${response.body}");
      if (response.statusCode != 200) {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
