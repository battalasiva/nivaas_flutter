import 'dart:convert';

import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/prepaid-meters/GetSingleMeterReadings.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class GetSingleMeterReadingsDataSource {
  final ApiClient apiClient;

  GetSingleMeterReadingsDataSource(this.apiClient);

  Future<GetSingleFlatReadingsModal> fetchSingleFlatReadings({
    required int apartmentId,
    required int prepaidMeterId,
    required int flatId,
  }) async {
    try {
      final endpoint =
          '${ApiUrls.getMeterReadings}/$apartmentId/prepaid/$prepaidMeterId/flat/$flatId';

      final response = await apiClient.get(endpoint);
      print('SINGLE METER READINGS : ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return GetSingleFlatReadingsModal.fromJson(data);
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
