import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class UpdateGuestStatusDataSource {
  final ApiClient apiClient;

  UpdateGuestStatusDataSource(this.apiClient);

  Future<String> updateGuestStatus(int id, String status) async {
    final endpoint = "${ApiUrls.updateGuestStatus}/$id?status=$status";
    print('UPDATE GUEST SATUS : $endpoint $id $status');
    try {
      final response = await apiClient.put(endpoint, {});
      print('UPDATE GUEST SATUS : ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Status updated successfully';
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
