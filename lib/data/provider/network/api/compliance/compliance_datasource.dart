import 'dart:convert';

import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/models/compliance/compliance_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/error/exception_handler.dart';

class ComplianceDatasource {
  final ApiClient apiClient;

  ComplianceDatasource({required this.apiClient});

  Future<ComplianceModel> getCompliance(int apartmentId) async {
    try {
      final response = await apiClient.get(ApiUrls.compliances(apartmentId));
      print(response);
      print(response.body);
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        return ComplianceModel.fromJson(responseJson);
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e.toString());
    }
  }

  Future<bool> addCompliance(int apartmentId, List<String> dos, List<String> donts) async{
    final payload = ComplianceModel(dos: dos, donts: donts);
    try {
      final response = await apiClient.put(ApiUrls.compliances(apartmentId), payload.toJson());
      print(response);
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e.toString());
    }
  }

  Future<bool> updateCompliance(int apartmentId, List<String> dos, List<String> donts) async{
    final payload = ComplianceModel(dos: dos, donts: donts);
    try {
      final response = await apiClient.put(ApiUrls.compliances(apartmentId), payload.toJson());
      print(response);
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e.toString());
    }
  }
}