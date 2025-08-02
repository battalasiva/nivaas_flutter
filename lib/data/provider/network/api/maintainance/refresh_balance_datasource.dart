import 'dart:convert';

import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class RefreshBalanceDataSource {
  final ApiClient apiClient;

  RefreshBalanceDataSource(this.apiClient);

  Future<String> refreshBalance(int apartmentId) async {
    try {
      final response = await apiClient.post(
        '${ApiUrls.refreshBalance}/$apartmentId/refresh',
        {},
      );
      print('RESPONCE : ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Balance refreshed successfully';
      } else {
        throw Exception('Failed to refresh balance: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error refreshing balance: $e');
    }
  }
}
