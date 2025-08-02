import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/Maintainance/Transaction_history_modal.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class FilterTransactionHistoryDatasource {
  final ApiClient apiClient;

  FilterTransactionHistoryDatasource({required this.apiClient});

  Future<TransactionHistoryModal> fetchTransactionHistory({
    required int apartmentId,
    required int page,
    required int size,
    required String transactionDate,
  }) async {
    try {
      final endpoint =
          "${ApiUrls.transactionHistory}/$apartmentId?page=$page&size=$size";
      final payload = {
        "filters": [
          {
            "field": "transactionDate",
            "value": transactionDate,
            "operator": "EQUAL_TO"
          }
        ]
      };

      final response = await apiClient.post(endpoint, payload);
      print('PAYLOAD : ${payload} ${endpoint}');
      print('RESPONCE : ${response.body}');
      if (response.statusCode == 200) {
        return TransactionHistoryModal.fromJson(jsonDecode(response.body));
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
