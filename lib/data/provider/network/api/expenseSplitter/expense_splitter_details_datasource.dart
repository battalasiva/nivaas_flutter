import 'dart:convert';

import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/models/expenseSplitter/expense_splitter_details_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/error/exception_handler.dart';

class ExpenseSplitterDetailsDatasource {
  final ApiClient apiClient;

  ExpenseSplitterDetailsDatasource({required this.apiClient});

  Future<ExpenseSplitterDetailsModel> getExpenseSplitterDetails(int splitterId) async{
    try {
      final response = await apiClient.get(ApiUrls.getExpenseSplitterDetails(splitterId));
      print('api response: ${response.body}');
      if (response.statusCode == 200) {
         final responseJson = jsonDecode(response.body);
        return ExpenseSplitterDetailsModel.fromJson(responseJson);
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e.toString()); 
    }
  }
}