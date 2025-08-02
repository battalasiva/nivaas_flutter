import 'dart:convert';

import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/prepaid-meters/GetSingleFlatLastAddedConsumptionUnitsModal.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class GetSingleFlatConsumptionDataSource {
  final ApiClient apiClient;

  GetSingleFlatConsumptionDataSource(this.apiClient);

  Future<GetSingleFlatLastAddedConsumptionUnitsModal> fetchLastAddedConsumption({
    required int apartmentId,
    required int prepaidId,
    required String flatId,
  }) async {
    final url = '${ApiUrls.lastAddedConsumptionUnits}/$apartmentId/prepaid/$prepaidId/flat/$flatId';

    try {
      final response = await apiClient.get(url);
      print({'RESPONCE : ${response.body}'});
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return GetSingleFlatLastAddedConsumptionUnitsModal.fromJson(jsonResponse);
      } else {
       throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
