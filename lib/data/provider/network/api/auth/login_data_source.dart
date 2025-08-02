import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:nivaas/core/constants/api_urls.dart';

import '../../../../../core/error/exception_handler.dart';
import '../../service/api_client.dart';

class LoginDataSource {
  final ApiClient apiClient;
  final Logger logger = Logger();

  LoginDataSource({required this.apiClient});

  Future<String> sendOtp(String mobileNumber) async {
    logger.i('Sending OTP to mobile number: $mobileNumber');
    try {
      final response = await apiClient.post(
        ApiUrls.signin,
        {"otpType": "SIGNIN", 'primaryContact': mobileNumber},
      );
      logger.d('Response Status: ${response.statusCode}');
      logger.d('Response Body: ${response.body}');

      if (response.statusCode != 200) {
        throw ExceptionHandler.handleHttpException(response, source: 'auth');
      }
      final responseData = jsonDecode(response.body);
      String otp = responseData['otp'] ?? '';
      return otp;
    } catch (e) {
      logger.e(e);
      throw ExceptionHandler.handleError(e, source: 'auth');
    }
  }

  Future<void> verifyOtp(
    String mobileNumber,
    String otp,
  ) async {
    try {
      final response = await apiClient.post(
        ApiUrls.login,
        {
          'primaryContact': mobileNumber,
          'otp': otp,
        },
      );

      logger.d('Response Status: ${response.statusCode}');
      logger.d('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          logger.i(response.body);
          final data = jsonDecode(response.body);
          if (data['token'] != null && data['refreshToken'] != null) {
            await apiClient.saveTokens(data['token'], data['refreshToken']);
            logger.i('Tokens saved successfully');
          } else {
            throw Exception('No tokens in response');
          }
        } else {
          throw Exception('Empty response body');
        }
      } else{
        throw ExceptionHandler.handleHttpException(response, source: 'auth');
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e, source: 'auth');
    }
  }
}

class LoginAuthException implements Exception {
  final String message;
  LoginAuthException(this.message);

  @override
  String toString() => message;
}

class AccountNotFoundException implements Exception {
  final String message;
  AccountNotFoundException(this.message);

  @override
  String toString() {
    return message;
  }
}
