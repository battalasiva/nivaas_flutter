import 'dart:convert';

import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/models/expenseSplitter/expense_splitters_list_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

import '../../../../../core/error/exception_handler.dart';

class ExpenseSplittersListDatasource {
  final ApiClient apiClient;

  ExpenseSplittersListDatasource({required this.apiClient});

  Future<List<ExpenseSplittersListModel>> fetchExpenseSplittersList(int apartmentId) async{
    try {
      final response = await apiClient.get(ApiUrls.getExpenseSplitters(apartmentId));
      print('response: ${response.body}');
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<ExpenseSplittersListModel> details = ExpenseSplittersListModel.listFromJson(jsonResponse);
        return details;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e.toString());
    }
  }

  Future<ExpenseSplittersListModel> enableExpenseSplitter(int splitterId,bool isEnabled) async{
    try {
      final response = await apiClient.patch(ApiUrls.enableExpenseSplitterDetails(splitterId,isEnabled), {} );
      print(response);
      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        ExpenseSplittersListModel details = ExpenseSplittersListModel.fromJson(jsonResponse);
        return details;
      } else {
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e.toString());
    }
  }
}