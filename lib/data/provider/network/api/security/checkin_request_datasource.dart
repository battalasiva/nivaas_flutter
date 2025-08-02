import 'dart:convert';

import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/constants/api_urls.dart';
import '../../../../../core/error/exception_handler.dart';

class CheckinRequestDatasource {
  final ApiClient apiClient;

  CheckinRequestDatasource({required this.apiClient});

  Future<bool> sendCheckinRequest(int apartmentId, int flatId, String type, String name, String mobileNumber) async {
    Map<String, dynamic> payload;

      payload = {
        "apartmentId": apartmentId,
        "flatId": flatId,
        "type": type,
        "visitors": [
          {
            "name": name,
            "number": mobileNumber
          }
        ]
      };
      try {
        final response = await apiClient.post(ApiUrls.checkinRequest, payload);
        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          return responseBody['status'] == 'success';
        } else {
          throw ExceptionHandler.handleHttpException(response);
        }
      } catch (e) {
        throw ExceptionHandler.handleError(e);
      }
  }
}