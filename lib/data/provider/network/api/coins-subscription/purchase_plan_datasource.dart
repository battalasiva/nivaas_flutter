import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class PurchasePlanDataSource {
  final ApiClient apiClient;

  PurchasePlanDataSource({required this.apiClient});

  Future<Map<String, dynamic>> purchasePlan(String apartmentId, int months) async {
    final endpoint = "${ApiUrls.purchasePlan}/$apartmentId?months=$months";
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
        'isError': true,  // Mark failure response
      };
    }
  }
}
