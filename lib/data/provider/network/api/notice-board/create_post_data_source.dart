import 'package:flutter/material.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class CreatePostDataSource {
  final ApiClient apiClient;

  CreatePostDataSource({required this.apiClient});

  Future<dynamic> createPost(String title, String body, int apartmentId) async {
    try {
      final payload = {
        "title": title,
        "body": body,
        "apartmentId": apartmentId,
      };
      final response =
          await apiClient.post('customer/noticeboard/save', payload);
      if (response.statusCode == 200) {
        debugPrint('response>>>>>>>>>>>>>>>>>: ${response.body}');
        return response.body;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
