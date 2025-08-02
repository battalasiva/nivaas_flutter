import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/models/search-community/flat_list_model.dart';

import '../../../../../core/error/exception_handler.dart';
import '../../service/api_client.dart';

class FlatDataSource {
  final ApiClient apiClient;
  final Logger logger = Logger();

  FlatDataSource(this.apiClient);

  Future<FlatListModel> fetchFlats(
      String memberType, int apartmentId, int pageNo, int pageSize) async {
    Map<String, dynamic> payload;

    if (memberType == 'Tenant') {
      payload = {
        "fullText": "",
        "filters": [
          {"field": "approved", "value": true, "operator": "EQUAL_TO"}
        ]
      };
    } else {
      payload = {"fullText": ""};
    }

    final flatListUrl = ApiUrls.flatList(apartmentId, pageNo, pageSize);
    logger.i('apartment id: $apartmentId');
    try {
  final response = await apiClient.post(flatListUrl, payload);
  logger.i('response: ${response.body}');
  
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
      return FlatListModel.fromJson(data);
  } else {
    throw ExceptionHandler.handleHttpException(response);
  }
  } catch (e) {
    throw ExceptionHandler.handleError(e);
  }
  }

  Future<bool> sendRequest(String memberType, int flatId) async {
    Map<String, dynamic> payload;

    if (memberType == 'Tenant') {
      payload = {
        "flatId": flatId,
        "relatedType": "TENANT",
      };
      try {
        final response =
            await apiClient.post(ApiUrls.tenantOnboarding, payload);
        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          return responseBody['status'] == 'success';
        } else {
          throw ExceptionHandler.handleHttpException(response);
        }
      } catch (e) {
        throw ExceptionHandler.handleError(e);
      }
    } else {
      payload = {
        "flatId": flatId,
        "type": "FLAT",
      };
      try {
        final response = await apiClient.post(ApiUrls.ownerOnboarding, payload);
        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          return responseBody['status'] == 'success';
        } else {
          throw ExceptionHandler.handleHttpException(response);
        }
      } catch (e) {
        throw ExceptionHandler.handleError(e);
      }
    }
  }
}
