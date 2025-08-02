import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class EditNoticeDataSource {
  final ApiClient apiClient;

  EditNoticeDataSource({required this.apiClient});

  Future<void> editNotice(
      int noticeId, String title, String body, int apartmentId) async {
    try {
      final endpoint = ApiUrls.postNotice;
      print('POST Request Endpoint: $endpoint');
      final response = await apiClient.post(endpoint, {
        'id': noticeId,
        'title': title,
        'body': body,
        'apartmentId': apartmentId,
      });
      if (response.statusCode == 200) {
        print('EDIT POST SUCCESS  ${response.body}');
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
