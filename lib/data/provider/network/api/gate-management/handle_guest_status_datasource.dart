import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/gate-management/ApproveDeclineGuestModel.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';


class HandleGuestStatusDataSource {
  final ApiClient apiClient;

  HandleGuestStatusDataSource(this.apiClient);

  Future<ApproveDeclineGuestModel> getGuestStatus({
    required int apartmentId,
    required int flatId,
    required String status,
  }) async {
    final endpoint = "${ApiUrls.guestStatus}/$apartmentId/flat/$flatId?status=$status";

    try {
      final response = await apiClient.get(endpoint);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApproveDeclineGuestModel.fromJson(data);
      } else {
       throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
