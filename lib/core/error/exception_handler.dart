import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() {
    return message;
  }
}

class NetworkException extends AppException {
  NetworkException([super.message = "No Internet Connection"]);
}

class ServerException extends AppException {
  ServerException([super.message = "Server Error Occurred"]);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([super.message = "Unauthorized Access"]);
}

class NotFoundException extends AppException {
  NotFoundException([super.message = "Resource Not Found"]);
}

class ApiException extends AppException {
  ApiException([super.message = ""]);
}

class ExceptionHandler {
  static AppException handleError(dynamic error, {String source = ''}) {
    if (error is SocketException) {
      return NetworkException("No Internet Connection.Please check your network settings and try again.");
    } else if (error is ClientException) {
      return NetworkException("Failed to lookup host: ${error.message}");
    } else if (error is http.Response) {
      return handleHttpException(error);
    } else {
      return ApiException(error.toString());
    }
  }

  static AppException handleHttpException(http.Response response, {String source = ''}) {
    String errorMessage = _parseErrorMessage(response, source);
    switch (response.statusCode) {
      case 400:
        return ApiException(errorMessage);
      case 401:
        return UnauthorizedException(errorMessage);
      case 403:
        return UnauthorizedException(errorMessage);
      case 404:
        return NotFoundException(errorMessage);
      case 502:
        return ServerException(errorMessage);
      case 522:
        return ServerException(errorMessage);
      case 503:
        return ServerException(errorMessage);
      case 500 :
        return ServerException("Internal Server Exception");
      default:
        return ApiException(errorMessage);
    }
  }

  static String _parseErrorMessage(http.Response response, String source){
    try {
      final body = jsonDecode(response.body);
      if (body is Map) {
        if (body.containsKey('errorMessage')) {
          return source == 'auth'? response.body : body['errorMessage'] ;
        } else if (body.containsKey('message')) {
          return body['message'];
        } else if (body.containsKey('error')) {
          return body['error'];
        }
      }
      return ""; 
    } catch (_) {
      return "";  
    }
  }
}
