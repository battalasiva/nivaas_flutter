import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/apartmentOnboarding/my_request_modal.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class MyRequestsDataSource {
  final ApiClient apiClient;

  MyRequestsDataSource(this.apiClient);

  Future<List<MyRequestModal>> fetchMyRequests(String type) async {
    try {
      final response =
          await apiClient.get('/customer/onboarding/my-requests?type=$type');
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => MyRequestModal.fromJson(e)).toList();
      } else {
        // throw Exception('Failed to load My Requests');
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
