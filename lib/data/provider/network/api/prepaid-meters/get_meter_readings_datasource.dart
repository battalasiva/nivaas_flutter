import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/prepaid-meters/GetMeterReadingsModal.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class GetMeterReadingsDataSource {
  final ApiClient apiClient;

  GetMeterReadingsDataSource(this.apiClient);

  Future<List<GetMeterReadingsModal>> fetchMeterReadings(int apartmentId, int prepaidMeterId) async {
    final endpoint = '${ApiUrls.getMeterReadings}/$apartmentId/prepaid/$prepaidMeterId/list';
    
    try {
      final response = await apiClient.get(endpoint);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => GetMeterReadingsModal.fromJson(json)).toList();
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
