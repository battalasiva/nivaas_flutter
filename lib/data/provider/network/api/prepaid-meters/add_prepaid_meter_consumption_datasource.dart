import 'dart:convert';

import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class AddPrepaidMeterConsumptionDataSource {
  final ApiClient apiClient;

  AddPrepaidMeterConsumptionDataSource(this.apiClient);

  Future<String> savePrepaidMeter(Map<String, dynamic> payload) async {
    try {
      final endpoint = ApiUrls.addPrepaidMeters;
      final response = await apiClient.post(endpoint, payload);
      print(endpoint);
      print('PAYLOAD : $payload');
      print('PREPAID SAVE : ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        return decodedResponse['message'] ?? 'Success';
      } else {
        // final decodedResponse = json.decode(response.body);
        // return decodedResponse['message'] ?? 'An error occurred';
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
