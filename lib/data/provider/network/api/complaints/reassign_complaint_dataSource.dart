import 'package:http/http.dart' as http;
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class ReassignComplaintDataSource {
  final ApiClient apiClient;

  ReassignComplaintDataSource({required this.apiClient});

  Future<bool> reassignComplaint({
    required int id,
    required String status,
    required String assignedTo,
    bool? isAdmin,
  }) async {
    try {
      String endpoint = "${ApiUrls.reassignComplaint}/$id?status=$status";
    if (isAdmin == true) {
      endpoint += "&&assignedTo=$assignedTo";
    }
    final response = await apiClient.put(endpoint, {});
    print("response: ${response.body}");
    if (response.statusCode == 200) {
      return true;
    } else {
       throw ExceptionHandler.handleHttpException(response);
    }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
