import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/dues/admin_due_model.dart';

import 'package:nivaas/data/provider/network/service/api_client.dart';

class AdminDuesDataSource {
  final ApiClient apiClient;

  AdminDuesDataSource({required this.apiClient});

  Future<List<AdminDuesModal>> fetchAdminDues(
      int apartmentId, int year, int month) async {
    try {
      final endpoint =
          '${ApiUrls.getAdminDues}/$apartmentId/$year/$month?pageNo=0&pageSize=50';
      print(endpoint);
      final response = await apiClient.get(endpoint);
      print('responsebody: ${response.body} $endpoint');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((json) => AdminDuesModal.fromJson(json)).toList();
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
