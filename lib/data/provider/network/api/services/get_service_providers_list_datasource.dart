import 'dart:convert';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/services/GetServicesPartnersListmodal.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class GetServiceProvidersListDataSource {
  final ApiClient apiClient;

  GetServiceProvidersListDataSource(this.apiClient);

  Future<List<GetServicePartnersListModel>> fetchServiceProviders(int apartmentId, int categoryId) async {
    try {
      final endpoint = "${ApiUrls.getserviceProvidersList}?apartmentId=$apartmentId&categoryId=$categoryId";
    final response = await apiClient.get(endpoint);
    print('RESPONCE : ${response.body} $endpoint');
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => GetServicePartnersListModel.fromJson(data)).toList();
    } else {
      throw ExceptionHandler.handleHttpException(response);
    }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}