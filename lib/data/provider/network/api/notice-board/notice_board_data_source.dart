import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/notice-board/noticeBoard_Model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class NoticeBoardDataSource {
  final ApiClient apiClient;

  NoticeBoardDataSource({required this.apiClient});

  Future<NoticeBoardModal> fetchNotices(
      int apartmentId, int pageNo, int pageSize) async {
    try {
      final endpoint =
          '${ApiUrls.getNotices}/$apartmentId?pageNo=$pageNo&pageSize=$pageSize';
      print('endpoint: $endpoint');
      final response = await apiClient.get(endpoint);
      if (response.statusCode == 200) {
        return NoticeBoardModal.fromJson(json.decode(response.body));
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
