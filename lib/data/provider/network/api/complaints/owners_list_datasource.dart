import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/complaints/owners_list_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class OwnersDataSource {
  final ApiClient apiClient;

  OwnersDataSource({required this.apiClient});

  Future<List<Data>> fetchOwners(
      int apartmentId, int pageNo, int pageSize) async {
    try {
      final response = await apiClient.get(
        '${ApiUrls.getOwnersList}/$apartmentId/flat-owners?pageNo=$pageNo&pageSize=$pageSize');
        if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body is List) {
        return body.map((e) => Data.fromJson(e)).toList();
      } else if (body is Map && body['data'] != null) {
        return (body['data'] as List).map((e) => Data.fromJson(e)).toList();
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } else {
     throw ExceptionHandler.handleHttpException(response);
    }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
