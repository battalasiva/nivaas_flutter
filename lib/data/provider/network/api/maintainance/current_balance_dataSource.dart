import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/Maintainance/current_balance_Modal.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class CurrentBalanceDataSource {
  final ApiClient apiClient;

  CurrentBalanceDataSource({required this.apiClient});

  Future<CurrentBalanceModal> fetchCurrentBalance(int apartmentId) async {
    try {
      final response = await apiClient.get(
        '${ApiUrls.getCurrentBalance}/$apartmentId',
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CurrentBalanceModal.fromJson(data);
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
