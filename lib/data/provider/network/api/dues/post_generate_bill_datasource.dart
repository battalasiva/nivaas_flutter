import 'dart:convert';

import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class PostGenerateBillDataSource {
  final ApiClient apiClient;

  PostGenerateBillDataSource(this.apiClient);

  Future<String> generateBill(Map<String, dynamic> payload) async {
    try {
      final endpoint = ApiUrls.generateBill;
    final response = await apiClient.post(endpoint, payload);
    print('RESPONCE OF GENERATE BILL : ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message']; 
    } else {
      throw ExceptionHandler.handleHttpException(response);
    }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
