import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/models/coins-subscription/walletTransaction_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class CoinsWalletDataSource {
  final ApiClient apiClient;

  CoinsWalletDataSource({required this.apiClient});

  Future<WalletTransactionModal> getWalletTransactions({
    required int apartmentId,
    required int pageNo,
    required int pageSize,
  }) async {
    final response = await apiClient.get(
        '${ApiUrls.getWalletTransactions}/$apartmentId?pageNo=$pageNo&pageSize=$pageSize');
    return WalletTransactionModal.fromJson(jsonDecode(response.body));
  }
}
