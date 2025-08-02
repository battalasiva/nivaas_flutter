import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:nivaas/core/constants/api_urls.dart';

class ApiClient {
  static const _baseUrl = ApiUrls.baseUrl;
  static final ApiClient _instance = ApiClient._internal();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String _refreshTokenEndpoint = ApiUrls.refreshToken;

  final String _accessTokenKey = 'token';
  final String _refreshTokenKey = 'refreshToken';
  final Logger logger = Logger();

  ApiClient._internal();

  factory ApiClient() => _instance;

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
    debugPrint('TOKENS_SAVED');
  }

  Future<String?> getAccessToken() async {
    final accessToken = await _secureStorage.read(key: _accessTokenKey);
    logger.i("Fetched Access Token: $accessToken");
    return accessToken;
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  Future<bool> refreshAccessToken() async {
    final url = Uri.parse('$_baseUrl$_refreshTokenEndpoint');
    String? refreshToken = await _secureStorage.read(key: _refreshTokenKey);
    if (refreshToken == null) {
      logger.i("Error: Refresh token is missing.");
      return false;
    }

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'grant_type': 'refreshToken',
          'refreshToken': refreshToken,
        }),
      );
      logger.i("Request Body: ${jsonEncode({
            'grant_type': 'refresh_token',
            'refresh_token': refreshToken,
          })}");

      logger.i("Refresh Token API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _secureStorage.write(key: _accessTokenKey, value: data['token']);
        await _secureStorage.write(
            key: _refreshTokenKey, value: data['refreshToken']);
        return true;
      } else {
        logger
            .e("Failed to refresh token. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      logger.e("Error during token refresh: $e");
      return false;
    }
  }

  Future<http.Response> _sendRequestWithAuth(
      Future<http.Response> Function(Map<String, String> headers)
          request) async {
    String? accessToken = await _secureStorage.read(key: _accessTokenKey);
    logger.i("Access Token: $accessToken");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
    };
    http.Response response = await request(headers);
    if (response.statusCode == 401) {
      logger.i("Access token expired, attempting to refresh...");
      bool tokenRefreshed = await refreshAccessToken();
      if (tokenRefreshed) {
        accessToken = await _secureStorage.read(key: _accessTokenKey);
        headers['Authorization'] = 'Bearer $accessToken';
        response = await request(headers);
      }
    }
    return response;
  }

  Future<http.Response> get(String endpoint,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    return _sendRequestWithAuth((headers) => http.get(url, headers: headers));
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    return _sendRequestWithAuth((headers) => http.post(
          url,
          headers: headers,
          body: jsonEncode(data),
        ));
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    return _sendRequestWithAuth((headers) => http.put(
          url,
          headers: headers,
          body: jsonEncode(data),
        ));
  }

  Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    return _sendRequestWithAuth((headers) => http.delete(
          url,
          headers: headers,
        ));
  }

  Future<http.Response> patch(String endpoint, Map<String, dynamic> data) async {
  final url = Uri.parse('$_baseUrl$endpoint');
  return _sendRequestWithAuth((headers) => http.patch(
        url,
        headers: headers,
        body: jsonEncode(data),
      ));
}

  Future<http.Response> postMultipart(
      String endpoint, http.MultipartRequest originalRequest) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final request = http.MultipartRequest(originalRequest.method, url)
      ..fields.addAll(originalRequest.fields)
      ..files.addAll(originalRequest.files);

    return _sendRequestWithAuth((headers) async {
      request.headers.addAll(headers);
      final streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    });
  }

  Future<void> logout() async {
    try {
      await _secureStorage.delete(key: _accessTokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
      await _secureStorage.deleteAll();
      logger.i("User logged out and tokens cleared.");
    } catch (e) {
      logger.e("Error during logout: $e");
    }
  }
}
