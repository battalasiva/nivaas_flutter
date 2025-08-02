import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class PurchasePlanPaymentDataSource {
  final ApiClient apiClient;

  PurchasePlanPaymentDataSource({required this.apiClient});

  Future<Map<String, dynamic>> purchasePlanPayment(String apartmentId, int months,String paymentId) async {
    final endpoint = "${ApiUrls.purchasePlanPayment}/$apartmentId?months=$months&paymentId=$paymentId";
    final response = await apiClient.post(endpoint, {});
    debugPrint("RESPONSE : ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        'message': data['message'],
        'isError': false,  
      };
    } else {
      final errorData = jsonDecode(response.body);
      final errorCode = errorData['errorCode'] ?? 'Unknown error';
      final errorMessage = errorData['errorMessage'] ?? 'Unknown error';

      return {
        'message': errorMessage,
        'isError': true, 
      };
    }
  }
}
