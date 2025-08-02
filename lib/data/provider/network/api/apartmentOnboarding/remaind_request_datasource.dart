import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class RemaindRequestDataSource {
  final ApiClient apiClient;

  RemaindRequestDataSource({required this.apiClient});

  Future<String> remindRequest(
      String apartmentId, String flatId, String onboardingId) async {
    try {
      final endpoint =
        "${ApiUrls.remaindRequest}/$apartmentId?onboardingId=$onboardingId";

    final response = await apiClient.post(endpoint, {});
    print('REMAIND RERSPONCE : ${response.body} $endpoint');
    if (response.statusCode == 200) {
      final data = response.body;
      print('REMAIND DATA: $data');
      return 'Remainded Successfully';
    } else {
     throw ExceptionHandler.handleHttpException(response);
    }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
