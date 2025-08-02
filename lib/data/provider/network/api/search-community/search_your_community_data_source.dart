import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/models/search-community/apartment_model.dart';
import 'package:nivaas/data/models/search-community/city_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/error/exception_handler.dart';

class SearchYourCommunityDataSource {
  final ApiClient apiClient;
  final Logger logger = Logger();

  SearchYourCommunityDataSource({required this.apiClient});

  Future<List<Content>> selectCity(String query, int pageNo, int pageSize) async {
    try {
      final response = await apiClient.post(
        ApiUrls.city(pageNo, pageSize),
        {'fullText': query},
      );
      logger.i("API Response: ${response.body}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final citiesData = data['content'] ?? [];
        return citiesData
            .map<Content>((json) => Content.fromJson(json))
            .toList();
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      logger.e("Error in select city: $e");
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<List<ApartmentContent>> selectApartment(
      String query, int cityId, int pageNo, int pageSize) async {
    try {
      final apartmentUrl = ApiUrls.apartment(cityId, pageNo, pageSize);
      print("Apartment API URL: $apartmentUrl");
      final response = await apiClient.post(
        apartmentUrl,
        {'fullText': query},
      );

      logger.i("API Response: ${response.body}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final citiesData = data['content'] ?? [];
        return citiesData
            .map<ApartmentContent>((json) => ApartmentContent.fromJson(json))
            .toList();
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      logger.e("Error in select apartment: $e");
      throw ExceptionHandler.handleError(e);
    }
  }
}
