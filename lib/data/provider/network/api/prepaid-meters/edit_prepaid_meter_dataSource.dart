import 'dart:convert';

import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class EditPrepaidMeterDatasource {
  final ApiClient apiClient;

  EditPrepaidMeterDatasource(this.apiClient);

  Future<String> editPrepaidMeter(Map<String, dynamic> payload) async {
    try {
      final endpoint = ApiUrls.updateMeterDetails;
      final response = await apiClient.put(endpoint, payload);
      print('EDIT $endpoint');
      print('EDIT PREPAID METER : ${response.body}');

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
