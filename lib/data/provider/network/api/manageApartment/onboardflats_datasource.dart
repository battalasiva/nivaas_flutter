import 'package:logger/logger.dart';
import 'package:nivaas/data/models/manageApartment/onboarding_flat_withdetails_model.dart';

import '../../../../../core/constants/api_urls.dart';
import '../../../../../core/error/exception_handler.dart';
import '../../../../models/manageApartment/onboarding_flat_withoutdetails_model.dart';
import '../../service/api_client.dart';

class OnboardflatsDatasource {
  final ApiClient apiClient;

  OnboardflatsDatasource({required this.apiClient});

  final Logger logger = Logger();

  Future<bool>onBoardFlatsWithDetails(OnboardingFlatWithdetailsModel flatDetails) async{
    try {
      final response = await apiClient.post(ApiUrls.onboardFlatsWithDetails, flatDetails.toJson());
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<bool>onBoardFlatsWithoutDetails(OnboardingFlatWithoutdetailsModel flatDetails) async{
    try {
      final response = await apiClient.post(ApiUrls.onboardFlatsWithoutDetails, flatDetails.toJson());
      logger.i(flatDetails.toJson());
      logger.i(response.body);
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