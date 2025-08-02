import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/complaints/admins_list_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class AdminsDataSource {
  final ApiClient apiClient;

  AdminsDataSource({required this.apiClient});

  Future<List<AdminsListModal>> fetchAdmins(int apartmentId) async {
    try {
      final response =
        await apiClient.get('${ApiUrls.adminList}/$apartmentId');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => AdminsListModal.fromJson(e)).toList();
    } else {
      throw ExceptionHandler.handleHttpException(response);
    }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
