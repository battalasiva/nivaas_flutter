import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'dart:convert';

class UpdateDueDataSource {
  final ApiClient apiClient;

  UpdateDueDataSource({required this.apiClient});

  Future<String> updateDue({
    required String apartmentId,
    required String status,
    required String societyDueIds,
  }) async {
    try {
      final endpoint =
        '${ApiUrls.updateDueStatus}?apartmentId=$apartmentId&status=$status&societyDueIds=$societyDueIds';
    print("endpoint: $endpoint");
    final response = await apiClient.put(endpoint, {});
    print("response: ${response.body}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw ExceptionHandler.handleHttpException(response);
    }
    } catch (e) {
            throw ExceptionHandler.handleError(e);

    }
  }
}
