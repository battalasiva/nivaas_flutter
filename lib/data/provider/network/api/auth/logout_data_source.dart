import 'package:nivaas/data/provider/network/service/api_client.dart';

class LogoutDataSource {
  final ApiClient apiClient;

  LogoutDataSource({required this.apiClient});

  Future<void> logOut() async {
    // return await apiClient.deleteAccessToken();
  }
}