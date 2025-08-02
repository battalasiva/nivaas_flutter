import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/coins-subscription/subscription_plans_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class SubscriptionDataSource {
  final ApiClient _apiClient;

  SubscriptionDataSource({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<SubscriptionPlansModal> fetchSubscriptionPlans(int customerId) async {
    try {
      final endpoint = "customer/jtapartment/subscription/plans/$customerId";

    final http.Response response = await _apiClient.get(endpoint);
    if (response.statusCode == 200) {
      return SubscriptionPlansModal.fromJson(jsonDecode(response.body));
    } else {
      throw ExceptionHandler.handleHttpException(response);
    }
    } catch (e) {
       throw ExceptionHandler.handleError(e);
    }
  }
}
