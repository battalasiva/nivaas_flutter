import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class PostMeterReadingsDataSource {
  final ApiClient apiClient;

  PostMeterReadingsDataSource(this.apiClient);

  Future<String> postMeterReading(Map<String, dynamic> payload) async {
    try {
      final endpoint = ApiUrls.updateReadings;
      final response = await apiClient.post(endpoint, payload);
      print("RESSS : ${response.body} ${endpoint} ${payload}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['message'];
      } else {
        final errorData = jsonDecode(response.body);
        if (errorData['errorCode'] == 1028) {
          return errorData['errorMessage'];
        } else if(errorData['errorCode'] == 1049){
          return errorData['errorMessage'];
        }else if(errorData['errorCode'] == 1054){
          return errorData['errorMessage'];
        }else{
          return (response.body);
        }
        // throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
