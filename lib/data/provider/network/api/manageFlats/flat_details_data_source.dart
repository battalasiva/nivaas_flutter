import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/models/manageFlats/flat_details_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/error/exception_handler.dart';

class FlatDetailsDataSource {
  final ApiClient apiClient;
  final Logger logger = Logger();

  FlatDetailsDataSource({required this.apiClient});

  Future<FlatDetailsModel> saveFlatDetails(
      int flatId, FlatDetailsModel flatDetails) async {
    final flatDetailsUrl = ApiUrls.postFlatDetails(flatId);
    try {
      print('------before post api - ${flatDetails.toJson()}');
      final response =
          await apiClient.post(flatDetailsUrl, flatDetails.toUpdateJson());
      logger.i('flat details response: ${response.body}');
      if (response.statusCode == 200) {
        // return jsonDecode(response.body);
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        return FlatDetailsModel.fromJson(responseJson);
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<FlatDetailsModel> fetchFlatDetails(int flatId) async {
    final getFlatDetailsUrl = ApiUrls.getFlatDetails(flatId);
    try {
      final response = await apiClient.get(getFlatDetailsUrl);
      logger.i('fetch flat details response: ${response.body}');
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        return FlatDetailsModel.fromJson(responseJson);
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
