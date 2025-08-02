import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class EditSplitterDetailsDatasource {
  ApiClient apiClient = ApiClient();
  EditSplitterDetailsDatasource({required this.apiClient});
  Future<void> putEditSplitterDetails(int id, Map<String, dynamic> payload) async {
    final endpoint = '${ApiUrls.editExpenseSplitter}/$id';
    try {
      final response = await apiClient.put(endpoint, payload);
      print("Response: $endpoint ${response.statusCode} ${response.body} $id $payload ");
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception("Failed to update ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Datasource Error: $e");
    }
  }
}