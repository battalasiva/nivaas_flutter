import 'dart:io';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class GetPdfDataSource {
  final ApiClient apiClient;

  GetPdfDataSource({required this.apiClient});

  Future<String> fetchPdf(int apartmentId, int year, int month) async {
    try {
      final endpoint = '${ApiUrls.pdf}/$apartmentId/year/$year/month/$month';
      final response = await apiClient.get(endpoint);

      print('ENDPOINT : $endpoint');
      if (response.statusCode == 200) {
        print('RESPONCE PDF : PDF data received');
        try {
          final directory = await getApplicationDocumentsDirectory();
          final filePath =
              '${directory.path}/report_${year}_$month.pdf';
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes, flush: true);
          print('PDF saved to: $filePath');
          await OpenFilex.open(filePath);
          return filePath;
        } catch (e) {
          throw Exception('Failed to save or open PDF: $e');
        }
      } else {
        print('Failed to fetch PDF. Status Code: ${response.statusCode}');
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
