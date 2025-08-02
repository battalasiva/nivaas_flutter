import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class LogoutUserDataSource {
  final ApiClient apiClient;

  LogoutUserDataSource(this.apiClient);

  Future<Map<String, dynamic>> logoutUser(String userId) async {
    final endpoint = ApiUrls.logoutUser;
    try {
      final response = await apiClient.post('$endpoint/$userId', {});
      print('Requesting POST to: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Logout successful',
        };
      } else {
        return {
          'success': false,
          'message': 'Logout failed: ${response.reasonPhrase}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }
}
