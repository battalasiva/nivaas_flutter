import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/dues/LastAddedGenerateBill_modal.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class LastAddedGenerateBillDataSource {
  final ApiClient apiClient;

  LastAddedGenerateBillDataSource(this.apiClient);

  Future<dynamic> fetchLastAddedGenerateBill(int apartmentId) async {
    try {
      final endpoint = "${ApiUrls.getLastAddedBill}/$apartmentId";
    final response = await apiClient.get(endpoint);
    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      return LastAddedGenerateBillModal.fromJson(jsonDecode(response.body));
    } else {
      // final errorBody = jsonDecode(response.body);
      // return {
      //   "errorCode": errorBody["errorCode"] ?? response.statusCode,
      //   "errorMessage": errorBody["errorMessage"] ?? "Something went wrong"
      // };
      throw ExceptionHandler.handleHttpException(response);

    }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
