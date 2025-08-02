import 'dart:convert';

import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class AddConsumptionDataSource {
  final String endpoint = ApiUrls.updateConsumptionUnits;
  final ApiClient apiClient;

  AddConsumptionDataSource(this.apiClient);

  Future<String> submitConsumptionData(Map<String, dynamic> payload) async {
    try {
      final response = await apiClient.post(endpoint, payload);
      print('RESPONCE : ${response.body}');
      print(endpoint);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Success';
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
