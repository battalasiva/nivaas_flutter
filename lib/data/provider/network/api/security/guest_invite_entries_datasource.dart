import 'dart:convert';

import 'package:nivaas/data/models/security/guest_invite_entries_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/constants/api_urls.dart';
import '../../../../../core/error/exception_handler.dart';

class GuestInviteEntriesDatasource {
  final ApiClient apiClient;

  GuestInviteEntriesDatasource({required this.apiClient});

  Future<GuestInviteEntriesModel> fetchGuestInviteEntries(int apartmentId, int pageNo, int pageSize) async{
    try {
      final response = await apiClient.get(ApiUrls.guestInviteEntries(apartmentId, pageNo, pageSize));
      print('api response: ${response.body}');
      
      if (response.statusCode == 200) {
         final responseJson = jsonDecode(response.body);
        return GuestInviteEntriesModel.fromJson(responseJson);
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e.toString());
    }
  }
}