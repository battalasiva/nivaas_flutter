import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/models/managementMembers/coAdmin/add_coadmin_model.dart';
import 'package:nivaas/data/models/managementMembers/coAdmin/owners_list_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/error/exception_handler.dart';
import '../../../../models/managementMembers/security/add_security_model.dart';


class AddManagementMembersDatasource {
  final ApiClient apiClient;

  AddManagementMembersDatasource({required this.apiClient});

  final Logger logger = Logger();

  Future<bool>addCoAdmin(AddCoAdminModel details) async{
    print('---------------- $details');
    try {
      final coAdminDetails = details.toJson();
      logger.i(details);
      final response = await apiClient.post(ApiUrls.addCoAdmin, coAdminDetails);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    }  catch (e) {
      print('------------$e');
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<OwnersListModel> fetchOwnersList(int apartmentID) async {
    final ownersListUrl = ApiUrls.ownersList(apartmentID);
    try {
      final response = await apiClient.get(ownersListUrl);
      logger.i('fetch flat details response: ${response.body}');
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        print('------------ Json response $responseJson');
        return OwnersListModel.fromJson(responseJson);
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<bool>addSecurity(AddSecurityModel details) async{
    print('---------------- $details');
    try {
      final securityDetails = details.toJson();
      final response = await apiClient.post(ApiUrls.addSecurity, securityDetails);
      print('Api response: $response');
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    }  catch (e) {
      print('------------$e');
      throw ExceptionHandler.handleError(e);
    }
  }
}