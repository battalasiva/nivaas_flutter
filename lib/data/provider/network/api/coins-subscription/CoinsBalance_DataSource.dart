import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class CoinsBalanceDataSource {
  final ApiClient apiClient;

  CoinsBalanceDataSource({required this.apiClient});

  Future<double> fetchCoinsBalance({required int apartmentId}) async {
    try {
      final endpoint = "${ApiUrls.getCoinsBalance}?apartmentId=$apartmentId";
    print("Endpoint: $endpoint");
    final response = await apiClient.get(endpoint);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw ExceptionHandler.handleHttpException(response);
    }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
