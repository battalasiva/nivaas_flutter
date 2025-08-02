import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class EditProfileDataSource {
  final ApiClient apiClient;

  EditProfileDataSource({required this.apiClient});

  Future<Response> updateProfile({
    required int id,
    required Map<String, dynamic> data,
  }) async {
    try {
      final endpoint = ApiUrls.editprofile;
      print('Requesting PUT to:  $endpoint with data: $data');
      final response = await apiClient.put(endpoint, data);
      debugPrint('>>>>>>>>>>>>${response.body}');
      if (response.statusCode == 200) {
        print('Profile updated successfully!');
        return response;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
