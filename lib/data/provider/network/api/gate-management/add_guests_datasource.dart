import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/gate-management/CreateInviteModel.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class AddGuestsDataSource {
  final ApiClient apiClient;

  AddGuestsDataSource(this.apiClient);

  Future<CreateInviteModel> addGuest(Map<String, dynamic> payload) async {
    try {
      final response = await apiClient.post(ApiUrls.addGuest, payload);
      final data = jsonDecode(response.body);
      print('payload: $payload');
      print('api response: ${response.body}');

      if (response.statusCode == 200) {
        return CreateInviteModel.fromJson(data);
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
