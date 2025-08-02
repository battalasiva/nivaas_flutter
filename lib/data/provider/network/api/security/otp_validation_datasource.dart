import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class OtpValidationDatasource {
  final ApiClient apiClient;

  OtpValidationDatasource({required this.apiClient});

  Future<bool> otpValidation(int requestId, String otp) async{
    final otpValidationUrl = ApiUrls.otpValidation(requestId, otp);
    try {
      final response = await apiClient.put(otpValidationUrl, {});
      print('Api response: ${response.body}');
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