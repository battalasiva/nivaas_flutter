
import 'package:logger/logger.dart';
import 'package:nivaas/data/models/manageApartment/flatmembers_details_model.dart';

import '../../../../../core/constants/api_urls.dart';
import '../../../../../core/error/exception_handler.dart';
import '../../service/api_client.dart';

class FlatmembersDetailsDatasource {
  final ApiClient apiClient;

  FlatmembersDetailsDatasource({required this.apiClient});

  final Logger logger = Logger();

  Future<void>updateFlatMemberDetails(FlatmembersDetailsModel details, int apartmentId, int flatId) async{
    try {
      final response = await apiClient.post(ApiUrls.editmemberDetails(apartmentId, flatId), details.toJson());
      print(ApiUrls.editmemberDetails(apartmentId, flatId));
      print('-----------api response : ${response.body}, ${response.statusCode}');
      if (response.statusCode == 200) {
        print('response is success');
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<bool>removeMember(int relatedUserId, int onboardingRequestId) async{
    try {
      final String removeMemberUrl = ApiUrls.removemember(relatedUserId, onboardingRequestId);
      final response = await apiClient.delete(removeMemberUrl);
      print('-----------api response : ${response.body}');
      if (response.statusCode == 200) {
        print('-----api success');
        return true;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

}