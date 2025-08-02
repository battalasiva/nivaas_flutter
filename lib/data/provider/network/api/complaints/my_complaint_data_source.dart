import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/complaints/my_complaints_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class MyComplaintsDataSource {
  final ApiClient apiClient;

  MyComplaintsDataSource({required this.apiClient});

  Future<MyComplaintsModel> fetchComplaints({
    required int apartmentId,
    required int pageNo,
    required int pageSize,
  }) async {
    try {
      final response = await apiClient.get(
      '${ApiUrls.mycomplaints}/$apartmentId?page=$pageNo&size=$pageSize',
    );
    if (response.statusCode == 200) {
      return MyComplaintsModel.fromJson(jsonDecode(response.body));
    } else {
      throw ExceptionHandler.handleHttpException(response);
    }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
