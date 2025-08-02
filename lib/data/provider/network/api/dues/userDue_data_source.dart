import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/dues/userDue_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class UserDuesDataSource {
  final ApiClient apiClient;

  UserDuesDataSource({required ApiClient apiClient}) : apiClient = apiClient;

  Future<List<UserDuesModal>> fetchUserDues({
    required int apartmentId,
    required int flatId,
    required int year,
    required int month,
  }) async {
    try {
      final endpoint =
          "${ApiUrls.getUserDues}/$apartmentId/flat/$flatId?year=$year&month=$month";
      print('{endpoint:$endpoint}');
      final response = await apiClient.get(endpoint);
      print('RESPONCE : ${response.body}');
      if (response.statusCode == 200) {
        return UserDuesModal.fromJsonList(jsonDecode(response.body));
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
