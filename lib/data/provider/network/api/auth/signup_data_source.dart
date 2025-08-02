import 'dart:async';
import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';

import '../../service/api_client.dart';

class SignupDataSource {
  final ApiClient apiClient;
  final Logger logger = Logger();

  SignupDataSource({required this.apiClient});

  Future<String> sendOtp(String mobileNumber) async {
    logger.i('Sending OTP to mobile number: $mobileNumber');
    try {
      final response = await apiClient.post(
        ApiUrls.signup,
        {
          "otpType": "SIGNIN",
          'primaryContact': mobileNumber,
        },
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
      throw ExceptionHandler.handleError(e, source: 'auth');
    }
  }

  Future<void> verifyOtp(String name, String mobileNumber, String otp) async {
    final response = await apiClient.post(
      ApiUrls.login,
      {'fullName': name, 'primaryContact': mobileNumber, 'otp': otp},
    );

    logger.d('Response Status: ${response.statusCode}');
    logger.d('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['token'] != null && data['refreshToken'] != null) {
        await apiClient.saveTokens(data['token'], data['refreshToken']);
        logger.i('Tokens saved successfully');
      } else {
        throw Exception('No tokens in response');
      }
    } else {
      throw ExceptionHandler.handleHttpException(response, source: 'auth');
    }
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}
