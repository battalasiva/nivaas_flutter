import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/manageApartment/flats_model.dart';
import 'package:nivaas/data/models/manageApartment/flats_without_details_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class AllFlatsDatasource {
  final ApiClient apiClient;
  final Logger logger = Logger();

  AllFlatsDatasource({required this.apiClient});

  Future <List<FlatsModel>> getFlats(int apartmentId) async{
    final getFlatsUrl = ApiUrls.getFlats(apartmentId);
    logger.i(getFlatsUrl);
    try {
      final response = await apiClient.get(getFlatsUrl);
      logger.i('fetch flats response: ${response.body}');
      if (response.statusCode == 200) {
        List<dynamic> responseJson = jsonDecode(response.body);
        return responseJson.map((item)=>FlatsModel.fromJson(item)).toList();
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  Future <FlatsWithoutDetailsModel> getFlatsWithoutDetails(int apartmentId,int pageNo, int pageSize) async{
    final getFlatsUrl = ApiUrls.getFlatsWithoutDetails(apartmentId,pageNo, pageSize);
    logger.i(getFlatsUrl);
    try {
      final response = await apiClient.get(getFlatsUrl);
      logger.i('fetch flats without details response: ${response.body}');
      if (response.statusCode == 200) {
         final responseJson = jsonDecode(response.body);
      // final List<dynamic> flatsList = responseJson['data'];
      // return flatsList.map((item) => Data.fromJson(item)).toList();
      final flatsWithoutDetailsModel = FlatsWithoutDetailsModel.fromJson(responseJson);

      return flatsWithoutDetailsModel;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  Future <List<FlatsModel>> getFlatmembers(int apartmentId, int flatId) async{
    final getFlatMembersUrl = ApiUrls.getFlatmembers(apartmentId, flatId);
    logger.i(getFlatMembersUrl);
    try {
      final response = await apiClient.get(getFlatMembersUrl);
      logger.i('fetch flat members response: ${response.body}');
      if (response.statusCode == 200) {
        List<dynamic> responseJson = jsonDecode(response.body);
        return responseJson.map((item)=>FlatsModel.fromJson(item)).toList();
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}