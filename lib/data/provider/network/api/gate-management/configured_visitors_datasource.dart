import 'dart:convert';

import 'package:nivaas/data/models/gateManagement/configured_visitor_invites_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/constants/api_urls.dart';
import '../../../../../core/error/exception_handler.dart';

class ConfiguredVisitorsDatasource {
  final ApiClient apiClient;

  ConfiguredVisitorsDatasource({required this.apiClient});

  Future<ConfiguredVisitorInvitesModel> fetchConfiguredVisitorsHistory(int apartmentId,int flatId, int pageNo, int pageSize) async{
    final String configuredHistoryUrl = ApiUrls.configuredVisitors(apartmentId, flatId, pageNo, pageSize);
    print(configuredHistoryUrl);
    try {
      final response = await apiClient.get(configuredHistoryUrl);
      print('api response: ${response.body}');
      
      if (response.statusCode == 200) {
         final responseJson = jsonDecode(response.body);
        return ConfiguredVisitorInvitesModel.fromJson(responseJson);
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e.toString());
    }
  }
}