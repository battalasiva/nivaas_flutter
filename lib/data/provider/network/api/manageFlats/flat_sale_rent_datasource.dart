import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/error/exception_handler.dart';

class FlatSaleRentDatasource {
  final ApiClient apiClient;

  FlatSaleRentDatasource({required this.apiClient});

  Future<bool>postFlatForSale(int flatId, bool isSale ) async{
    try {
      final postflatForSaleUrl = ApiUrls.flatForSale(flatId, isSale);
      final response = await apiClient.post(postflatForSaleUrl,{});
      print('-----Api response: ${response.body}');
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<bool>postFlatForRent(int flatId, bool isRent) async{
    try {
      final postFlatForRentUrl = ApiUrls.flatForRent(flatId, isRent);
      final response = await apiClient.post(postFlatForRentUrl,{});
      print('-----Api response: ${response.body}');
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