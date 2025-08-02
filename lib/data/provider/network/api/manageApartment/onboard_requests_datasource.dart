import 'package:logger/logger.dart';
import 'package:nivaas/data/models/manageApartment/onboard_requests_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/constants/api_urls.dart';
import '../../../../../core/error/exception_handler.dart';

class OnboardRequestsDatasource {
  final ApiClient apiClient;

  OnboardRequestsDatasource({required this.apiClient});

  final Logger logger = Logger();

  Future<bool>ownerOnboardRequest(OwnerOnboardRequestModel details) async{
    print(details.toJson());
    try {
      final response = await apiClient.post(ApiUrls.ownerOnboardRequest, details.toJson());
      print('Api response: ${response.body}');
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<bool>tenantOnboardRequest(TenantOnboardRequestModel details) async{
    try {
      final response = await apiClient.post(ApiUrls.tenantOnboardRequest, details.toJson());
      print('Api response: ${response.body}');
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<bool>rejectOnboardRequest(int id, int userId) async{
    try {
      final String rejectRequestUrl = ApiUrls.rejectOnboardRequest(id, userId);
      print('reject url $rejectRequestUrl');
      final response = await apiClient.delete(rejectRequestUrl);
      if (response.statusCode == 200) {
        print('-----api success');
        return true;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}