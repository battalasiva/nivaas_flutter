import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/models/auth/current_customer_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/error/exception_handler.dart';

class UserDataSource {
  final ApiClient apiClient;
  final Logger logger = Logger();

  UserDataSource({required this.apiClient});

  Future<CurrentCustomerModel> getUserDetails() async {
    try {
      final response = await apiClient.get(ApiUrls.currentCustomer);
      logger.i("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = CurrentCustomerModel.fromJson(data);
        logger.i(user);
        return user;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      logger.e("Error: $e");
      throw ExceptionHandler.handleError(e);
    }
  }
}
