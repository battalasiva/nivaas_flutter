import 'dart:convert';

import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/prepaid-meters/last_added_Consumption_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class LastAddedConsumptionDatasource {
  final ApiClient apiClient;

  LastAddedConsumptionDatasource({required this.apiClient});

  Future<List<LastAddedConsumptionModal>> fetchConsumptionData({
    required int apartmentId,
    required int prepaidId,
  }) async {
    final endpoint = '${ApiUrls.lastAddedConsumptionUnits}/$apartmentId/prepaid/$prepaidId/list';

    try {
      final response = await apiClient.get(endpoint);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData
            .map((json) => LastAddedConsumptionModal.fromJson(json))
            .toList();
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
