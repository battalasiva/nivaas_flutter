import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/prepaid-meters/PrepaidMetersList.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class PrepaidMeterListDataSource {
  final ApiClient apiClient;

  PrepaidMeterListDataSource({required this.apiClient});

  Future<dynamic> fetchPrepaidMeters({
    required int apartmentId,
    required int pageNo,
    required int pageSize,
  }) async {
    try {
      final response = await apiClient.get(
      "${ApiUrls.getPrepaidMetersList}?apartmentId=$apartmentId&pageNo=$pageNo&pageSize=$pageSize",
    );

    if (response.statusCode == 200) {
      final metersData = jsonDecode(response.body);
      return PrepaidMetersListModal.fromJson(metersData);
    } else {
      final errorBody = jsonDecode(response.body);
      return {
        "errorCode": errorBody["errorCode"] ?? response.statusCode,
        "errorMessage": errorBody["errorMessage"] ?? "Something went wrong",
      };
              // throw ExceptionHandler.handleHttpException(response);
    }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
