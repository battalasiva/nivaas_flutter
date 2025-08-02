import 'package:nivaas/data/models/manageApartment/add_ownerdetails_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/constants/api_urls.dart';
import '../../../../../core/error/exception_handler.dart';

class AddOwnerDetailsDatasource {
  final ApiClient apiClient;

  AddOwnerDetailsDatasource({required this.apiClient});

  Future<bool>addOwnerDetails(AddOwnerdetailsModel flatDetails, int apartmentId) async{
    try {
      final response = await apiClient.put(ApiUrls.addOwnerDetails(apartmentId), flatDetails.toJson());
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}