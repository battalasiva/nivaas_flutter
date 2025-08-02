import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class ProfilePicDataSource {
  final ApiClient _apiClient;

  ProfilePicDataSource({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<bool> uploadProfilePicture(File image) async {
    try {
      final String imagePath = image.path;
      final String fileName = imagePath.split('/').last;

      // Prepare multipart data
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('access-mgmt/user/upload'), // Relative path for ApiClient
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'profilePicture',
          imagePath,
          filename: fileName,
        ),
      );

      // Send the multipart request via ApiClient
      final http.Response response = await _apiClient.postMultipart(
        'access-mgmt/user/upload',
        request,
      );
      // Handle response
      if (response.statusCode == 200) {
        print('Profile picture uploaded successfully');
        print(response.body);
        return true;
      } else {
       throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
        throw ExceptionHandler.handleError(e);

    }
  }
}
