import 'dart:convert';

import 'package:nivaas/data/models/gateManagement/visitors_history_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/constants/api_urls.dart';
import '../../../../../core/error/exception_handler.dart';

class VisitorsHistoryDatasource {
  final ApiClient apiClient;

  VisitorsHistoryDatasource({required this.apiClient});

  Future<List<VisitorsHistoryModel>> fetchVisitorsHistory(int apartmentId, int flatId, int pageNo, int pageSize) async {
    final visitorsHistoryUrl = ApiUrls.visitorsRecentHistory(apartmentId, flatId, pageNo, pageSize);
    print(visitorsHistoryUrl);
    try {
      final response = await apiClient.get(visitorsHistoryUrl);
      print('api response: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = jsonDecode(response.body);
        print('------------ Json response $responseJson');
        List<VisitorsHistoryModel> visitorsHistoryList = [
          VisitorsHistoryModel.fromJson(responseJson)
        ];
        
        return visitorsHistoryList;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}