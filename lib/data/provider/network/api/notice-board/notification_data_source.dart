import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/notice-board/get_notifications_Model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class GetNotificationsDataSource {
  final ApiClient apiClient;

  GetNotificationsDataSource({required this.apiClient});

  Future<GetNotificationsModal> fetchNotifications(
      int pageNo, int pageSize) async {
    try {
      final endpoint =
          '${ApiUrls.getnotifications}?pageNo=$pageNo&pageSize=$pageSize';
      final response = await apiClient.get(endpoint);

      if (response.statusCode == 200) {
        return GetNotificationsModal.fromJson(jsonDecode(response.body));
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
