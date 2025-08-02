import 'dart:convert';

import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/constants/api_urls.dart';
import '../../../../../core/error/exception_handler.dart';
import '../../../../models/security/guest_invite_entries_model.dart';

class GateActivitiesDatasource {
  final ApiClient apiClient;

  GateActivitiesDatasource({required this.apiClient});

  Future<GuestInviteEntriesModel> fetchCheckinHistory(int apartmentId, String status, int pageNo, int pageSize) async{
    late String checkinHistoryUrl;
    if (status == 'Pending') {
      checkinHistoryUrl = ApiUrls.checkinHistory(apartmentId, 'SECURITY_REQUESTED', pageNo, pageSize);
    } else if (status == 'Approved') {
      checkinHistoryUrl = ApiUrls.checkinHistory(apartmentId, 'APPROVED', pageNo, pageSize);
    } else if (status == 'Declined') {
      checkinHistoryUrl = ApiUrls.checkinHistory(apartmentId, 'DECLINED', pageNo, pageSize);
    }

    try {
      print(checkinHistoryUrl);
      final response = await apiClient.get(checkinHistoryUrl);
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