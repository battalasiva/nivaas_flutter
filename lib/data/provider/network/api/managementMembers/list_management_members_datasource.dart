import 'dart:convert';

import 'package:nivaas/data/models/managementMembers/list_management_members_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/constants/api_urls.dart';
import '../../../../../core/error/exception_handler.dart';

class ListManagementMembersDatasource {
  final ApiClient apiClient;

  ListManagementMembersDatasource({required this.apiClient});

  Future<ListManagementMembersModel> fetchSecuritiesList(int apartmentID) async {
    final ownersListUrl = ApiUrls.securitiesList(apartmentID);
    try {
      final response = await apiClient.get(ownersListUrl);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        print('------------ Json response $responseJson');
        return ListManagementMembersModel.fromJson(responseJson);
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}