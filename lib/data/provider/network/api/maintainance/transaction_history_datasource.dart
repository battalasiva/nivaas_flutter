import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/Maintainance/Transaction_history_modal.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class TransactionDataSource {
  final ApiClient apiClient;

  TransactionDataSource({required this.apiClient});

  Future<TransactionHistoryModal> fetchTransactions(
      {required int apartmentId,
      required int page,
      required int size,
      required Map<String, dynamic> appliedFilters}) async {
    try {
      const endpoint = ApiUrls.transactionHistory;
      final response = await apiClient.post(
          '$endpoint/$apartmentId?page=$page&size=$size', appliedFilters
          // {
          //   "filters": [
          //     {"field": "transactionType", "value": "BILL", "operator": "EQUAL_TO"},
          //   ]
          // },
          );
      print('response::::: $appliedFilters ${response.body}');
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
