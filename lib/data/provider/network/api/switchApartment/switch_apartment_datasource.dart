import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/models/switchApartment/switch_apartment_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/error/exception_handler.dart';

class SwitchApartmentDatasource {
  final ApiClient apiClient;
  final Logger logger = Logger();

  SwitchApartmentDatasource({required this.apiClient});

  Future<List<ApartmentModel>> fetchApartments() async {
    try {
      final response = await apiClient.get(ApiUrls.apartmentList);
      logger.i(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ApartmentModel.fromJson(json)).toList();
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<void> setCurrentFlatDetails(int apartmentId, int flatId) async {
    try {
      final setCurrentFlatUrl = ApiUrls.setCurrentFlat(apartmentId, flatId);
      print('---------$setCurrentFlatUrl');
      final response = await apiClient.put(setCurrentFlatUrl, {});
      print('-----------Api response : ${response.body}');

      if (response.statusCode != 200) {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<void> setCurrentApartment(int userId, int apartmentId) async{
    try {
      final setCurrentApartmentUrl = ApiUrls.setCurrentApartment(userId, apartmentId);
      print('current apartent url $setCurrentApartmentUrl');
      final response = await apiClient.put(setCurrentApartmentUrl, {});
      print('-----------Api response : ${response.body}');

      if (response.statusCode != 200) {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
