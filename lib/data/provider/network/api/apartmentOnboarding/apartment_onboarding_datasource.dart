import 'dart:io';

import 'package:logger/logger.dart';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/models/apartmentOnboarding/apartment_onboard_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/error/exception_handler.dart';

class ApartmentOnboardingDatasource {
  final ApiClient apiClient;

  ApartmentOnboardingDatasource({required this.apiClient});

  final Logger logger = Logger();

  Future<bool>sendApartmentDetails(ApartmentOnboard apartment) async{
    try {
      final apartmentData = apartment.toJson();
      logger.i(apartmentData);
      final response = await apiClient.post(ApiUrls.apartmentOnboarding, apartmentData);
      if (response.statusCode == 200) {
        return true;
      } else {
        // throw Exception('Failed to post apartment details: ${response.body}');
        throw ExceptionHandler.handleHttpException(response);
      }
    }  catch (e) {
      // throw Exception('error: $e');
      // throw ApiException("Failed to onboard apartment: ${e.toString()}");
      throw ExceptionHandler.handleError(e);
    }
  }
}